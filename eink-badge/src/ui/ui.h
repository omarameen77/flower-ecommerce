#pragma once
#include <Arduino.h>
#include "../core/config.h"
#include "../core/event_bus.h"
#include "../core/language.h"
#include "../core/storage.h"
#include "../drivers/display.h"
#include "../drivers/audio.h"
#include "../features/ble.h"
#include "../features/battery.h"

// ── Menu items (order must match MenuItem enum) ────────────
static const char* MENU_LABELS[] = {
    "Badge Name", "WiFi", "BLE", "Display",
    "Audio", "OTA Update", "Info", "Language"
};
static const uint8_t MENU_COUNT = static_cast<uint8_t>(MenuItem::COUNT);

class UI {
public:
    static UI& instance() {
        static UI u;
        return u;
    }

    void begin(BadgeSettings* settings) {
        _settings = settings;
        SUBSCRIBE(Event::GestureDetected, [](Event, void* d) {
            auto* ge = (GestureEvent*)d;
            instance().handleGesture(ge->gesture);
        });
        showWelcome();
    }

    void update() {
        if (!_state.needsRedraw) return;

        switch (_state.currentScreen) {
            case Screen::Badge:
                drawBadgeScreen();
                break;
            case Screen::Menu:
                drawMenuScreen();
                break;
            case Screen::BadgeName:
                drawTextInputScreen("Badge Name", _settings->badgeName);
                break;
            case Screen::WiFi:
                drawInfoScreen();
                break;
            case Screen::BLE:
                drawBleScreen();
                break;
            case Screen::Display:
                drawDisplaySettings();
                break;
            case Screen::Audio:
                drawAudioSettings();
                break;
            case Screen::OTA:
                drawOtaScreen();
                break;
            case Screen::Info:
                drawInfoScreen();
                break;
            case Screen::Language:
                drawLanguageScreen();
                break;
            case Screen::Sleep:
                drawSleepScreen();
                break;
            default:
                break;
        }
        _state.needsRedraw = false;
    }

    void markDirty() { _state.needsRedraw = true; }

    Screen currentScreen() const { return _state.currentScreen; }
    uint32_t lastActivityMs() const { return _state.lastActivity; }

private:
    UI() = default;

    BadgeSettings* _settings = nullptr;
    UIState        _state;
    uint8_t        _editingIndex = 0;

    // ── Welcome ─────────────────────────────────────────────
    void showWelcome() {
        _state.currentScreen = Screen::Welcome;
        disp().drawWelcome(_settings->badgeName, FW_VERSION);
        delay(2000);
        _state.currentScreen = Screen::Badge;
        _state.needsRedraw = true;
    }

    // ── Badge ───────────────────────────────────────────────
    void drawBadgeScreen() {
        disp().drawBadge(_settings->badgeName, batt().percentage(), bleMgr().isRunning());
    }

    // ── Menu ────────────────────────────────────────────────
    void drawMenuScreen() {
        uint8_t total = MENU_COUNT;
        const char* labels[MENU_COUNT];
        for (uint8_t i = 0; i < MENU_COUNT; i++) labels[i] = MENU_LABELS[i];
        disp().drawMenuPage(_state.menuPage, _state.menuIndex, labels, total);
    }

    // ── Badge Name editing ──────────────────────────────────
    void drawTextInputScreen(const char* title, const char* current) {
        disp().drawSettingPage(title, current, TR(Str::TapToSelect));
    }

    // ── BLE settings ────────────────────────────────────────
    void drawBleScreen() {
        clear();
        drawTopBar(TR(Str::BLE));

        uint8_t y = 50;
        drawSettingRow(y, TR(Str::Enabled), _settings->bleEnabled ? TR(Str::On) : TR(Str::Off));
        y += 35;
        drawSettingRow(y, TR(Str::BleWake), _settings->bleWake ? TR(Str::On) : TR(Str::Off));
        y += 35;

        if (bleMgr().isConnected()) {
            disp().drawCenteredText(y, TR(Str::Connected), &FreeMonoBold9pt7b);
        }

        drawBottomHint(TR(Str::TapToSelect));
        disp().partialRefresh();
    }

    // ── Display settings ────────────────────────────────────
    void drawDisplaySettings() {
        clear();
        drawTopBar(TR(Str::Display));

        char buf[16];
        uint8_t y = 50;
        snprintf(buf, sizeof(buf), "%d%%", _settings->brightness);
        drawSettingRow(y, TR(Str::Brightness), buf);
        y += 35;
        snprintf(buf, sizeof(buf), "%ds", _settings->sleepTimeout);
        drawSettingRow(y, TR(Str::SleepTimeout), buf);

        drawBottomHint(TR(Str::TapToSelect));
        disp().partialRefresh();
    }

    // ── Audio settings ──────────────────────────────────────
    void drawAudioSettings() {
        clear();
        drawTopBar(TR(Str::Audio));

        char buf[16];
        uint8_t y = 50;
        snprintf(buf, sizeof(buf), "%d", _settings->volume);
        drawSettingRow(y, TR(Str::Volume), buf);
        y += 35;
        drawSettingRow(y, TR(Str::Enabled), _settings->soundEnabled ? TR(Str::On) : TR(Str::Off));

        drawBottomHint(TR(Str::TapToSelect));
        disp().partialRefresh();
    }

    // ── OTA screen ──────────────────────────────────────────
    void drawOtaScreen() {
        clear();
        drawTopBar(TR(Str::OTAUpdate));
        disp().drawCenteredText(SCREEN_HEIGHT / 2, "OTA Mode...", &FreeMonoBold12pt7b);
        disp().drawCenteredText(SCREEN_HEIGHT / 2 + 30, "Connect to WiFi", &FreeMonoBold9pt7b);
        disp().fullRefresh();
    }

    // ── Language selector ───────────────────────────────────
    void drawLanguageScreen() {
        clear();
        drawTopBar(TR(Str::Language));

        uint8_t y = 50;
        for (uint8_t i = 0; i < lang.langCount(); i++) {
            bool sel = (i == _editingIndex);
            uint16_t bg = sel ? GxEPD_BLACK : GxEPD_WHITE;
            uint16_t fg = sel ? GxEPD_WHITE : GxEPD_BLACK;
            disp().drawRect(10, y - 2, SCREEN_WIDTH - 20, 28, bg, true);
            disp().drawText(16, y + 18, lang.langName(i), &FreeMonoBold9pt7b, fg);
            y += 30;
        }

        drawBottomHint(TR(Str::TapToSelect));
        disp().fullRefresh();
    }

    // ── Info screen ─────────────────────────────────────────
    void drawInfoScreen() {
        clear();
        drawTopBar(TR(Str::Info));

        char line0[64], line1[64], line2[64], line3[64], line4[64];
        snprintf(line0, sizeof(line0), "%s: %s", TR(Str::Version), FW_VERSION);
        snprintf(line1, sizeof(line1), "%s: %d%%", TR(Str::Battery), batt().percentage());
        snprintf(line2, sizeof(line2), "URL1: %s", _settings->url1);
        snprintf(line3, sizeof(line3), "URL2: %s", _settings->url2);
        snprintf(line4, sizeof(line4), "%s: %s", TR(Str::Language), lang.langName(_settings->language));

        const char* lines[] = { line0, line1, line2, line3, line4 };
        disp().drawInfoPage(lines, 5);

        drawBottomHint(TR(Str::SwipeToNavigate));
        disp().partialRefresh();
    }

    // ── Sleep animation ─────────────────────────────────────
    void drawSleepScreen() {
        disp().showSleepAnimation();
        EMIT(Event::EnterSleep, nullptr);
    }

    // ── Gesture handler ─────────────────────────────────────
    void handleGesture(Gesture g) {
        _state.lastActivity = millis();

        if (_state.currentScreen == Screen::Welcome) {
            if (g == Gesture::Tap || g == Gesture::SwipeRight) {
                _state.currentScreen = Screen::Badge;
                _state.needsRedraw = true;
            }
            return;
        }

        if (_state.currentScreen == Screen::Badge) {
            handleBadgeGesture(g);
            return;
        }

        if (_state.currentScreen == Screen::Menu) {
            handleMenuGesture(g);
            return;
        }

        // Settings sub-screens
        handleSettingGesture(g);
    }

    void handleBadgeGesture(Gesture g) {
        switch (g) {
            case Gesture::Tap:
                // Enter menu
                _state.currentScreen = Screen::Menu;
                _state.menuIndex = 0;
                _state.menuPage = 0;
                _state.needsRedraw = true;
                playNav();
                break;
            case Gesture::SwipeLeft:
                // Cycle content page (info)
                _state.currentScreen = Screen::Info;
                _state.needsRedraw = true;
                playNav();
                break;
            case Gesture::SwipeRight:
                // Stay on badge (wrap)
                break;
            case Gesture::LongPress:
                // Sleep
                _state.currentScreen = Screen::Sleep;
                _state.needsRedraw = true;
                playSfx(Audio::SFX_SLEEP);
                break;
            default:
                break;
        }
    }

    void handleMenuGesture(Gesture g) {
        switch (g) {
            case Gesture::SwipeUp:
                if (_state.menuIndex > 0) {
                    _state.menuIndex--;
                } else {
                    _state.menuIndex = MENU_COUNT - 1;
                }
                _state.menuPage = _state.menuIndex / MENU_ITEMS_PER_PAGE;
                _state.needsRedraw = true;
                playNav();
                break;

            case Gesture::SwipeDown:
                if (_state.menuIndex < MENU_COUNT - 1) {
                    _state.menuIndex++;
                } else {
                    _state.menuIndex = 0;
                }
                _state.menuPage = _state.menuIndex / MENU_ITEMS_PER_PAGE;
                _state.needsRedraw = true;
                playNav();
                break;

            case Gesture::Tap:
                selectMenuItem(_state.menuIndex);
                break;

            case Gesture::LongPress:
                // Back to badge
                _state.currentScreen = Screen::Badge;
                _state.needsRedraw = true;
                playBack();
                break;

            default:
                break;
        }
    }

    void selectMenuItem(uint8_t idx) {
        playSelect();
        switch (static_cast<MenuItem>(idx)) {
            case MenuItem::BadgeName:
                _state.currentScreen = Screen::BadgeName;
                break;
            case MenuItem::WiFi:
                _state.currentScreen = Screen::WiFi;
                break;
            case MenuItem::BLE:
                _state.currentScreen = Screen::BLE;
                break;
            case MenuItem::Display:
                _state.currentScreen = Screen::Display;
                break;
            case MenuItem::Audio:
                _state.currentScreen = Screen::Audio;
                break;
            case MenuItem::OTAUpdate:
                _state.currentScreen = Screen::OTA;
                break;
            case MenuItem::Info:
                _state.currentScreen = Screen::Info;
                break;
            case MenuItem::Language:
                _state.currentScreen = Screen::Language;
                _editingIndex = _settings->language;
                break;
            default:
                break;
        }
        _state.needsRedraw = true;
    }

    void handleSettingGesture(Gesture g) {
        switch (g) {
            case Gesture::LongPress:
                // Save and go back
                saveAndBack();
                break;

            case Gesture::SwipeUp:
                incrementSetting();
                break;

            case Gesture::SwipeDown:
                decrementSetting();
                break;

            case Gesture::SwipeLeft:
            case Gesture::SwipeRight:
                cycleSetting();
                break;

            case Gesture::Tap:
                // Toggle boolean settings
                toggleSetting();
                break;

            default:
                break;
        }
    }

    void saveAndBack() {
        store().saveSettings(*_settings);
        lang.setLanguage(_settings->language);
        EMIT(Event::SettingsChanged, _settings);

        _state.currentScreen = Screen::Menu;
        _state.needsRedraw = true;
        playBack();
    }

    void toggleSetting() {
        switch (_state.currentScreen) {
            case Screen::BLE:
                _settings->bleEnabled = !_settings->bleEnabled;
                if (_settings->bleEnabled) bleMgr().begin(BLE_DEVICE_NAME, _settings->url1, _settings->url2);
                else bleMgr().stop();
                playSfx(_settings->bleEnabled ? Audio::SFX_BLE_ON : Audio::SFX_BLE_OFF);
                break;
            case Screen::Audio:
                _settings->soundEnabled = !_settings->soundEnabled;
                if (_settings->soundEnabled) audioPlayer.setVolume(_settings->volume);
                break;
            default:
                break;
        }
        _state.needsRedraw = true;
    }

    void incrementSetting() {
        switch (_state.currentScreen) {
            case Screen::Display:
                if (_editingIndex == 0) _settings->brightness = min(100, (int)_settings->brightness + 10);
                else _settings->sleepTimeout = min(300, (int)_settings->sleepTimeout + 5);
                _editingIndex = 1 - _editingIndex;
                break;
            case Screen::Audio:
                _settings->volume = min(30, (int)_settings->volume + 2);
                audioPlayer.setVolume(_settings->volume);
                break;
            case Screen::Language:
                _editingIndex = (_editingIndex + 1) % lang.langCount();
                break;
            case Screen::BadgeName:
                cycleNameChar(1);
                break;
            default:
                break;
        }
        _state.needsRedraw = true;
    }

    void decrementSetting() {
        switch (_state.currentScreen) {
            case Screen::Display:
                if (_editingIndex == 0) _settings->brightness = max(0, (int)_settings->brightness - 10);
                else _settings->sleepTimeout = max(0, (int)_settings->sleepTimeout - 5);
                _editingIndex = 1 - _editingIndex;
                break;
            case Screen::Audio:
                _settings->volume = max(0, (int)_settings->volume - 2);
                audioPlayer.setVolume(_settings->volume);
                break;
            case Screen::Language:
                _editingIndex = (_editingIndex + lang.langCount() - 1) % lang.langCount();
                break;
            case Screen::BadgeName:
                cycleNameChar(-1);
                break;
            default:
                break;
        }
        _state.needsRedraw = true;
    }

    void cycleSetting() {
        switch (_state.currentScreen) {
            case Screen::Display:
                _editingIndex = 1 - _editingIndex;
                break;
            case Screen::Language:
                _settings->language = _editingIndex;
                lang.setLanguage(_editingIndex);
                break;
            default:
                break;
        }
        _state.needsRedraw = true;
    }

    void cycleNameChar(int dir) {
        uint8_t len = strlen(_settings->badgeName);
        if (len == 0) {
            _settings->badgeName[0] = 'A';
            _settings->badgeName[1] = '\0';
            return;
        }
        char c = _settings->badgeName[len - 1];
        c = (c + dir < 'A') ? 'Z' : (c + dir > 'Z') ? 'A' : c + dir;
        _settings->badgeName[len - 1] = c;
    }

    // ── Drawing helpers ─────────────────────────────────────
    void clear() { disp().clear(); }

    void drawTopBar(const char* title) {
        disp().drawRect(0, 0, SCREEN_WIDTH, 28, GxEPD_BLACK, true);
        disp().drawText(10, 20, title, &FreeMonoBold12pt7b, GxEPD_WHITE);
    }

    void drawSettingRow(uint8_t y, const char* label, const char* value) {
        disp().drawText(10, y + 16, label, &FreeMonoBold12pt7b);
        // Value right-aligned
        disp().raw().setFont(&FreeMonoBold12pt7b);
        int16_t vw = disp().raw().textWidth(value);
        disp().drawText(SCREEN_WIDTH - vw - 10, y + 16, value, &FreeMonoBold12pt7b, GxEPD_BLACK);
    }

    void drawBottomHint(const char* hint) {
        disp().drawCenteredText(SCREEN_HEIGHT - 10, hint, &FreeMonoBold9pt7b);
    }

    void playNav()   { if (_settings->soundEnabled) audioPlayer.playSfx(Audio::SFX_NAV); }
    void playSelect(){ if (_settings->soundEnabled) audioPlayer.playSfx(Audio::SFX_SELECT); }
    void playBack()  { if (_settings->soundEnabled) audioPlayer.playSfx(Audio::SFX_BACK); }
    void playSfx(uint8_t sfx) { if (_settings->soundEnabled) audioPlayer.playSfx(sfx); }
};

#define ui UI::instance()

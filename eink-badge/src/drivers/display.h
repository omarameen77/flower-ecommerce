#pragma once
#include <Arduino.h>
#include <GxEPD2_BW.h>
#include <Fonts/FreeMonoBold9pt7b.h>
#include <Fonts/FreeMonoBold12pt7b.h>
#include <Fonts/FreeMonoBold18pt7b.h>
#include <Fonts/FreeMonoBold24pt7b.h>
#include <Fonts/FreeSansBold9pt7b.h>
#include "../core/config.h"

// GxEPD2 type for common 2.13" 200x200 ePaper (SSD1680)
// Adjust to your specific display model if needed:
//   GxEPD2_154_GDEY0213B74  — common cheap module
//   GxEPD2_154_GDEW0154M10  — Waveshare
//   GxEPD2_154_TC115TE      — TC115TE
typedef GxEPD2_BW<GxEPD2_154_GDEY0213B74, GxEPD2_154_GDEY0213B74::HEIGHT> DisplayType;

class Display {
public:
    static Display& instance() {
        static Display d;
        return d;
    }

    void begin() {
        _display.init(115200, true, 2, false);
        _display.setRotation(1);
        _display.setTextColor(GxEPD_BLACK);
        _display.fillScreen(GxEPD_WHITE);
        _display.display(false);  // full refresh
    }

    void clear() {
        _display.fillScreen(GxEPD_WHITE);
    }

    void fullRefresh() {
        _display.display(true);
    }

    void partialRefresh() {
        _display.display(false);
    }

    void powerOff() {
        _display.powerOff();
    }

    void powerOn() {
        _display.powerOn();
    }

    // ── Drawing primitives ──────────────────────────────────
    void drawText(int16_t x, int16_t y, const char* text,
                  const GFXfont* font = &FreeMonoBold12pt7b,
                  uint16_t color = GxEPD_BLACK) {
        _display.setFont(font);
        _display.setTextColor(color);
        _display.setCursor(x, y);
        _display.print(text);
    }

    void drawCenteredText(int16_t y, const char* text,
                          const GFXfont* font = &FreeMonoBold12pt7b) {
        _display.setFont(font);
        int16_t tw = _display.textWidth(text);
        int16_t x  = (SCREEN_WIDTH - tw) / 2;
        _display.setTextColor(GxEPD_BLACK);
        _display.setCursor(x, y);
        _display.print(text);
    }

    void drawRect(int16_t x, int16_t y, int16_t w, int16_t h,
                  uint16_t color = GxEPD_BLACK, bool fill = false) {
        if (fill)
            _display.fillRect(x, y, w, h, color);
        else
            _display.drawRect(x, y, w, h, color);
    }

    void drawCircle(int16_t x, int16_t y, int16_t r,
                    uint16_t color = GxEPD_BLACK, bool fill = false) {
        if (fill)
            _display.fillCircle(x, y, r, color);
        else
            _display.drawCircle(x, y, r, color);
    }

    void drawLine(int16_t x0, int16_t y0, int16_t x1, int16_t y1,
                  uint16_t color = GxEPD_BLACK) {
        _display.drawLine(x0, y0, x1, y1, color);
    }

    // ── Icon drawing (simple bitmaps) ───────────────────────
    void drawIcon(int16_t x, int16_t y, uint8_t iconId, uint8_t size = 24) {
        // Simple icon bitmaps — expand as needed
        static const uint8_t icons[][32] = {
            // WiFi icon (8x8 scaled)
            {0x00,0x00,0x3C,0x42,0x95,0x89,0x95,0x42,0x3C,0x00,0x00,0x00},
            // BLE icon
            {0x00,0x10,0x18,0x14,0x12,0x1F,0x12,0x14,0x18,0x10,0x00,0x00},
            // Speaker icon
            {0x02,0x06,0x3E,0x3E,0x3E,0x1C,0x08,0x00,0x00,0x00,0x00,0x00},
            // Gear icon
            {0x00,0x1C,0x22,0x2A,0x3E,0x1C,0x1C,0x3E,0x2A,0x22,0x1C,0x00},
            // Cloud/OTA icon
            {0x00,0x3C,0x42,0x81,0xBD,0x81,0x42,0x3C,0x00,0x18,0x18,0x00},
            // Info icon
            {0x00,0x3C,0x42,0x85,0x89,0x85,0x42,0x3C,0x00,0x00,0x00,0x00},
            // Globe/language icon
            {0x00,0x3C,0x42,0x81,0x91,0x81,0x42,0x3C,0x00,0x00,0x00,0x00},
            // Name tag icon
            {0x00,0x7E,0x42,0x5A,0x5A,0x42,0x7E,0x00,0x00,0x00,0x00,0x00},
            // Sleep/moon icon
            {0x00,0x1C,0x24,0x24,0x18,0x00,0x00,0x00,0x00,0x00,0x00,0x00},
        };
        if (iconId < 9) {
            _display.drawBitmap(x, y, icons[iconId], size, size, GxEPD_BLACK);
        }
    }

    // ── High-level screens ──────────────────────────────────
    void drawWelcome(const char* name, const char* version) {
        clear();
        // Top decoration line
        drawRect(0, 0, SCREEN_WIDTH, 4, GxEPD_BLACK, true);

        // Badge name — large centered
        drawCenteredText(SCREEN_HEIGHT / 2 - 10, name, &FreeMonoBold24pt7b);

        // Version
        char ver[32];
        snprintf(ver, sizeof(ver), "v%s", version);
        drawCenteredText(SCREEN_HEIGHT / 2 + 30, ver, &FreeMonoBold9pt7b);

        // Bottom decoration
        drawRect(0, SCREEN_HEIGHT - 4, SCREEN_WIDTH, 4, GxEPD_BLACK, true);

        fullRefresh();
    }

    void drawBadge(const char* name, uint8_t batteryPct, bool bleActive) {
        clear();

        // Top bar — battery + BLE
        char topRight[32];
        snprintf(topRight, sizeof(topRight), "%d%%", batteryPct);
        _display.setFont(&FreeMonoBold9pt7b);
        _display.setCursor(SCREEN_WIDTH - 50, 18);
        _display.print(topRight);

        if (bleActive) {
            _display.setCursor(10, 18);
            _display.print("BLE");
        }

        // Divider
        drawLine(0, 24, SCREEN_WIDTH, 24, GxEPD_BLACK);

        // Badge name — centered vertically
        drawCenteredText(SCREEN_HEIGHT / 2 + 10, name, &FreeMonoBold24pt7b);

        // Bottom hint
        drawCenteredText(SCREEN_HEIGHT - 20, TR(Str::SwipeToNavigate), &FreeMonoBold9pt7b);

        partialRefresh();
    }

    void drawMenuItem(uint8_t index, const char* label, bool selected) {
        uint8_t y = MENU_START_Y + (index % MENU_ITEMS_PER_PAGE) * 40;
        uint16_t bgColor = selected ? GxEPD_BLACK : GxEPD_WHITE;
        uint16_t fgColor = selected ? GxEPD_WHITE : GxEPD_BLACK;

        // Highlight bar
        drawRect(4, y - 2, SCREEN_WIDTH - 8, 36, bgColor, true);
        // Text
        _display.setFont(&FreeMonoBold12pt7b);
        _display.setTextColor(fgColor);
        _display.setCursor(16, y + 22);
        _display.print(label);

        // Arrow on right if selected
        if (selected) {
            _display.setCursor(SCREEN_WIDTH - 24, y + 22);
            _display.print(">");
        }
    }

    void drawMenuPage(uint8_t page, uint8_t selectedIdx, const char** items, uint8_t count) {
        clear();

        // Title
        drawCenteredText(20, TR(Str::MainMenu), &FreeMonoBold12pt7b);
        drawLine(0, 28, SCREEN_WIDTH, 28, GxEPD_BLACK);

        uint8_t start = page * MENU_ITEMS_PER_PAGE;
        uint8_t shown = 0;
        for (uint8_t i = start; i < count && shown < MENU_ITEMS_PER_PAGE; i++, shown++) {
            bool sel = (i == selectedIdx);
            drawMenuItem(shown, items[i], sel);
        }

        // Page indicator
        char pg[16];
        uint8_t totalPages = (count + MENU_ITEMS_PER_PAGE - 1) / MENU_ITEMS_PER_PAGE;
        snprintf(pg, sizeof(pg), "%d/%d", page + 1, totalPages);
        drawCenteredText(SCREEN_HEIGHT - 10, pg, &FreeMonoBold9pt7b);

        fullRefresh();
    }

    void drawSettingPage(const char* title, const char* value, const char* hint) {
        clear();
        drawCenteredText(30, title, &FreeMonoBold18pt7b);
        drawLine(0, 45, SCREEN_WIDTH, 45, GxEPD_BLACK);

        // Value — editable
        drawRect(10, 60, SCREEN_WIDTH - 20, 40, GxEPD_BLACK, false);
        drawCenteredText(90, value, &FreeMonoBold12pt7b);

        // Hint at bottom
        drawCenteredText(SCREEN_HEIGHT - 20, hint, &FreeMonoBold9pt7b);

        fullRefresh();
    }

    void drawInfoPage(const char* lines[], uint8_t count) {
        clear();
        int16_t y = 20;
        for (uint8_t i = 0; i < count && i < 8; i++) {
            _display.setFont(&FreeMonoBold9pt7b);
            _display.setCursor(10, y);
            _display.print(lines[i]);
            y += 18;
        }
        fullRefresh();
    }

    void showSleepAnimation() {
        clear();
        drawCenteredText(SCREEN_HEIGHT / 2, "zzZ", &FreeMonoBold24pt7b);
        fullRefresh();
        delay(500);
        powerOff();
    }

    DisplayType& raw() { return _display; }

private:
    Display() = default;

    // GxEPD2 constructor: (width, height, CS, DC, RST, BUSY)
    // Adjust CS/DC/RST/BUSY pins to match your wiring
    DisplayType _display{
        GxEPD2_154_GDEY0213B74::WIDTH, GxEPD2_154_GDEY0213B74::HEIGHT,
        PIN_DISPLAY_CS, PIN_DISPLAY_DC, PIN_DISPLAY_RST, PIN_DISPLAY_BUSY,
        -1,  // unused: -1 = not connected
        -1, 20000000,  // SPI freq
        1000000,       // SPI for partial refresh
        -1             // SPI for full refresh
    };
};

#define disp Display::instance()

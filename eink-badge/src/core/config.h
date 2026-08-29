#pragma once
#include <Arduino.h>

// ─── Firmware ───────────────────────────────────────────────
#define FW_NAME    "EInkBadge"
#define FW_VERSION "1.0.0"

// ─── Display (GxEPD2) ─────────────────────────────────────
// Adjust to your board's ePaper wiring
#define PIN_DISPLAY_CS    5
#define PIN_DISPLAY_DC    4
#define PIN_DISPLAY_RST   3
#define PIN_DISPLAY_BUSY  2
// MOSI=11, SCK=12 used by SPI

#define SCREEN_WIDTH  200
#define SCREEN_HEIGHT 200

// ─── Touch ─────────────────────────────────────────────────
#define PIN_TOUCH_LEFT   6
#define PIN_TOUCH_RIGHT  7
#define PIN_TOUCH_UP     8
#define PIN_TOUCH_DOWN   9

#define TOUCH_DEBOUNCE_MS    300
#define TOUCH_LONG_PRESS_MS  800

// ─── DFPlayer Mini ─────────────────────────────────────────
#define PIN_DFPLAYER_RX  44
#define PIN_DFPLAYER_TX  43
#define DFPLAYER_VOLUME  25

// ─── BLE ───────────────────────────────────────────────────
#define BLE_DEVICE_NAME "EInkBadge"

// ─── Battery ───────────────────────────────────────────────
#define PIN_BATTERY_ADC  1
#define BATTERY_VOLTAGE_DIVIDER 2.0

// ─── Storage keys ──────────────────────────────────────────
#define NVS_NAMESPACE      "badge"
#define NVS_KEY_SETTINGS   "settings"
#define NVS_KEY_BOOT_COUNT "boot_cnt"

// ─── UI Layout ─────────────────────────────────────────────
#define MENU_ICON_SIZE      48
#define MENU_ITEMS_PER_PAGE 4
#define MENU_START_Y        30

#define BADGE_NAME_Y       80
#define STATUS_BAR_Y       180

#define ANIM_DEBOUNCE_MS   200

// ─── Defaults ──────────────────────────────────────────────
static const struct {
    const char* badgeName    = "My Badge";
    const char* url1         = "https://example.com";
    const char* url2         = "";
    uint8_t     volume       = DFPLAYER_VOLUME;
    uint16_t    sleepTimeout = 30;       // seconds, 0=never
    uint8_t     brightness   = 80;       // 0-100
    uint8_t     language     = 0;        // 0=EN
    bool        bleEnabled   = true;
    bool        bleWake      = true;
    bool        soundEnabled = true;
} DEFAULTS;

// ─── Enums ─────────────────────────────────────────────────
enum class Screen : uint8_t {
    Welcome,
    Badge,
    Menu,
    BadgeName,
    WiFi,
    BLE,
    Display,
    Audio,
    OTA,
    Info,
    Language,
    Sleep
};

enum class MenuItem : uint8_t {
    BadgeName = 0,
    WiFi,
    BLE,
    Display,
    Audio,
    OTAUpdate,
    Info,
    Language,
    COUNT
};

enum class Gesture : uint8_t {
    None,
    Tap,
    SwipeLeft,
    SwipeRight,
    SwipeUp,
    SwipeDown,
    LongPress
};

enum class Lang : uint8_t {
    EN = 0,
    AR,
    FR,
    DE,
    ES,
    ZH,
    JA,
    KO,
    COUNT
};

enum class Event : uint8_t {
    // Touch
    GestureDetected,
    // Display
    ScreenChanged,
    DisplayNeedsUpdate,
    // BLE
    BleConnected,
    BleDisconnected,
    BleNdefWritten,
    // Audio
    AudioPlay,
    AudioStop,
    // Settings
    SettingsChanged,
    // System
    EnterSleep,
    WakeUp,
    BatteryLow,
    OtaProgress,
    // WiFi
    WiFiConnected,
    WiFiDisconnected
};

// ─── Settings struct ───────────────────────────────────────
struct BadgeSettings {
    char     badgeName[32];
    char     url1[128];
    char     url2[128];
    uint8_t  volume;
    uint16_t sleepTimeout;
    uint8_t  brightness;
    uint8_t  language;
    bool     bleEnabled;
    bool     bleWake;
    bool     soundEnabled;

    void defaults() {
        strncpy(badgeName, DEFAULTS.badgeName, sizeof(badgeName));
        strncpy(url1, DEFAULTS.url1, sizeof(url1));
        strncpy(url2, DEFAULTS.url2, sizeof(url2));
        volume       = DEFAULTS.volume;
        sleepTimeout = DEFAULTS.sleepTimeout;
        brightness   = DEFAULTS.brightness;
        language     = DEFAULTS.language;
        bleEnabled   = DEFAULTS.bleEnabled;
        bleWake      = DEFAULTS.bleWake;
        soundEnabled = DEFAULTS.soundEnabled;
    }
};

// ─── UI State ──────────────────────────────────────────────
struct UIState {
    Screen      currentScreen = Screen::Welcome;
    uint8_t     menuIndex     = 0;
    uint8_t     menuPage      = 0;
    bool        menuActive    = false;
    bool        needsRedraw   = true;
    uint32_t    lastActivity  = 0;
};

// ─── Gesture Event Data ────────────────────────────────────
struct GestureEvent {
    Gesture gesture;
    uint8_t data;  // extra data if needed
};

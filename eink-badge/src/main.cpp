// ╔═══════════════════════════════════════════════════════════╗
// ║  E-Ink Badge — Main                                     ║
// ║  ESP32-S3 + ePaper + Touch + DFPlayer + BLE             ║
// ╚═══════════════════════════════════════════════════════════╝

#include "core/config.h"
#include "core/event_bus.h"
#include "core/storage.h"
#include "core/language.h"
#include "drivers/display.h"
#include "drivers/touch.h"
#include "drivers/audio.h"
#include "features/battery.h"
#include "features/ble.h"
#include "features/ota.h"
#include "ui/ui.h"

BadgeSettings settings;

// ── Event handlers ─────────────────────────────────────────
void onEnterSleep(Event, void*) {
    Serial.println("[SYS] Entering deep sleep");
    disp().powerOff();
    // Wake on touch pin or BLE
    esp_sleep_enable_ext0_wakeup((gpio_num_t)PIN_TOUCH_LEFT, 0);
    esp_deep_sleep_start();
}

void onBatteryLow(Event, void*) {
    Serial.println("[SYS] Battery low!");
    disp().drawCenteredText(SCREEN_HEIGHT / 2, "LOW BATTERY", &FreeMonoBold18pt7b);
    disp().fullRefresh();
}

// ── Setup ──────────────────────────────────────────────────
void setup() {
    Serial.begin(115200);
    delay(500);
    Serial.println("\n=== E-Ink Badge v" FW_VERSION " ===");

    // Core systems
    store().begin();
    store().incBootCount();
    Serial.printf("[SYS] Boot #%lu\n", store().getBootCount());

    // Load settings
    store().loadSettings(settings);
    lang.setLanguage(settings.language);

    // Hardware init
    batt().begin();
    disp().begin();
    touchDriver().begin();
    audioPlayer.begin();

    // Subscribe to events
    SUBSCRIBE(Event::EnterSleep, onEnterSleep);
    SUBSCRIBE(Event::BatteryLow, onBatteryLow);

    // Boot sound
    if (settings.soundEnabled) {
        audioPlayer.playSfx(Audio::SFX_BOOT);
    }

    // Start BLE if enabled
    if (settings.bleEnabled) {
        bleMgr().begin(BLE_DEVICE_NAME, settings.url1, settings.url2);
    }

    // Initialize UI
    ui().begin(&settings);

    Serial.println("[SYS] Ready");
}

// ── Loop ───────────────────────────────────────────────────
void loop() {
    // 1. Read touch input
    touchDriver().update();

    // 2. Update UI (redraw if dirty)
    ui().update();

    // 3. Update BLE
    bleMgr().update();

    // 4. Update OTA server
    ota().update();

    // 5. Sleep timeout check
    if (settings.sleepTimeout > 0) {
        uint32_t elapsed = millis() - ui().lastActivityMs();
        if (elapsed > settings.sleepTimeout * 1000UL) {
            EMIT(Event::EnterSleep, nullptr);
        }
    }

    // 6. Battery check (every 60s)
    static uint32_t lastBattCheck = 0;
    if (millis() - lastBattCheck > 60000) {
        lastBattCheck = millis();
        if (batt().isLow()) {
            EMIT(Event::BatteryLow, nullptr);
        }
    }

    delay(10);  // Yield to RTOS
}

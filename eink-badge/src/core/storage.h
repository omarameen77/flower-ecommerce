#pragma once
#include <Arduino.h>
#include <Preferences.h>
#include "config.h"

class Storage {
public:
    static Storage& instance() {
        static Storage s;
        return s;
    }

    void begin() { _prefs.begin(NVS_NAMESPACE, false); }

    bool saveSettings(const BadgeSettings& s) {
        return _prefs.putBytes(NVS_KEY_SETTINGS, &s, sizeof(BadgeSettings)) > 0;
    }

    bool loadSettings(BadgeSettings& s) {
        size_t sz = _prefs.getBytesLength(NVS_KEY_SETTINGS);
        if (sz != sizeof(BadgeSettings)) {
            s.defaults();
            return false;
        }
        _prefs.getBytes(NVS_KEY_SETTINGS, &s, sizeof(BadgeSettings));
        return true;
    }

    uint32_t getBootCount() { return _prefs.getUInt(NVS_KEY_BOOT_COUNT, 0); }
    void     incBootCount() { _prefs.putUInt(NVS_KEY_BOOT_COUNT, getBootCount() + 1); }

    void clearAll() { _prefs.clear(); }

private:
    Storage() = default;
    Preferences _prefs;
};

#define store Storage::instance()

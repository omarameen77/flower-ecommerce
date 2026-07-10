#pragma once
#include <Arduino.h>
#include "config.h"

class Battery {
public:
    static Battery& instance() {
        static Battery b;
        return b;
    }

    void begin() {
        analogSetAttenuation(ADC_11db);
        analogReadResolution(12);
    }

    float voltage() const {
        uint32_t sum = 0;
        for (int i = 0; i < 16; i++) sum += analogRead(PIN_BATTERY_ADC);
        float raw = (sum / 16.0) / 4095.0 * 3.3;
        return raw * BATTERY_VOLTAGE_DIVIDER;
    }

    uint8_t percentage() const {
        float v = voltage();
        if (v >= 4.2) return 100;
        if (v <= 3.0) return 0;
        return (uint8_t)((v - 3.0) / 1.2 * 100);
    }

    bool isLow() const { return voltage() < 3.3; }

private:
    Battery() = default;
};

#define batt Battery::instance()

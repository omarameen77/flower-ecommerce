#pragma once
#include <Arduino.h>
#include "../core/config.h"
#include "../core/event_bus.h"

class Touch {
public:
    static Touch& instance() {
        static Touch t;
        return t;
    }

    void begin() {
        pinMode(PIN_TOUCH_LEFT,  INPUT);
        pinMode(PIN_TOUCH_RIGHT, INPUT);
        pinMode(PIN_TOUCH_UP,    INPUT);
        pinMode(PIN_TOUCH_DOWN,  INPUT);
    }

    void update() {
        uint32_t now = millis();
        if (now - _lastCheck < 50) return;  // 20 Hz poll
        _lastCheck = now;

        bool left  = !digitalRead(PIN_TOUCH_LEFT);
        bool right = !digitalRead(PIN_TOUCH_RIGHT);
        bool up    = !digitalRead(PIN_TOUCH_UP);
        bool down  = !digitalRead(PIN_TOUCH_DOWN);

        // Single-button press detection
        if (left || right || up || down) {
            if (!_pressed) {
                _pressed     = true;
                _pressStart  = now;
                _pressDir    = _getDir(left, right, up, down);
            }
        } else {
            if (_pressed) {
                uint32_t duration = now - _pressStart;
                Gesture g = Gesture::None;

                if (duration >= TOUCH_LONG_PRESS_MS) {
                    g = Gesture::LongPress;
                } else if (duration >= 50 && duration < TOUCH_DEBOUNCE_MS) {
                    g = Gesture::Tap;
                }

                if (g != Gesture::None && now - _lastGesture > TOUCH_DEBOUNCE_MS) {
                    _lastGesture = now;
                    GestureEvent ge{g, 0};
                    EMIT(Event::GestureDetected, &ge);
                }

                _pressed = false;
            }
        }

        // Swipe detection — track continuous press with direction changes
        if (_pressed) {
            bool left  = !digitalRead(PIN_TOUCH_LEFT);
            bool right = !digitalRead(PIN_TOUCH_RIGHT);
            bool up    = !digitalRead(PIN_TOUCH_UP);
            bool down  = !digitalRead(PIN_TOUCH_DOWN);
            uint8_t dir = _getDir(left, right, up, down);

            if (dir != _pressDir && dir != 0) {
                uint32_t duration = now - _pressStart;
                if (duration < TOUCH_LONG_PRESS_MS && now - _lastGesture > TOUCH_DEBOUNCE_MS) {
                    Gesture g = Gesture::None;
                    if (_pressDir == 1 && dir == 2) g = Gesture::SwipeRight;  // left→right
                    if (_pressDir == 2 && dir == 1) g = Gesture::SwipeLeft;   // right→left
                    if (_pressDir == 4 && dir == 8) g = Gesture::SwipeDown;   // up→down
                    if (_pressDir == 8 && dir == 4) g = Gesture::SwipeUp;     // down→up

                    if (g != Gesture::None) {
                        _lastGesture = now;
                        _pressed = false;
                        GestureEvent ge{g, 0};
                        EMIT(Event::GestureDetected, &ge);
                    }
                }
            }
        }
    }

private:
    Touch() = default;

    uint8_t _getDir(bool l, bool r, bool u, bool d) {
        if (l) return 1;
        if (r) return 2;
        if (u) return 4;
        if (d) return 8;
        return 0;
    }

    uint32_t _lastCheck    = 0;
    uint32_t _lastGesture  = 0;
    bool     _pressed      = false;
    uint32_t _pressStart   = 0;
    uint8_t  _pressDir     = 0;
};

#define touchDriver Touch::instance()

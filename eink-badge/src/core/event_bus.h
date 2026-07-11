#pragma once
#include <Arduino.h>
#include "config.h"

typedef void (*EventHandler)(Event event, void* data);

class EventBus {
public:
    static const uint8_t MAX_HANDLERS = 16;

    struct Slot {
        Event      event;
        EventHandler handler;
        bool       active;
    };

    static EventBus& instance() {
        static EventBus bus;
        return bus;
    }

    bool subscribe(Event event, EventHandler handler) {
        for (uint8_t i = 0; i < MAX_HANDLERS; i++) {
            if (!_slots[i].active) {
                _slots[i].event   = event;
                _slots[i].handler = handler;
                _slots[i].active  = true;
                return true;
            }
        }
        return false;
    }

    void emit(Event event, void* data = nullptr) {
        for (uint8_t i = 0; i < MAX_HANDLERS; i++) {
            if (_slots[i].active && _slots[i].event == event) {
                _slots[i].handler(event, data);
            }
        }
    }

    void clear() {
        for (uint8_t i = 0; i < MAX_HANDLERS; i++) {
            _slots[i].active = false;
        }
    }

private:
    EventBus() = default;
    Slot _slots[MAX_HANDLERS] = {};
};

// Convenience macros
#define BUS EventBus::instance()
#define SUBSCRIBE(event, fn) BUS.subscribe(event, fn)
#define EMIT(event, ...) BUS.emit(event, __VA_ARGS__)

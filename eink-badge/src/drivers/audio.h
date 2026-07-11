#pragma once
#include <Arduino.h>
#include "../core/config.h"

// DFPlayer commands
namespace DFP {
    static const uint8_t START_BYTE   = 0x7E;
    static const uint8_t END_BYTE     = 0xEF;
    static const uint8_t VERSION      = 0xFF;
    static const uint8_t LENGTH       = 0x06;
    static const uint8_t ACK          = 0x00;
    static const uint8_t PLAY         = 0x03;
    static const uint8_t PAUSE        = 0x0E;
    static const uint8_t STOP         = 0x16;
    static const uint8_t VOLUME       = 0x06;
    static const uint8_t RESET        = 0x0C;
    static const uint8_t EQ           = 0x07;
    static const uint8_t PLAYBACK_MODE= 0x08;
    static const uint8_t NEXT         = 0x01;
    static const uint8_t PREV         = 0x02;
}

class Audio {
public:
    static Audio& instance() {
        static Audio a;
        return a;
    }

    void begin() {
        _serial.begin(9600, SERIAL_8N1, PIN_DFPLAYER_RX, PIN_DFPLAYER_TX);
        delay(500);
        _sendCmd(DFP::RESET, 0);
        delay(500);
        _sendCmd(DFP::VOLUME, DEFAULTS.volume);
    }

    void setVolume(uint8_t vol) {
        _sendCmd(DFP::VOLUME, constrain(vol, 0, 30));
    }

    void playTrack(uint8_t track) {
        _sendCmd(DFP::PLAY, track);
    }

    void playFolder(uint8_t folder, uint8_t track) {
        // 0x12 = play from folder
        _sendCmd(0x12, (folder << 8) | track);
    }

    void pause() { _sendCmd(DFP::PAUSE, 0); }
    void stop()  { _sendCmd(DFP::STOP, 0); }

    void next() { _sendCmd(DFP::NEXT, 0); }
    void prev() { _sendCmd(DFP::PREV, 0); }

    // Play sound effects by index (files 0001-0010 on SD root)
    void playSfx(uint8_t idx) { playTrack(idx); }

    // Named SFX constants
    static const uint8_t SFX_NAV    = 1;   // navigation tap
    static const uint8_t SFX_SELECT = 2;   // item selected
    static const uint8_t SFX_BACK   = 3;   // go back
    static const uint8_t SFX_BOOT   = 4;   // boot sound
    static const uint8_t SFX_ALERT  = 5;   // alert/notification
    static const uint8_t SFX_BLE_ON = 6;   // BLE enabled
    static const uint8_t SFX_BLE_OFF= 7;   // BLE disabled
    static const uint8_t SFX_SLEEP  = 8;   // entering sleep

    bool isAvailable() { return _available; }

private:
    Audio() = default;

    void _sendCmd(uint8_t cmd, uint16_t arg) {
        uint8_t buf[10] = {
            DFP::START_BYTE,
            DFP::VERSION,
            DFP::LENGTH,
            DFP::ACK,
            cmd,
            (uint8_t)(arg >> 8),
            (uint8_t)(arg & 0xFF),
            0x00, 0x00,
            DFP::END_BYTE
        };
        // Calculate checksum
        uint16_t sum = 0;
        for (int i = 1; i < 7; i++) sum += buf[i];
        buf[7] = (uint8_t)(0 - (sum >> 8));
        buf[8] = (uint8_t)(0 - (sum & 0xFF));

        _serial.write(buf, 10);
    }

    HardwareSerial _serial{1};
    bool _available = false;
};

#define audioPlayer Audio::instance()

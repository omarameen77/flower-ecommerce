#pragma once
#include <Arduino.h>
#include <BLEDevice.h>
#include <BLEServer.h>
#include <BLEUtils.h>
#include <BLE2902.h>
#include "../core/config.h"
#include "../core/event_bus.h"

// ── NDEF constants ─────────────────────────────────────────
static const uint8_t NDEF_RT_URL = 0x55;

static const char* BLE_SVC_UUID = "00001801-0000-1000-8000-00805f9b34fb";
static const char* BLE_WRT_UUID = "00002b2a-0000-1000-8000-00805f9b34fb";

// ── Inner callback class for characteristic writes ─────────
class BleCharCallbacks : public BLECharacteristicCallbacks {
public:
    BleManager* parent = nullptr;
    void onWrite(BLECharacteristic* pChar) override;
};

// Forward declaration
class BleManager;

class BleManager : public BLEServerCallbacks {
public:
    static BleManager& instance() {
        static BleManager b;
        return b;
    }

    void begin(const char* deviceName, const char* url1, const char* url2) {
        BLEDevice::init(deviceName);
        _server = BLEDevice::createServer();
        _server->setCallbacks(this);

        _service = _server->createService(BLE_SVC_UUID);

        _writeChar = _service->createCharacteristic(
            BLE_WRT_UUID,
            BLECharacteristic::PROPERTY_WRITE |
            BLECharacteristic::PROPERTY_WRITE_NR
        );
        _charCallbacks.parent = this;
        _writeChar->setCallbacks(&_charCallbacks);
        _service->start();

        BLEAdvertising* adv = BLEDevice::getAdvertising();
        adv->addServiceUUID(BLE_SVC_UUID);
        adv->setScanResponse(true);
        adv->setMinPreferred(0x06);
        adv->setMinPreferred(0x12);
        BLEDevice::startAdvertising();

        _url1 = url1;
        _url2 = url2;
        _running = true;
    }

    void stop() {
        if (_running) {
            BLEDevice::stopAdvertising();
            BLEDevice::deinit();
            _running = false;
        }
    }

    void update() {
        if (_pendingNdef) {
            _pendingNdef = false;
            EMIT(Event::BleNdefWritten, nullptr);
        }
    }

    bool isRunning()  const { return _running; }
    bool isConnected() const { return _connected; }

    // ── NDEF Smart Poster encoding ──────────────────────────
    static std::vector<uint8_t> encodeNdefUrl(const char* url) {
        std::vector<uint8_t> payload;
        uint8_t prefix = 0x00;
        String u(url);
        if      (u.startsWith("http://www."))  { prefix = 0x01; url += 11; }
        else if (u.startsWith("https://www.")) { prefix = 0x02; url += 12; }
        else if (u.startsWith("http://"))      { prefix = 0x03; url += 7;  }
        else if (u.startsWith("https://"))     { prefix = 0x04; url += 8;  }
        payload.push_back(prefix);
        while (*url) { payload.push_back(*url++); }
        return payload;
    }

    static std::vector<uint8_t> buildNdefMessage(const char* url) {
        std::vector<uint8_t> msg;
        auto urlPayload = encodeNdefUrl(url);
        uint8_t payloadLen = urlPayload.size() + 1;
        msg.push_back(0xD1);  // MB=1 ME=1 SR=1 TNF=0x01
        msg.push_back(0x01);  // type length
        msg.push_back(payloadLen);
        msg.push_back(NDEF_RT_URL);
        for (auto b : urlPayload) msg.push_back(b);
        return msg;
    }

    // ── BLEServerCallbacks ──────────────────────────────────
    void onConnect(BLEServer*) override {
        _connected = true;
        EMIT(Event::BleConnected, nullptr);
    }

    void onDisconnect(BLEServer*) override {
        _connected = false;
        EMIT(Event::BleDisconnected, nullptr);
        if (_running) BLEDevice::startAdvertising();
    }

    void handleWrite(std::string value) {
        if (value.length() > 0 && value.length() < 128) {
            strncpy(_writeBuffer, value.c_str(), sizeof(_writeBuffer) - 1);
            _pendingNdef = true;
        }
    }

    const char* lastWrittenUrl() const { return _writeBuffer; }

private:
    BleManager() = default;

    BLEServer*          _server  = nullptr;
    BLEService*         _service = nullptr;
    BLECharacteristic*  _writeChar = nullptr;
    BleCharCallbacks    _charCallbacks;
    bool                _running   = false;
    bool                _connected = false;
    bool                _pendingNdef = false;
    const char*         _url1 = "";
    const char*         _url2 = "";
    char                _writeBuffer[128] = {};
};

// ── Implement characteristic write callback ────────────────
inline void BleCharCallbacks::onWrite(BLECharacteristic* pChar) {
    if (parent) parent->handleWrite(pChar->getValue());
}

#define bleMgr BleManager::instance()

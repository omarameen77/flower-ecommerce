#pragma once
#include <Arduino.h>
#include <WiFi.h>
#include <WebServer.h>
#include <Update.h>
#include "../core/config.h"
#include "../core/event_bus.h"

class OtaManager {
public:
    static OtaManager& instance() {
        static OtaManager o;
        return o;
    }

    void begin() {
        _server = new WebServer(80);
        setupRoutes();
    }

    void start() {
        WiFi.mode(WIFI_AP);
        WiFi.softAP(BLE_DEVICE_NAME "_OTA");
        _server->begin();
        _running = true;
        EMIT(Event::OtaProgress, (void*)"OTA Server Started");
    }

    void stop() {
        if (_running) {
            _server->stop();
            WiFi.softAPdisconnect(true);
            WiFi.mode(WIFI_OFF);
            _running = false;
        }
    }

    void update() {
        if (_running && _server) {
            _server->handleClient();
        }
    }

    bool isRunning() const { return _running; }
    const char* lastError() const { return _lastError; }

private:
    OtaManager() = default;

    WebServer* _server = nullptr;
    bool       _running = false;
    char       _lastError[128] = {};

    void setupRoutes() {
        _server->on("/", HTTP_GET, [this]() {
            String html = R"rawliteral(
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>E-Ink Badge OTA</title>
  <style>
    body { font-family: Arial; text-align: center; margin-top: 50px; background: #f5f5f5; }
    h1 { color: #333; }
    .upload { margin: 30px auto; padding: 20px; background: white; border-radius: 10px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); max-width: 400px; }
    input[type=file] { margin: 20px 0; }
    button { background: #D21E6A; color: white; border: none; padding: 12px 30px; border-radius: 5px; cursor: pointer; font-size: 16px; }
    button:hover { background: #8C1447; }
    #status { margin-top: 20px; color: #666; }
  </style>
</head>
<body>
  <h1>E-Ink Badge</h1>
  <div class="upload">
    <h2>OTA Firmware Update</h2>
    <input type="file" id="file" accept=".bin">
    <br>
    <button onclick="upload()">Upload Firmware</button>
    <div id="status"></div>
  </div>
  <script>
    function upload() {
      var file = document.getElementById('file').files[0];
      if (!file) { alert('Select a .bin file'); return; }
      var fd = new FormData();
      fd.append('update', file);
      document.getElementById('status').textContent = 'Uploading...';
      var xhr = new XMLHttpRequest();
      xhr.open('POST', '/update', true);
      xhr.onload = function() {
        if (xhr.status === 200) {
          document.getElementById('status').textContent = 'Update complete! Rebooting...';
          setTimeout(function(){ location.reload(); }, 3000);
        } else {
          document.getElementById('status').textContent = 'Error: ' + xhr.responseText;
        }
      };
      xhr.onerror = function() { document.getElementById('status').textContent = 'Network error'; };
      xhr.send(fd);
    }
  </script>
</body>
</html>
)rawliteral";
            _server->send(200, "text/html", html);
        });

        _server->on("/update", HTTP_POST, [this]() {
            _server->sendHeader("Connection", "close");
            _server->send(200, "text/plain", Update.hasError() ? "FAIL" : "OK");
            delay(500);
            ESP.restart();
        }, [this]() {
            HTTPUpload& upload = _server->upload();
            if (upload.status == UPLOAD_FILE_START) {
                Update.begin(UPDATE_SIZE_UNKNOWN);
            } else if (upload.status == UPLOAD_FILE_WRITE) {
                Update.write(upload.buf, upload.currentSize);
            } else if (upload.status == UPLOAD_FILE_END) {
                if (Update.end(true)) {
                    EMIT(Event::OtaProgress, (void*)"Update complete");
                } else {
                    strncpy(_lastError, Update.errorString(), sizeof(_lastError));
                }
            }
        });
    }
};

#define ota OtaManager::instance()

#pragma once
#include "config.h"

// String IDs — must match array order below
enum class Str : uint8_t {
    Welcome = 0,
    MainMenu,
    BadgeName,
    WiFi,
    BLE,
    Display,
    Audio,
    OTAUpdate,
    Info,
    Language,
    Save,
    Back,
    On,
    Off,
    Connected,
    Disconnected,
    Version,
    Battery,
    Sleep,
    NoWiFi,
    NdefUrl1,
    NdefUrl2,
    Volume,
    Brightness,
    SleepTimeout,
    BleWake,
    Enabled,
    Scanning,
    TapToSelect,
    SwipeToNavigate,
    COUNT
};

// Language codes in order matching Lang enum
static const char* LANG_CODES[] = {
    "en", "ar", "fr", "de", "es", "zh", "ja", "ko"
};
static const char* LANG_NAMES[] = {
    "English", "العربية", "Français", "Deutsch",
    "Español", "中文",     "日本語",   "한국어"
};

// String table [Lang][Str]
static const char* STRINGS[][static_cast<uint8_t>(Str::COUNT)] = {
    // ── EN ──
    {
        "Welcome",       "Main Menu",    "Badge Name",  "WiFi",
        "BLE",           "Display",      "Audio",       "OTA Update",
        "Info",          "Language",     "Save",        "Back",
        "On",            "Off",          "Connected",   "Disconnected",
        "Version",       "Battery",      "Sleep",       "No WiFi",
        "URL 1",         "URL 2",        "Volume",      "Brightness",
        "Sleep Timeout", "BLE Wake",     "Enabled",     "Scanning...",
        "Tap to select","Swipe to navigate"
    },
    // ── AR ──
    {
        "مرحبا",        "القائمة الرئيسية","اسم الشارة", "الواي فاي",
        " البلوتوث",     "العرض",          "الصوت",       "تحديث OTA",
        "المعلومات",     "اللغة",         "حفظ",         "رجوع",
        "تشغيل",         "إيقاف",         "متصل",        "غير متصل",
        "الإصدار",       "البطارية",      "نوم",         "لا واي فاي",
        "رابط 1",        "رابط 2",        "الصوت",       "السطوع",
        "مدة النوم",     "استيقاظ BLE",   "مفعّل",       "جاري البحث...",
        "اضغط للاختيار", "اسحب للتنقل"
    },
    // ── FR ──
    {
        "Bienvenue",     "Menu Principal", "Nom Badge",   "WiFi",
        "BLE",           "Affichage",      "Audio",       "Mise à jour OTA",
        "Info",          "Langue",         "Enregistrer", "Retour",
        "Oui",           "Non",            "Connecté",    "Déconnecté",
        "Version",       "Batterie",       "Veille",      "Pas de WiFi",
        "URL 1",         "URL 2",          "Volume",      "Luminosité",
        "Min Veille",    "Réveil BLE",     "Activé",      "Recherche...",
        "Tap pour choisir","Glisser pour naviguer"
    },
    // ── DE ──
    {
        "Willkommen",    "Hauptmenü",     "Badge Name",  "WiFi",
        "BLE",           "Anzeige",        "Audio",       "OTA Update",
        "Info",          "Sprache",        "Speichern",   "Zurück",
        "Ein",           "Aus",            "Verbunden",   "Getrennt",
        "Version",       "Akku",           "Schlaf",      "Kein WiFi",
        "URL 1",         "URL 2",          "Lautstärke",  "Helligkeit",
        "Schlafzeit",    "BLE Aufwachen",  "Aktiviert",   "Suchen...",
        "Tippen zum Auswählen","Wischen zum Navigieren"
    },
    // ── ES ──
    {
        "Bienvenido",    "Menú Principal", "Nombre Badge","WiFi",
        "BLE",           "Pantalla",       "Audio",       "Actualizar OTA",
        "Info",          "Idioma",         "Guardar",     "Volver",
        "Sí",            "No",             "Conectado",   "Desconectado",
        "Versión",       "Batería",        "Dormir",      "Sin WiFi",
        "URL 1",         "URL 2",          "Volumen",     "Brillo",
        "Temp. Dormir",  "Despertar BLE",  "Activado",    "Buscando...",
        "Toca para seleccionar","Desliza para navegar"
    },
    // ── ZH ──
    {
        "欢迎",          "主菜单",         "徽章名称",    "WiFi",
        "蓝牙",          "显示",           "音频",        "OTA 更新",
        "信息",          "语言",           "保存",        "返回",
        "开",            "关",             "已连接",      "已断开",
        "版本",          "电池",           "休眠",        "无 WiFi",
        "网址 1",        "网址 2",         "音量",        "亮度",
        "休眠时间",      "蓝牙唤醒",       "已启用",      "搜索中...",
        "点击选择",      "滑动导航"
    },
    // ── JA ──
    {
        "ようこそ",      "メインメニュー",  "バッジ名",    "WiFi",
        "BLE",           "ディスプレイ",    "オーディオ",  "OTA更新",
        "情報",          "言語",           "保存",        "戻る",
        "オン",          "オフ",           "接続済み",    "切断済み",
        "バージョン",    "バッテリー",      "スリープ",    "WiFiなし",
        "URL 1",        "URL 2",          "音量",        "明るさ",
        "スリープ時間",  "BLE Wake",       "有効",        "検索中...",
        "タップで選択",  "スワイプでナビゲート"
    },
    // ── KO ──
    {
        "환영합니다",    "메인 메뉴",      "배지 이름",   "WiFi",
        "BLE",           "화면",           "오디오",      "OTA 업데이트",
        "정보",          "언어",           "저장",        "뒤로",
        "켜기",          "끄기",           "연결됨",      "연결 끊김",
        "버전",          "배터리",         "슬립",        "WiFi 없음",
        "URL 1",        "URL 2",          "볼륨",        "밝기",
        "슬립 시간",     "BLE 깨우기",     "활성화",      "검색 중...",
        "탭하여 선택",  "스와이프로 탐색"
    }
};

class Language {
public:
    static Language& instance() {
        static Language lang;
        return lang;
    }

    void setLanguage(uint8_t idx) {
        if (idx < static_cast<uint8_t>(Lang::COUNT)) {
            _currentLang = idx;
        }
    }

    const char* get(Str key) const {
        uint8_t langIdx = min(_currentLang, static_cast<uint8_t>(Lang::COUNT) - 1);
        uint8_t strIdx  = min(static_cast<uint8_t>(key), static_cast<uint8_t>(Str::COUNT) - 1);
        return STRINGS[langIdx][strIdx];
    }

    const char* langName(uint8_t idx) const {
        if (idx < static_cast<uint8_t>(Lang::COUNT)) return LANG_NAMES[idx];
        return "?";
    }

    const char* langCode(uint8_t idx) const {
        if (idx < static_cast<uint8_t>(Lang::COUNT)) return LANG_CODES[idx];
        return "?";
    }

    uint8_t currentLang() const { return _currentLang; }
    uint8_t langCount()   const { return static_cast<uint8_t>(Lang::COUNT); }

private:
    Language() = default;
    uint8_t _currentLang = 0;
};

#define lang Language::instance()
#define TR(key) lang.get(key)

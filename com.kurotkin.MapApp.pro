TARGET = com.kurotkin.MapApp

CONFIG += \
    auroraapp

PKGCONFIG += \

SOURCES += \
    src/main.cpp \

HEADERS += \

DISTFILES += \
    rpm/com.kurotkin.MapApp.spec \

AURORAAPP_ICONS = 86x86 108x108 128x128 172x172

CONFIG += auroraapp_i18n

TRANSLATIONS += \
    translations/com.kurotkin.MapApp.ts \
    translations/com.kurotkin.MapApp-ru.ts \

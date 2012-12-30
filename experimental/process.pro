TEMPLATE = lib
TARGET = Process
QT += qml qml-private quick quick-private core-private v8-private gui-private
CONFIG += qt plugin

TARGET = $$qtLibraryTarget($$TARGET)
uri = experimental

DEFINES 	+= HAVE_POSIX_OPENPT HAVE_UTMPX

# Input
SOURCES += \
    process.cpp \
    qtermwidget/lib/Session.cpp \
    qtermwidget/lib/History.cpp \
    qtermwidget/lib/Pty.cpp \
    qtermwidget/lib/k3process.cpp \
    qtermwidget/lib/k3processcontroller.cpp \
    qtermwidget/lib/kpty.cpp \
    qtermwidget/lib/Vt102Emulation.cpp \
    qtermwidget/lib/Emulation.cpp \
    qtermwidget/lib/BlockArray.cpp \
    qtermwidget/lib/vt100.cpp \
    qtermwidget/lib/Screen.cpp \
    qtermwidget/lib/TerminalCharacterDecoder.cpp \
    qtermwidget/lib/ShellCommand.cpp \
    qtermwidget/lib/KeyboardTranslator.cpp \
    qtermwidget/lib/konsole_wcwidth.cpp \
    qtermwidget/lib/ScreenWindow.cpp

HEADERS += \
    process_plugin.h \
    process.h \
    qtermwidget/lib/Session.h \
    qtermwidget/lib/History.h \
    qtermwidget/lib/Pty.h \
    qtermwidget/lib/k3process.h \
    qtermwidget/lib/k3processcontroller.h \
    qtermwidget/lib/kpty.h \
    qtermwidget/lib/kpty_p.h \
    qtermwidget/lib/Vt102Emulation.h \
    qtermwidget/lib/Emulation.h \
    qtermwidget/lib/vt100.h \
    qtermwidget/lib/Screen.h \
    qtermwidget/lib/TerminalCharacterDecoder.h \
    qtermwidget/lib/ShellCommand.h \
    qtermwidget/lib/KeyboardTranslator.h \
    qtermwidget/lib/konsole_wcwidth.h \
    qtermwidget/lib/ScreenWindow.h \
    gpio_i2c.h

OTHER_FILES = qmldir

!equals(_PRO_FILE_PWD_, $$OUT_PWD) {
    copy_qmldir.target = $$OUT_PWD/qmldir
    copy_qmldir.depends = $$_PRO_FILE_PWD_/qmldir
    copy_qmldir.commands = $(COPY_FILE) \"$$replace(copy_qmldir.depends, /, $$QMAKE_DIR_SEP)\" \"$$replace(copy_qmldir.target, /, $$QMAKE_DIR_SEP)\"
    QMAKE_EXTRA_TARGETS += copy_qmldir
    PRE_TARGETDEPS += $$copy_qmldir.target
}

qmldir.files = qmldir
unix {
    installPath = $$[QT_INSTALL_IMPORTS]/$$replace(uri, \\., /)
    qmldir.path = $$installPath
    target.path = $$installPath
    INSTALLS += target qmldir
}

raspi {
    message(Building with gpio support)
    LIBS += -lbcm2835
    DEFINES += "HAS_GPIO"
}

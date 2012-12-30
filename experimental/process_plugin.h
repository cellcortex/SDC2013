/*
 *  * This file copyright (c) 2012, Andrew Baldwin
 *   * LICENSE: GPL v2. See qtermwidget directory
 *    */

#ifndef PROCESS_PLUGIN_H
#define PROCESS_PLUGIN_H

#include <QtQml/QQmlExtensionPlugin>
#include <qqml.h>
#include "process.h"
#include "gpio.h"

class ProcessPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface" FILE "process.json")

public:
    void registerTypes(const char *uri)
    {
        qmlRegisterType<Konsole::TerminalDisplay>(uri, 1, 0, "Process");
        qmlRegisterType<GPIO>(uri, 1, 0, "GPIO");
    }
};

#endif // PROCESS_PLUGIN_H


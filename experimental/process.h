/*
 *  * This file copyright (c) 2012, Andrew Baldwin
 *   * LICENSE: GPL v2. See qtermwidget directory
 *    */


#ifndef PROCESS_H
#define PROCESS_H

#include <QtCore/QObject>
#include <qtermwidget/lib/ColorTables.h>
#include <qtermwidget/lib/Session.h>
#include <qtermwidget/lib/ScreenWindow.h>
#include <QtGui/QKeyEvent>
#include <QtQuick/QQuickItem>

#include <QtQuick/private/qquicktextnode_p.h>

namespace Konsole
{

class TerminalDisplay : public QQuickText
{
    Q_OBJECT
    Q_DISABLE_COPY(TerminalDisplay)
    Q_PROPERTY(QString stdout READ stdout NOTIFY stdoutChanged)
    Q_PROPERTY(QString stderr READ stderr NOTIFY stderrChanged)
    Q_PROPERTY(QSize size READ size WRITE setSize NOTIFY sizeChanged)
    Q_PROPERTY(QPoint cursor READ cursor NOTIFY cursorMoved)
    Q_PROPERTY(QFont font READ font WRITE setFont NOTIFY fontChanged)
public:
    TerminalDisplay(QQuickItem *parent = 0);
    ~TerminalDisplay();

    QString stdout();
    QString stderr();
    ScreenWindow* screenWindow() const;
    void setScreenWindow(ScreenWindow* window);

    int lines() { return _size.height(); }
    int columns() { return _size.width(); }
    QSize size() { return _size; }
    void setSize(QSize size);
    virtual void keyPressEvent(QKeyEvent *event);
    virtual void keyReleaseEvent(QKeyEvent *event);
    QPoint cursor() { return _cursor; }

    //QFont font() const;
    //void setFont(const QFont &font);
    //virtual QSGNode *updatePaintNode(QSGNode *, UpdatePaintNodeData *);

signals:
    void stdoutChanged();
    void stderrChanged();
    void keyPressedSignal(QKeyEvent* event);
    void sizeChanged(int height,int width);
    void cursorMoved();
    void fontChanged(const QFont &font);
public slots:
    void launch(QString path,QString arguments);
    void writeChar(int c);
    void writeString(QString s);
    void updateImage();
private:
    QSize _size;
    QPoint _cursor;
    Konsole::Session *session;
    Konsole::ScreenWindow *_screenWindow;
    //QFont _font;
    //QQuickTextNode *oldNode;
};

}

#endif // PROCESS_H


/*
 * This file copyright (c) 2012, Andrew Baldwin
 * LICENSE: GPL v2. See qtermwidget directory
 */

#include "process.h"
#include <QDebug>
#include <QtGui/QTextLayout>
#include <QtQuick/private/qquicktext_p.h>
#include <QtQuick/private/qquickitem_p.h>

using namespace Konsole;

TerminalDisplay::TerminalDisplay(QQuickItem *parent):
    QQuickText(parent),_size(80,40),_screenWindow(0)
{
    //connect(this,SIGNAL(readyReadStandardOutput()),this,SIGNAL(stdoutChanged()));
    //connect(this,SIGNAL(readyReadStandardError()),this,SIGNAL(stderrChanged()));
    //connect(this,SIGNAL(stateChanged(QProcess::ProcessState)),this,SLOT(handleStateChanged(QProcess::ProcessState)));
    //connect(this,SIGNAL(error(QProcess::Pro_cessError)),this,SLOT(handleError(QProcess::ProcessError)));
    setFlag(QQuickItem::ItemHasContents);
}

TerminalDisplay::~TerminalDisplay()
{
}
/*
void TerminalDisplay::handleError(QProcess::ProcessError error)
{
    qDebug() << "process error"<<error;
}

void Process::handleStateChanged(QProcess::ProcessState state)
{
    qDebug() << "process state"<<state;
    //qDebug() << readAllStandardError();
}
*/

void TerminalDisplay::launch(QString path,QString arguments)
{
    /*qDebug() << "Launching path " << path<<"arg"<<arguments;
    QStringList list;
    list << arguments;
    start(path,list);*/

    session = new Session();

    session->setTitle(Session::NameRole, "QMLTerm");
    session->setProgram("/bin/bash");
    QStringList args("");
    session->setArguments(args);
    session->setAutoClose(true);

    session->setCodec(QTextCodec::codecForName("UTF-8"));

    session->setFlowControlEnabled(true);
    session->setHistoryType(HistoryTypeBuffer(1000));

    session->setDarkBackground(true);

    session->setKeyBindings("");

    session->addView(this);

   // qDebug() << "about to run";
    session->run();
    //qDebug() << "running";
}

/*QSGNode* TerminalDisplay::updatePaintNode(QSGNode *, UpdatePaintNodeData *)
{
    QQuickTextNode *node = 0;
    if (!oldNode) {
        node = new QQuickTextNode(QQuickItemPrivate::get(this)->sceneGraphContext(), this);
    } else {
        node = static_cast<QQuickTextNode *>(oldNode);
    }
    QRectF bounds = boundingRect();
    node->deleteContent();
    node->setMatrix(QMatrix4x4());
    const QColor color = QColor(255,255,255,255);
    QTextLayout layout(stdout());
    layout.setFont(_font);
    node->addTextLayout(QPoint(0, bounds.y()), &layout, color, QQuickText::Normal,color,color);

    return node;
}*/

ScreenWindow* TerminalDisplay::screenWindow() const
{
    return _screenWindow;
}
void TerminalDisplay::setScreenWindow(ScreenWindow* window)
{
    // disconnect existing screen window if any
    if ( _screenWindow )
    {
        disconnect( _screenWindow , 0 , this , 0 );
    }

    _screenWindow = window;

    if ( window )
    {
//#warning "The order here is not specified - does it matter whether updateImage or updateLineProperties comes first?"
//        connect( _screenWindow , SIGNAL(outputChanged()) , this , SLOT(updateLineProperties()) );
        connect( _screenWindow , SIGNAL(outputChanged()) , this , SLOT(updateImage()) );
        window->setWindowLines(40);
        window->setTrackOutput(true);
    }
}

void TerminalDisplay::setSize(QSize size)
{
    //qDebug() << "setSize" << size;
    _size = size;
    _screenWindow->setWindowLines(size.height());
    emit sizeChanged(_size.height(),_size.width());
}

void TerminalDisplay::writeChar(int c)
{
    //qDebug() << "writing"<<c;
    char data[2];
    data[0] = (char)c;
    //data[1] = 13;
    //write(data,1);
}

void TerminalDisplay::updateImage(){
    Character* const newimg = _screenWindow->getImage();
    int lines = _screenWindow->windowLines();
    int columns = _screenWindow->windowColumns();
    //qDebug() << "update" << lines << columns;
    emit stdoutChanged();
    update();
}

void TerminalDisplay::writeString(QString s)
{
    //write(s.toUtf8());
    //QKeyEvent event;
    //event.
//keyPressedSignal(QKeyEvent*)


}

void TerminalDisplay::keyPressEvent(QKeyEvent *event)
{
    if (event->key()==Qt::Key_F2) {
        event->ignore();
        return;
    }
    //qDebug() << "keypressevent" << event->key() << event->text();
    //if (event->text().length()>0) qDebug() << "code" << event->text().at(0).unicode();

    // Generate a Ctrl-C if you do Alt-Ctrl-C
    if (event->modifiers()==Qt::ControlModifier && event->text().length()==1) {
        QKeyEvent ctrlevent(event->type(),event->key()&63,Qt::ControlModifier,QString(QChar(event->key()&63)),event->isAutoRepeat(),event->count());
        emit keyPressedSignal(&ctrlevent);
    }
    else {
        emit keyPressedSignal(event);
    }
}

void TerminalDisplay::keyReleaseEvent(QKeyEvent *event)
{
    //qDebug() << "keyreleaseevent" << event->key();
    //emit keyPressedSignal(event);
}

QString TerminalDisplay::stdout()
{
    QString newoutput;
    Character* newimg = _screenWindow->getImage();
    int lines = _screenWindow->windowLines();
    int columns = _screenWindow->windowColumns();
    int newline = 0;
    int endfont = 0;
    QPoint cp = _screenWindow->cursorPosition();
    //QColor bgc;
    //QColor fgc = QColor(1,1,1,1);
    //QColor lastfgc = QColor(0,0,0,0);
    //QColor lastbgc = QColor(0,0,0,0);
    //newoutput.append("<pre>");
    for (int i=0;i<lines;i++) {
        
        if (newline>0) {
          newoutput.append(QChar::fromLatin1(10));
        }
        //if (newline>0) newoutput.append(QString::fromAscii("<p>"));
        newline = 0;
        for (int j=0;j<columns;j++) {
            /*
            bgc = newimg->backgroundColor.color(whiteonblack_color_table);
            fgc = newimg->foregroundColor.color(whiteonblack_color_table);
            if ((fgc!=lastfgc)||(bgc!=lastbgc)) {
                if (endfont>0) newoutput.append("</span>");
                newoutput.append("<span style=\"color:#");
                QString num;
                num=QString::number(fgc.red(),16);if(num.length()==1)newoutput.append("0");newoutput.append(num);
                num=QString::number(fgc.green(),16);if(num.length()==1)newoutput.append("0");newoutput.append(num);
                num=QString::number(fgc.blue(),16);if(num.length()==1)newoutput.append("0");newoutput.append(num);
                newoutput.append(";background-color:#");
                num=QString::number(bgc.red(),16);if(num.length()==1)newoutput.append("0");newoutput.append(num);
                num=QString::number(bgc.green(),16);if(num.length()==1)newoutput.append("0");newoutput.append(num);
                num=QString::number(bgc.blue(),16);if(num.length()==1)newoutput.append("0");newoutput.append(num);
                newoutput.append("\">");
                lastfgc = fgc;
                lastbgc = bgc;
            }
            if (newimg->character == '<') newoutput.append("&lt;");
            else if (newimg->character == '>') newoutput.append("&gt;");
            else if (newimg->character == '&') newoutput.append("&amp;");
            */
            newoutput.append(newimg->character);
            //if (newimg->character!=32)
            //    qDebug() << i<<j<<newimg->character;
            newimg++;
            newline++;
            endfont++;
        }
    }
    //newoutput.append("</pre>");
    if (cp!=_cursor) { _cursor=cp; emit cursorMoved(); }
    return newoutput;
}

QString TerminalDisplay::stderr()
{
    QString newoutput;
    return newoutput;
}

#ifndef GPIO_H
#define GPIO_H

#include <QtCore/QObject>
#include <QtQuick/QQuickItem>
#include <QDebug>

#ifdef HAS_GPIO
#include <bcm2835.h>
#endif 

class GPIO : public QQuickItem
{
    Q_OBJECT
    Q_DISABLE_COPY(GPIO)
public:
    GPIO(QQuickItem *parent = 0) : QQuickItem(parent) {
#ifdef HAS_GPIO
      if (!bcm2835_init())
      {
        qWarning() << "failed to init GPIO!!!";
      }
      for (int i = 0; i < 64; ++i) {
        pinModes[i] = -1;
      }
#endif
    }
    Q_INVOKABLE void digitalWrite(int pin, bool value) {
#ifdef HAS_GPIO
      if (pinModes[pin] != 1) {
        qDebug() << "setting pin" << pin << "to output";
        bcm2835_gpio_fsel(pin, BCM2835_GPIO_FSEL_OUTP);
        pinModes[pin] = 1;
      }
      if (value) {
        qDebug() << "setting pin" << pin << "HIGH";
        bcm2835_gpio_write(pin, HIGH);
      } else {
        qDebug() << "setting pin" << pin << "LOW";
        bcm2835_gpio_write(pin, LOW);
      }
      qDebug() << "pin setting done";
#else
      qDebug() << "(unimplemented) write pin" << pin << "to" << value;
#endif
    }
private:
  int pinModes[64]; 
};

#endif // GPIO_H


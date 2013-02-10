#ifndef GPIO_H
#define GPIO_H

#include <QtCore/QObject>
#include <QtQuick/QQuickItem>
#include <QDebug>

#ifdef I2C
#include <linux/i2c-dev.h>
#include <linux/i2c.h>
#endif 

class GPIO : public QQuickItem
{
    Q_OBJECT
    Q_DISABLE_COPY(GPIO)
public:
    GPIO(QQuickItem *parent = 0) : QQuickItem(parent) {
#ifdef I2C
      deviceHandle = open("/dev/i2c-1", O_RDWR);
      if (deviceHandle < 0) {
        qWarning() << "Error: Couldn't open device";
      }
      int deviceI2CAddress = 0x1A;
      if (ioctl(deviceHandle, I2C_SLAVE, deviceI2CAddress) < 0) {
        qWarning() << "Error: Couldn't find slave address";
      }
#endif
    }
    Q_INVOKABLE void digitalWrite(int pin, bool value) {
#ifdef I2C
        buffer[0] = (char)pin;
        buffer[1] = (char)value;
        int written = write(deviceHandle, buffer, 2);
#else
        qDebug() << "(unimplemented) write pin" << pin << "to" << value;
#endif
    }
    ~GPIO() {
     // close(deviceHandle);
    }
private:
  int deviceHandle;
  char buffer[3];
};

#endif // GPIO_H


#include "Wire.h"

/*
  General Setup
*/

// define slave address
#define SLAVE_ADDRESS 0x1A 

// other vars
int answer = 0;

void setup() {                
  // initialize the digital pins for leds and relay as an output
  pinMode(2, OUTPUT);
  pinMode(3, OUTPUT);  
  pinMode(4, OUTPUT);  
  pinMode(5, OUTPUT);  
  pinMode(6, OUTPUT);  
  pinMode(7, OUTPUT);  
  pinMode(8, OUTPUT);  
  pinMode(9, OUTPUT);  
  pinMode(10, OUTPUT);  
  
  pinMode(13, OUTPUT);  
  // initialize i2c as slave
  Wire.begin(SLAVE_ADDRESS);
   
  // define callbacks for i2c communication
  Wire.onReceive(receiveData);
//  Wire.onRequest(sendData);

  //Serial.begin(9600); // Debugging only
}

void loop() {
  /*
  digitalWrite(2, HIGH);
  delay(2000);
  digitalWrite(2, LOW);
  delay(2000);
  */
}

// callback for received data
void receiveData(int byteCount) 
{  
  String requestCommand = "";
  int len = 0;
  while(Wire.available())
  { 
     len += 1;
     requestCommand = requestCommand + (char)Wire.read();
  }
  if (len == 2) {
    char pin = requestCommand[0];
    char value = requestCommand[1];
    /*
    char nix = requestCommand[2];
    if (nix != 0) {
      Serial.print("Strange terminator:");
      Serial.print(nix);
      Serial.println();
    } else {
      */
      if ((pin <= 13) && (pin > 1)) {
        digitalWrite(pin, value);
      } else {
        // Illegal pin
      }/*
      Serial.print("Command: ");
      /for (char i = 0; i < len; ++i) {
        Serial.print((int)requestCommand[i]);
        Serial.print(", ");
      }
      Serial.println("EOL");
      */
  } else {
    /*
    Serial.print("Strange bytecount: ");
    Serial.print(byteCount);
    Serial.println();
    */
  }
}

// callback for sending data
void sendData()
{ 
//  Wire.write(answer);  
  answer = 0;
}

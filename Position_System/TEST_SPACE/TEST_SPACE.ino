#include <Servo.h>
//#include "classes.ino"

class test_class{
  public:
    void print_function(){
    
    Serial.println("TESTING PRINT FUNCTION");
  }
};

Servo servo;

void setup() {
  Serial.begin(9600);
  servo.attach(12);
  servo.write(0);
  delay(2000);
  // Mapping
  int val = map(180,0,270,0,180);
  servo.write(val);
  Serial.print("Val: ");
  Serial.println(val);
  delay(1000);
//  val = map(0,0,270,0,180);
//  servo.write(val);
  //servo.write(180);
}

void loop() {
//  Serial.println("move to 0");
//  servo.write(0);
//  delay(2000);
//  Serial.println("move to 180");
//  servo.write(270);
//  delay(2000);
}

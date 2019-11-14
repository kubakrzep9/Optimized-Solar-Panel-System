// The Position System (PS), is made of two servos. The arm servo controls the angle 
// the solar panel is pointed. The base servo controls the rotational angle for the solar
// panel. 
//
// Each array that pertain to the PS will have a specific ordering
// [0]arm, [1]base

#include <Servo.h>

int SERVO_MOVE_DELAY_TIME = 1000;

class Position_System { 
  public:
    static const int num_servos = 2;
    // methods
    void initialize(int[]);
    void move_system(int[]);
    void print_info();
  
  private:  
    // members
    Servo servos[num_servos]; // [0]a, [1]b
    int servo_pins[num_servos] = {1,2};    
    int servo_angles[num_servos] = {0, 0};  

    // methods 
    void initial_position(); 
    void set_pins(int[]);
    void move_servo(Servo, int);
    void attach_pins();
};

// Initialization function for the PS. Sets the pins and moves the system to an intial postion.
void Position_System::initialize(int pins[]){
  set_pins(pins);
  initial_position();
}

// Moves the system to an initial position. 
void Position_System::initial_position(){
    int initial[] = {0,0};
    move_system(initial);
}

// It is assumed the pins will always be able to be set. Sets the pins of each servo.
void Position_System::set_pins(int _pins[]){
    for(int i=0; i<num_servos; i++){ 
      servo_pins[i] = _pins[i];
      servos[i].attach(servo_pins[i]);
    }
}

// It is assumed the servo will be able to move. Moves a servo to a specified angle. 
// 
// Note: Servo has weird 270 degree range of motion, thought it does not follow the 
// expected behavior. When a value of 90 is entered the servo will instead travel 
// past that to around 115. The map function is used to take the arduinos 270 degrees 
// of motion and map that down to 180 degrees.  
void Position_System::move_servo(Servo servo, int angle){
    int mapped_angle = map(angle,0,270,0,180); 
    servo.write(mapped_angle);
}

// Movement function, which moves and sets each servo angle. 
void Position_System::move_system(int angles[]){ // a b
    for(int i=0; i<num_servos; i++){ 
      move_servo(servos[i], angles[i]);
      servo_angles[i] = angles[i];
    }
    delay(SERVO_MOVE_DELAY_TIME);
}

// Display function, displays the pin and angle information of the system. To be 
// displayed on the serial monitor. 
void Position_System::print_info(){
    Serial.println("Arm info");
    Serial.print("angle: ");
    Serial.print(servo_angles[0]);
    Serial.print("   pin: ");
    Serial.println(servo_pins[0]);
    Serial.println("Base info");
    Serial.print("angle: ");
    Serial.print(servo_angles[1]);
    Serial.print("   pin: ");
    Serial.println(servo_pins[1]);
}

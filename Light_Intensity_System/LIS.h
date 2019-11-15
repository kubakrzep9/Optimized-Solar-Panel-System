// The Light Intensity System (LIS), is made of five photosensitive sensor modules. Each
// module has a potentiometer that can adjust the sensitivity of it's photoresistor.  
//
// Each array that pertains to the LIS will have a specific ordering.
// [0]central, [1]front, [2]back, [3]left, [4]right
//
// Note: The lower the light intensity value the higher the light intensity.

class Light_Intensity_System{
  private:
    // members
    static const int num_sensors = 5; // Must be const static
    int pins[num_sensors]              = {A0, A1, A2, A3, A4}; // [0]c, [1]f, [2]b, [3]l, [4]r
    int light_intensities[num_sensors] = {0, 0, 0, 0, 0};     
    String sensor_names[num_sensors]   = {"central", "front", "back", "left", "right"}; 

    // methods
    void light_intensity_function();
    String calculate_highest_intensity_sensor();
    void get_intensities(int[]);
 
  public:
    // methods
    int get_pin(String _name);
    void set_pins(int[]);
    void print_one_intensity(int pin, String str);
    void print_intensities();
    String get_lightIntensities_instruction();
};

// Returns each sensors light intensity as an array. The light intensities are found
// by reading the analog value of each sensor pin. 
void Light_Intensity_System::get_intensities(int intensity_values[]){
  for(int i=0; i<num_sensors; i++){ intensity_values[i] = analogRead(pins[i]); }
}

// Helper function to print an integer array with _size elements
void print_array(int _array[], int _size){
  for(int i=0; i<_size; i++){Serial.print(String(_array[i]) + " "); } Serial.println("");  
}

// Returns an instruction used to send all the light intensity values of the LIS. The instruction
// has an instructionID "LIS_lightIntensities" followed by the intensity values. Each token of the
// instruction is seperated by a space " ".  
String Light_Intensity_System::get_lightIntensities_instruction(){
  int intensity_values[num_sensors] = {0,0,0,0,0};
  get_intensities(intensity_values);
  String instruction = "LIS_lightIntensities "+String(intensity_values[0])+" "+String(intensity_values[1])
                                          +" "+String(intensity_values[2])+" "+String(intensity_values[3])
                                          +" "+String(intensity_values[4]);
  return instruction;
}

// Returns the pin of the sensor _name.
int Light_Intensity_System::get_pin(String _name){
  int i=0;
  if(_name.equals("central")){ return pins[0]; }
  if(_name.equals("front")){   return pins[1]; }
  if(_name.equals("back")){    return pins[2]; }
  if(_name.equals("left")){    return pins[3]; }
  if(_name.equals("right")){   return pins[4]; }
  return i; 
}

// Sets all the sensor pins in the system.
void Light_Intensity_System::set_pins(int _pins[]){
  for(int i=0; i<num_sensors; i++){ 
    pins[i] = _pins[i]; 
    pinMode(pins[i], INPUT); 
  }
}

// Helper display function. Prints one sensor and it's value. Used in print_intensities.
// Note, this does not make a new line. Ex: " c[387] ".
void Light_Intensity_System::print_one_intensity(int pin, String str){
  Serial.print(" ");
  Serial.print(str);
  Serial.print("[");
  Serial.print(analogRead(pin));
  Serial.print("] ");
}

// Display function, used to see current light intensities of each sensor. This
// output will be displayed on the Serial monitor.
void Light_Intensity_System::print_intensities(){
  Serial.print("Light Intensities");
  print_one_intensity(pins[0], "c");
  print_one_intensity(pins[1], "f");
  print_one_intensity(pins[2], "b");
  print_one_intensity(pins[3], "l");
  print_one_intensity(pins[4], "r");  
  Serial.println(" ");
}

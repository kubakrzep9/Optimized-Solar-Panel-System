// GUI version of the Light Intensity System (LIS). Keeps track of the pins and light intensities for each photosensitive 
// sensor module in the LIS. Contains a serial port to communicate with the Arduino LIS. 
//
// Each array that pertains to the LIS will have a specific ordering.
// [0]central, [1]front, [2]back, [3]left, [4]right
//
// Note: The lower the light intensity value the higher the light intensity.



class Light_Intensity_System extends Adjustment_System{
  private boolean auto_flag = false;
  
  private int num_sensors = 5;
  private int pins[];  
  private int intensities[];
  
  private String sensor_names[] = {"central", "front", "back", "left", "right"};
  private String previous_high_sensor = "";
  
  private Serial serial_port;
  public int port_index = 0;
  private String port = "not set";
  private boolean port_connected = false;
  
  Light_Intensity_System(){
    intensities = new int[num_sensors];
    pins = new int[num_sensors];
    
    int _pins[] = {10, 11, 12, 13, 14};
    set_pins(_pins);
    
    int vals[] = {1,2,3,4,5};
    set_intensities(vals);
  }
  
  // Tries to connect the serial port to port. If it fails it will print an error message. 
  String connect_serial_port(PApplet parent){
    String status;
    try{ // Try to connect to port portConnection 
      this.serial_port = new Serial(parent, port, 9600); 
      status = "[LIS] Connected to port: " + port;
    } 
    catch( Exception e){ // If failed, display error message
      status = "[LIS] Error connecting to port: " + port; 
    }
    return status;
  }
  
  // Returns the last highest sensor
  String get_previous_high_sensor(){ return previous_high_sensor; }
  // Sets the highest sensor
  void set_previous_high_sensor(String sensor){ previous_high_sensor = sensor; }
  
  // Sets the port address and port index, which corresponds to the drop down port selection list.
  void set_port(String _port, int index){ port = _port;   port_index = index; }  
  // Returns the name of the port 
  String get_port(){ return port; }
   // Returns the index of the port in the drop down port selection list.
  int get_port_index(){ return port_index; }
  
  // Sets the port connected flag. Which signifies if a port has successfully been connected to or not. 
  void set_port_connected(boolean bool){ port_connected = bool; }
  // Returns the port connected flag.
  boolean get_port_connected(){ return port_connected; }
  
  // Sets the auto flag, which determines if the PS should be controlled manually or automatically.
  void set_auto_flag(boolean bool){ auto_flag = bool; }
  // Returns auto_flag
  boolean get_auto_flag(){ return auto_flag; }
  
  // Sets the light sensor pins.
  void set_pins(int _pins[]){ for(int i=0; i< num_sensors; i++){ pins[i] = _pins[i]; } }
  // Returns the pins.
  int[] get_pins(){ return pins; }
  
  // Sets the intensities of each light sensor.
  void set_intensities(int data[]){ for(int i=0; i<num_sensors; i++){intensities[i] = data[i]; } }
  // Returns the light intensities. 
  int[] get_intensities(){ return intensities; }
  
  // Determines the name of the sensor with the lightest light intensity. It is important to note that the
  // light sensor with the highes light intensity with have the lowest intensity value. 
  String calculate_highest_intensity_sensor(){
    int intensity_values[] = get_intensities();
    
    int max_intensity = intensity_values[0]; 
    int max_index = 0;
    
    for(int i=0; i<num_sensors; i++){ 
      // sensor with the lowest value  has the highest light intensity
      if(intensity_values[i] < max_intensity){ 
        max_intensity = intensity_values[i];
        max_index = i;
      }
    }
    return sensor_names[max_index];
  }  
  
  // Display function to print the intensity values to the console.  
  void print_intensities(){ 
    String names[] = {"Central", "Front", "Back", "Left", "Right"};
    println("Printing intensities");
    for(int i=0; i<num_sensors; i++){ println(names[i] +": "+intensities[i]); }
  }
  
}

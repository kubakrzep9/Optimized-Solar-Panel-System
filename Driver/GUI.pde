// This class is contains the general GUI elements and settings. The home screen and options screen are 
// defined here. GUI_Settings extends Display_Functions to format text and data onto the GUI. This class
// also has access to the PS and LIS to update the GUI with accurate values. 



class GUI_Settings extends Display_Functions{
  public int GUI_WIDTH  = 600;
  public int GUI_HEIGHT = 300;
  public int OS_WIDTH   = 300;
  public int OS_HEIGHT  = 520;
 
  private Position_System ps;
  private Light_Intensity_System lis;

  GUI_Settings(){setup_GUI(); }
  
  GUI_Settings(Position_System _ps, Light_Intensity_System _lis){
    setup_GUI();
    this.ps = _ps;
    this.lis = _lis;
  }
  
  // Initializes the max gui size.
  void setup_GUI(){ surface.setSize(1000, 1000); }
  
  // Displays the main (home) screen of the GUI. The main screen displays each servo angle measure and each 
  // sensors light intensity. Will also display input fields and buttons, but these are set and activated 
  // through the Widgets class.
  void main_screen(){
    int ps_angles[] = ps.get_servo_angles();
    String arm_angle = format_int_data(ps_angles[0]); // arm
    String base_angle = format_int_data(ps_angles[1]); // base
   
    int sensor_light_intensities[] = lis.get_intensities(); // [0] central, [1] left, [2] right, [3] front, [4] back
    int size = sensor_light_intensities.length;
    String formatted_intensities[] = new String[size];   
    for(int i=0; i<size; i++){ formatted_intensities[i] = format_int_data(sensor_light_intensities[i]); }   
    
    background(247, 247, 247);   
    surface.setSize(GUI_WIDTH, GUI_HEIGHT);
    
    int servo_y = 50;
    display_text("Position System", 130, 20, CENTER, fonts.get(2));
    display_text("Arm", 110, servo_y, CENTER, fonts.get(3));
    display_text("Base", 112, servo_y+25, CENTER, fonts.get(3));
    display_text(arm_angle,  150, servo_y, CENTER, fonts.get(3));
    display_text(base_angle, 150, servo_y + 25, CENTER, fonts.get(3));  
   
    int sensor_y = 180;
    display_text("Light Intensity System", 130, 150, CENTER, fonts.get(2));
    display_text("Front",   115, sensor_y,    CENTER, fonts.get(3));
    display_text("Central", 115, sensor_y+40, CENTER, fonts.get(3));
    display_text("Left",    30,  sensor_y+40, CENTER, fonts.get(3));
    display_text("Right",   200, sensor_y+40, CENTER, fonts.get(3));
    display_text("Back",    115, sensor_y+80, CENTER, fonts.get(3));
    display_text(formatted_intensities[3], 150, sensor_y,    CENTER, fonts.get(3));
    display_text(formatted_intensities[0], 150, sensor_y+40, CENTER, fonts.get(3));
    display_text(formatted_intensities[1], 65,  sensor_y+40, CENTER, fonts.get(3));
    display_text(formatted_intensities[2], 235, sensor_y+40, CENTER, fonts.get(3));
    display_text(formatted_intensities[4], 150, sensor_y+80, CENTER, fonts.get(3));
  }

  // Displays the options screen. The options screen displays each servo and sensors pin. Will also 
  // display drop down menus for port selection, input fields and buttons but these are set and 
  // activated through the Widgets class.
  void options_screen(){
    int text_y_anchor = 30;
    int text_x = 60;
    int text_x_center = OS_WIDTH/2;
    int h_line_x = 30;
    int h_line_length = OS_WIDTH - 2*h_line_x; 
    int h_line_width = 1;
    String light_sensor_names[] = {"Central", "Front", "Back", "Left", "Right"};
    int lsn_size = light_sensor_names.length;
    int formatted_data_offset = 180;
    
    int servo_pins[] = ps.get_servo_pins();
    String formatted_arm_pin = format_int_data(servo_pins[0]); // // [0]arm, [1]base
    String formatted_base_pin = format_int_data(servo_pins[1]); // [0]arm, [1]base
    
    int light_sensor_pins[] = lis.get_pins();
    String formatted_ls_pins[] = new String[lsn_size];
    for(int j=0; j<lsn_size; j++){ formatted_ls_pins[j] = format_int_data(light_sensor_pins[j]); }
        
    surface.setSize(OS_WIDTH, OS_HEIGHT);
    background(247, 247, 247);   

    display_text("Options", OS_WIDTH/2, text_y_anchor, CENTER, fonts.get(0));   
    
    rect(h_line_x,text_y_anchor+20,h_line_length,h_line_width); // horizontal black line   
    display_text("PORTS",  text_x_center, text_y_anchor+45, CENTER, fonts.get(2));
    display_text("LIS",  text_x+20, text_y_anchor+55, CENTER, fonts.get(2));
    display_text("PS",  text_x+160, text_y_anchor+55, CENTER, fonts.get(2));
    
    rect(h_line_x,text_y_anchor+120,h_line_length,h_line_width); // horizontal black line   
    display_text("SERVO PINS",  text_x_center, text_y_anchor+150, CENTER, fonts.get(2));
    display_text("Arm",  text_x, text_y_anchor+170, CENTER, fonts.get(2));
    display_text("Base",  text_x, text_y_anchor+195, CENTER, fonts.get(2));
    display_text(formatted_arm_pin,  text_x+formatted_data_offset, text_y_anchor+170, CENTER, fonts.get(2));
    display_text(formatted_base_pin,  text_x+formatted_data_offset, text_y_anchor+195, CENTER, fonts.get(2)); 
    
    rect(h_line_x,text_y_anchor+220,h_line_length,h_line_width); // horizontal black line
    display_text("LIGHT SENSOR PINS",  text_x_center, text_y_anchor+250, CENTER, fonts.get(2));
    for(int i=0; i<lsn_size; i++){
          display_text(light_sensor_names[i],  text_x-20, text_y_anchor+280+25*i, LEFT, fonts.get(2));
          display_text(formatted_ls_pins[i],  text_x+formatted_data_offset, text_y_anchor+280+25*i, CENTER, fonts.get(2));
    }
    
    rect(h_line_x,text_y_anchor+400,h_line_length,h_line_width); // horizontal black line
  }  
}

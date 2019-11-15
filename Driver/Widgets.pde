// This class contains all the dynamic elements of the GUI. The key elements of this class are features that the 
// user can interact with: buttons, drop down, input fields. These features can be shown and hidden onto the GUI. 
// The buttons allow the user to navigate the menus, submit values or exit the program. The drop downs allow the 
// user to select the ports for the Positioning System (PS) and the Light Intensity System (LIS). The input fields 
// allow the user to manually change the PS position, or set the PS and or LIS pins.



import controlP5.*;

class Widgets extends GUI_Settings {
  
  public ControlP5 widget_control;
  private final PApplet theParent; 
  private DropdownList available_ports1;
  private DropdownList available_ports2;
  private Textarea message_box;
  
  private ArrayList<String> servo_angle_input_fields;
  private ArrayList<String> ps_pin_input_fields;
  private ArrayList<String> lis_pin_input_fields;
  
  private String message_box_text = "";
  
  Widgets(final PApplet parent){
    theParent = parent;
    servo_angle_input_fields = new ArrayList<String>();
    ps_pin_input_fields = new ArrayList<String>();
    lis_pin_input_fields = new ArrayList<String>();
    widget_control = new ControlP5(theParent);
    
   /*********************/
   /****** Buttons ******/
   /*********************/

  int button_area_y = 260;
  int manual_servo_entry_x = 185;

    // Sets auto mode
    widget_control.addButton("auto")       
      .setPosition(310, button_area_y)              
      .setSize(60, 25)                    
      .setFont(fonts.get(3))              
      .hide()                             
    ;
    
    // Sets manual mode
    widget_control.addButton("manual")       
      .setPosition(380, button_area_y)              
      .setSize(60, 25)                    
      .setFont(fonts.get(3))              
      .hide()                             
    ;
  
    // Changes to options screen
    widget_control.addButton("options")       
      .setPosition(450, button_area_y)              
      .setSize(60, 25)                    
      .setFont(fonts.get(3))              
      .hide()                             
    ;

    // Exits program
    widget_control.addButton("exit")       
      .setPosition(520, button_area_y)              
      .setSize(60, 25)                    
      .setFont(fonts.get(3))              
      .hide()                             
    ;

    // Changes to home screen
    widget_control.addButton("home")       
      .setPosition(130, 478)              
      .setSize(60, 25)                    
      .setFont(fonts.get(3))              
      .hide()                             
    ;

    // Submission button to send servo angle measures in manual mode                            // MOVE BUTTON //
    widget_control.addButton("move")       
      .setPosition(manual_servo_entry_x, 250)              
      .setSize(35, 15)                    
      .setFont(fonts.get(3))              
      .hide()                             
    ;
    
    // Sets pins
    widget_control.addButton("pins")       
      .setPosition(95, 445)              
      .setSize(60, 25)                    
      .setFont(fonts.get(3))              
      .hide()                             
    ;
    
    // Sets ports
    widget_control.addButton("ports")       
      .setPosition(165, 445)              
      .setSize(60, 25)                    
      .setFont(fonts.get(3))              
      .hide()                             
    ;
    
    /***********************************/
    /***** Main screen message box *****/
    /***********************************/
    //message_box = new Textarea(widget_control, "message box")                        // message box //
    message_box = widget_control.addTextarea("message box")
     .setPosition(310,15)
     .setSize(270,230)
     .show()
     .setLineHeight(16)
     .setColor(color(0))
     //.setColor(color(128))
     //.setColorBackground(color(255, 100))
     //.setColorForeground(color(255, 100))
     .setColorBackground(0xffffffff)
   ;
     
    
    /***********************************************/
    /***** Input texfields for Servo data entry ****/
    /***********************************************/
    
    int input_xCoord = manual_servo_entry_x;
    int input_yCoord = 200;
    int input_width  = 35;
    int input_height = 15;
    
    String namesInputFields[] = {"input arm", "input base"};
    int size = namesInputFields.length;
       
    for(int i=0; i<size; i++){
      servo_angle_input_fields.add(namesInputFields[i]);
      widget_control.addTextfield(namesInputFields[i])
        .setPosition(input_xCoord,input_yCoord+25*i)
        .setSize(input_width, input_height)
        .setFont(fonts.get(3))
        .setFocus(true)
        .setAutoClear(false)
        .hide()
        .setColorBackground(0xffffffff)
        .setColor(0)
        .getCaptionLabel().setVisible(false)
      ;
    }
  
  
     /***********************************************/
    /***** Input texfields for Servo pin entry ****/
    /***********************************************/
    
    int input_xCoord_ps_pins = 90;
    int input_yCoord_ps_pins = 187;
    int input_width_pins  = 120;
    int input_height_pins = 15;
    
    String namesInputFields_ps_pins[] = {"input arm pin", "input base pin"};
    size = namesInputFields_ps_pins.length;
       
    for(int i=0; i<size; i++){
      ps_pin_input_fields.add(namesInputFields_ps_pins[i]);
      widget_control.addTextfield(namesInputFields_ps_pins[i])
        .setPosition(input_xCoord_ps_pins,input_yCoord_ps_pins+25*i)
        .setSize(input_width_pins, input_height_pins)
        .setFont(fonts.get(3))
        .setFocus(true)
        .setAutoClear(false)
        .hide()
        .setColorBackground(0xffffffff)
        .setColor(0)
        .getCaptionLabel().setVisible(false)
      ;
    }
    
    /*****************************************************/
    /***** Input texfields for Light Sensor pin entry ****/
    /*****************************************************/
    
    int input_yCoord_lis_pins = 300;
    
    String namesInputFields_lis_pins[] = {"input central pin", "input front pin", "input back pin", "input left pin", "input right pin"};
    size = namesInputFields_lis_pins.length;
       
    for(int i=0; i<size; i++){
      lis_pin_input_fields.add(namesInputFields_lis_pins[i]);
      widget_control.addTextfield(namesInputFields_lis_pins[i])
        .setPosition(input_xCoord_ps_pins,input_yCoord_lis_pins+25*i)
        .setSize(input_width_pins, input_height_pins)
        .setFont(fonts.get(3))
        .setFocus(true)
        .setAutoClear(false)
        .hide()
        .setColorBackground(0xffffffff)
        .setColor(0)
        .getCaptionLabel().setVisible(false)
      ;
    }
  
    int drop_down_width = 100;
    int drop_down_height = 100;
  
    /*****************************************/
    /***** Port Selection Dropdown List 1*****/
    /*****************************************/
    available_ports1 = widget_control.addDropdownList("port 1")
        .setPosition(31, 90)
        .setFont(fonts.get(3))
        .setSize(drop_down_width, drop_down_height)
        .hide()
    ;
        
    /*****************************************/
    /***** Port Selection Dropdown List 2*****/
    /*****************************************/
    available_ports2 = widget_control.addDropdownList("port 2")
        .setPosition(170, 90)
        .setFont(fonts.get(3))
        .setSize(drop_down_width, drop_down_height)
        .hide()
    ;
  
      customizeDDL(available_ports1);
      customizeDDL(available_ports2);  
  }
  
  void close_port_drop_downs(){
    available_ports1.close();
    available_ports2.close();
  }
  
  // Convenience function to customize a DropdownList
  void customizeDDL(DropdownList ddl) {
    ddl.setBackgroundColor(color(190));
    int _height = 20;
    ddl.setItemHeight(_height);
    ddl.setBarHeight(_height);
    ddl.setCaptionLabel("Ports");
   
    String portsAvailable[] = Serial.list();
    int size = portsAvailable.length; 
    //Adding ports to DropdownList
    ddl.addItem(empty_entry, 0);
    for (int i=1;i<=size;i++){ ddl.addItem(portsAvailable[i-1], i); }
  
    //ddl.setColorBackground(color(60));
    ddl.setColorActive(color(255, 128));
  }
  
  // Appends text to the end of the text area. text must be a string without "\n". 
  // println_message_box will append a newline char at the end of the text. 
  public void println_message_box(String text){ 
    message_box_text += text + "\n";
    message_box.setText(message_box_text);  
  }
  
  // Initializing main menu widgets.
  public void init_main_menu(){
    showElements("auto");
    showElements("manual");
    showElements("options");
    showElements("exit");
    showElements("manual move");
    showElements("move");
    showElements("message box");
    message_box.scroll(1);
  }
  
  // Move element to desired xy coordinate 
  public void moveElement(String name, int x, int y){ widget_control.getController(name).setPosition(x,y); }
  
  // Convenience function used easily hide all buttons and input fields
  public void resetElements(){ hideElements("all"); }
    
  // Convenience function to easily display any GUI element or group of elements (buttons, input fields).
  // Used when preparing GUI to display a specific screen.
  public void showElements(String name){
    if(name == "home"   ){ widget_control.getController("home").show(); }
    if(name == "move"   ){ widget_control.getController("move").show(); }
    if(name == "manual" ){ widget_control.getController("manual").show(); }
    if(name == "auto"   ){ widget_control.getController("auto").show(); }
    if(name == "options"){ widget_control.getController("options").show(); }
    if(name == "exit"   ){ widget_control.getController("exit").show(); }
    if(name == "pins"   ){ widget_control.getController("pins").show(); }
    if(name == "ports"  ){ widget_control.getController("ports").show(); }
    if(name == "manual move"){ for(String input_name : servo_angle_input_fields){ widget_control.getController(input_name).show(); } }
    if(name == "ps pins"){     for(String input_name : ps_pin_input_fields){      widget_control.getController(input_name).show(); } }
    if(name == "lis pins"){    for(String input_name : lis_pin_input_fields){     widget_control.getController(input_name).show(); } }
    if(name == "ports"){
      widget_control.getController("port 1").show();
      widget_control.getController("port 2").show();
    }
    if(name == "message box"){ message_box.show(); }
  }

  // Convenience function to easily hide any and all GUI element or groups of elements (buttons, input fields). 
  // Used when preparing GUI to display a specific screen.
  public void hideElements(String name){
    if(name == "home"    || name == "all" ){ widget_control.getController("home").hide(); }
    if(name == "move"    || name == "all"){ widget_control.getController("move").hide(); }
    if(name == "auto"    || name == "all"){ widget_control.getController("auto").hide(); }
    if(name == "manual"  || name == "all"){ widget_control.getController("manual").hide(); }
    if(name == "options" || name == "all"){ widget_control.getController("options").hide(); }
    if(name == "exit"    || name == "all"){ widget_control.getController("exit").hide(); }
    if(name == "pins"    || name == "all"){ widget_control.getController("pins").hide(); }
    if(name == "ports"   || name == "all"){ widget_control.getController("ports").hide(); }
    if(name == "manual move" || name == "all"){ for(String input_name : servo_angle_input_fields){ widget_control.getController(input_name).hide(); } }
    if(name == "ps pins" || name == "all"){     for(String input_name : ps_pin_input_fields){      widget_control.getController(input_name).hide(); } }
    if(name == "lis pins" || name == "all"){    for(String input_name : lis_pin_input_fields){     widget_control.getController(input_name).hide(); } }
    if(name == "ports" || name == "all"){
      widget_control.getController("port 1").hide();
      widget_control.getController("port 2").hide();
    }
    if(name == "message box" || name == "all"){ message_box.hide(); }
  }
  
  // Returns item from DropDownList at a specific index
  public String getItemDropDownList(DropdownList ddl, int index){ 
    java.util.Map<java.lang.String,java.lang.Object> item = ddl.getItem(index);
    return item.get("text").toString();
  }
  
  // Used to retrieve user input from the input fields according to a name provided as an argument. The name 
  // is used to decide which input fields to read from. 
  public String[] getTextFields(String name){
    String nullSet[] = new String[1]; //return nothing if name doesn't match
    
    if(name == "servo angle input fields"){
      int size = servo_angle_input_fields.size();
      String textFields[] = new String[size];
      for(int i=0; i<size; i++){
        textFields[i] = widget_control.get(Textfield.class, servo_angle_input_fields.get(i)).getText(); 
      }
      return textFields;
    }else if(name == "ps pin input fields"){
      int size = ps_pin_input_fields.size();
      String textFields[] = new String[size];
      for(int i=0; i<size; i++){
        textFields[i] = widget_control.get(Textfield.class, ps_pin_input_fields.get(i)).getText(); 
      }
      return textFields;
    }else if(name == "lis pin input fields"){
      int size = lis_pin_input_fields.size();
      String textFields[] = new String[size];
      for(int i=0; i<size; i++){
        textFields[i] = widget_control.get(Textfield.class, lis_pin_input_fields.get(i)).getText(); 
      }
      return textFields;
    }
    
    return nullSet;
  }
  
  // Clears all text fields from the Template Input Screen. Used to clear input fields after user has 
  // submitted their inputs. Also used to clear input fields, if there is anything on them, when 
  // switching screens. Otherwise, the input fields will retain an old value. 
  public void clearTextFields(){
    for(String str : servo_angle_input_fields){ widget_control.get(Textfield.class, str).setText(""); }
    for(String str : ps_pin_input_fields){ widget_control.get(Textfield.class, str).setText(""); }
    for(String str : lis_pin_input_fields){ widget_control.get(Textfield.class, str).setText(""); }
  }
}

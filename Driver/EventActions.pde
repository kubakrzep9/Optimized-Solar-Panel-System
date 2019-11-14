// Button and input field event actions. Each function corresponds to a button action. The controlEvent function
// corresponds to a user selected value from a drop down list. 



// Changes to the home screen. 
void home(){
  clearInputFields();
  w.resetElements();
  menu_choice = 0;
  w.init_main_menu();
}

// Sends a move instruction to move the PS. Can only use in manual mode, button not visible otherwise. 
void move(){
 String instruction = get_instruction("servo angle input fields", "PS_moveSystem");
 println(instruction);
 send_instruction(instruction, ps.get_serial_port());
}

// Sets the ports for the LIS and PS. Both systems cannot connect to the same port. 
void ports(){ 
 int lis_index = lis.get_port_index();
 if(lis_index == ps.get_port_index()){
     if(!(lis_index == 0)){
       println("CAN'T CONNECT BOTH SYSTEMS TO ONE PORT");
       return;
     }
  }else{
       println("LIS Port: " + lis.get_port());
       println("PS Port: " + ps.get_port());
  }
  
  lis.connect_serial_port(this); 
  ps.connect_serial_port(this);
}

// Sets the pins for the LIS and PS. All pins must be unique. 
void pins(){
 String instruction1 = get_instruction("ps pin input fields", "ps_setPins");
 String instruction2 = get_instruction("lis pin input fields", "lis_setPins");
  
 println("NOT FINISHED");
 println(instruction1);
 println(instruction2);
}

// Changes to the options screen.
void options(){ 
  clearInputFields();
  mainTemplate(1);
  w.showElements("pins");
  w.showElements("ports");
  w.showElements("ps pins");
  w.showElements("lis pins");
  w.close_port_drop_downs();
}

// Toggles auto mode.
void auto(){
  println("Auto mode activated");
  lis.set_auto_flag(true);
  w.hideElements("move");
  w.hideElements("manual move");
}

// Toggles manual mode. 
void manual(){  
  println("Manual mode activated");
  lis.set_auto_flag(false);
  w.showElements("move");
  w.showElements("manual move");
}

// Helper function, home screen template. 
void mainTemplate(int screen){
  w.resetElements();
  w.showElements("home");
  menu_choice = screen;
}

/***** Dropdown List Control Function *****/

// Function allows the ability access each event. In this case we select a port from the 
// dropdownlist and connect to it
void controlEvent(ControlEvent theEvent) {

  // Sets user selected port to be connected
  if(theEvent.getName().equals("port 1")){
    int index = int(theEvent.getController().getValue());
     // set port_connected when you make connection to that serial port
     if(!lis.get_port_connected()){
        lis.set_port(w.getItemDropDownList(w.available_ports1, index), index);
     }
  }
  
   if(theEvent.getName().equals("port 2")){
    int index = int(theEvent.getController().getValue());
     // set port_connected when you make connection to that serial port
     if(!ps.get_port_connected()){
        ps.set_port(w.getItemDropDownList(w.available_ports2, index), index);
     }
  }
}

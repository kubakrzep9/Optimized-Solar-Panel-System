// Helper and validateion functions for instructions. These functions either retrieve the user input data
// or validate user input data. 



// Retrieves the text from the input fields specified by name. 
String[] get_text(String name){ return w.getTextFields(name); }

// Returns the current values that are related to the input fields defined by name.
int[] get_current_values(String name){
  int current_values[] = new int[1];
 
  if(name.equals("servo angle input fields")){ current_values =  ps.get_servo_angles(); }
  else if(name.equals("ps pin input fields")){ current_values =  ps.get_servo_pins(); }
  else if(name.equals("lis pin input fields")){ current_values =  lis.get_pins(); }
  
  return current_values;
}

// Checks the given set of input for empty entries. If an entry is empty, it will be replaced by the
// current value that the input field, specified by name, would otherwise change. 
String[] check_empty(String input[], String name){
  int current_values[] = get_current_values(name);
  int size = input.length;
  int i = 0; 
  // replacing empty entries with the current value for the respective input field
  for(; i<size; i++){ if(input[i].equals("")){ input[i] = Integer.toString(current_values[i]); }}
  
  return input;
}

// Creates a set from the input string array to check for duplicates. 
boolean check_duplicates(String input[]){
  Set<String> s = new HashSet();
  for(String in : input){ if (s.add(in) == false){ return false; } }  
  
  return true; 
}

// Converts and returns a string array into an integer array. Returns ERROR_VAL
// if a string element cannot be converted into a string. 
int[] stringArr_to_intArr(String str[]){
  boolean valid_data = true;
  int size = str.length;
  int intArr[] = new int[size];
  int i = 0;
  
  for(; i<size; i++){ 
    try{ intArr[i] = Integer.parseInt(str[i]); }
    catch(Exception e){ 
      // End of instructions seem to have "\\s", last token cannot be cast to int without removing it
      try{intArr[i] = Integer.parseInt(str[i].replaceAll("\\s","")); }
      catch(Exception e2){ valid_data = false; }
    }
  }
  
  if(valid_data){ return intArr; }
  else{ 
    int errorArr[] = {ERROR_VAL};
    return errorArr; 
  }
}

// Update the PS pins or angle values or the LIS pin values. Used when an instruction is about
// to be sent. 
void update_system_values(String name, String input[]){
  int input_int[] = stringArr_to_intArr(input);
  
  if(name.equals("ps pin input fields")){ ps.set_servo_pins(input_int); }
  if(name.equals("lis pin input fields")){ lis.set_pins(input_int); }
  if(name.equals("servo angle input fields")){ ps.set_servo_angles(input_int); }
}

// Clears all input fields.
void clearInputFields(){ w.clearTextFields(); }

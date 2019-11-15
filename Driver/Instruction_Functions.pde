// This file holds functions for sending, interpreting and constructing instructions. An instruction can be
// sent via serial communciation, however the serial port must be set and the instruction must be formatted
// a specific way. If serial input is received, it will be sent to the instruction interpreter where it will
// decide what actions to take if the instruction is valid. An instruction can be constructed from user input
// when the user enters and submits pin or servo angle values. 



// Serial communication function that is activated when serial input is received. The serial input is 
// sent to the instruction interpreter to do decide what to do. 
void serialEvent(Serial port){
  port.bufferUntil('\n');
  
  String message = port.readStringUntil('\n');
  if(message != null){  
    // removing last character, which is ' '
    if(message.length() > 0) { message = message.substring(0, message.length() - 1); }
   
    // To view instruction received by GUI uncomment println below. 
    //println("RECEIVED: " + message);
    w.println_message_box("Received: " + message);
    instructionInterpretter(message);
  }
}

// Tries to send an instruction by writting the instruction to the serial port. 
void send_instruction(String instruction, Serial port){
  try{ port.write(instruction); }
  catch(Exception e){ println("Can't sent instruction"); w.println_message_box("ERROR: Can't sent instruction"); }
}

// When an instruction is received it is sent to the instruction interpretter, where it will be parsed
// to determine the instructionID and arguments/data. If the instruction is valid, the instructionID will
// be used to determine which branch to execute.
void instructionInterpretter(String instruction){
  String parsed_instruction[] = instruction.split(" "); //<>//
    if(parsed_instruction[0].equals("LIS_lightIntensities")){ //<>//
      int data[] = extract_instruction_data(parsed_instruction);
      if(data[0] == ERROR_VAL){ println("Instruction datatype error (Corrupt data?)"); w.println_message_box("ERROR: Instruction datatype error (Corrupt data?)"); return;  }
      
      lis.set_intensities(data);
      if(lis.get_auto_flag()){ auto_mode(); }
    }
}

// Extracts the integer data from an instruction. An instruction is an instructionID followed by 
// data members and so the first piece of data is in element 1 of parsed_instruction.
int[] extract_instruction_data(String parsed_instruction[]){
  int size = parsed_instruction.length;
  String string_data[] = new String[size-1];
  int i = 0;
  
  for(;i<size-1; i++){ string_data[i] = parsed_instruction[i+1]; }
  int data[] = stringArr_to_intArr(string_data);
  
  return data;
}

// Returns an instruction to be sent. First validates the datatypes of the data members by calling 
// stringArr_to_intArr. Next, if the instruction is to set pins, it will check for duplicate values.
// If there are duplicate pin entries, an error message will be displayed to the console and the 
// instruction will not be sent. 
String get_instruction(String textFieldID, String instructionID){
 String instruction = "";
 String input[] = get_text(textFieldID);
 
 input = check_empty(input, textFieldID);
 boolean valid_data_types = true;
 int int_input[] = stringArr_to_intArr(input);
 if(int_input[0] == ERROR_VAL){ valid_data_types = false; }
 
 boolean no_duplicates = true;
 if(!textFieldID.equals("servo angle input fields")){
   no_duplicates = check_duplicates(input);
 }
 if(valid_data_types && no_duplicates){
   instruction = make_instruction(instructionID, int_input);
   update_system_values(textFieldID, input); 
 }else if(!valid_data_types){ instruction = "INVALID DATA TYPE"; }
 else if(!no_duplicates){ instruction = "DUPLICATE PIN ENTRIES"; }
   
 return instruction;
}

// Constructs the desired instruction by appending the instructionID to the data members, seperating everything
// with a space " ". 
String make_instruction(String instructionID, int data[]){
  String instruction = instructionID;
  int size = data.length;
  
  for(int i=0; i<size; i++){ instruction = instruction+" "+data[i]; } 
  
  return instruction;
}

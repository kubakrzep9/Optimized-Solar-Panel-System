// The Position System (PS) is the mechanical method for positioning the Solar Panel System.
// The PS controls the servos of the Solar Panel System. The PS can either be operated 
// manually or automatically via an Adjustment System which exists in the Processing GUI. 
// The PS communicates with the GUI by sending instructions. Each instruction has an instructionID 
// followed by data members. The instructionID and each data member is seperated by a single
// white space " ". The PS will be constantly listening and communicating with the GUI. 
// When the serial input is read it is sent to the instructionInterpreter to determine what
// actions to take.
//
// Note: I have noticed that the PS can be a bit stubborn to react properly. There are times
// where it will move because of the move_system method but will not react to instructions 
// received, which use the move_system method. The solution is to simply unplug the power, and 
// usb connections and try again. 
//
// Note: Be careful not to leave power running through the servos for too long. Don't want
// them to lock up or overheat for unknown reasons. 

#include "PS.h"

const int BUFFER_LENGTH = 256;
Position_System ps;
int num_servos = ps.num_servos;

// Setting the pins of the PS and the baud rate for serial communication. 
void setup() {
  Serial.begin(9600);
  int pins[] = {12,13};
  ps.initialize(pins);
  int angles[] = {90,90};
  ps.move_system(angles);
}

// The loop is constantly listening for instructions. When serial input is received
// it is sent to the instructionInterpreter to determine what should be done.
void loop() {
  if(Serial.available()){
    String val = Serial.readStringUntil('\n');
    instructionInterpreter(val);
  }
}

// Seperates the arguments from the instructionID from the parsed instruction 
void extractArguments(String parsedInstr[], int extractedArgs[], int arrSize){
  for(int i=0; i<arrSize; i++){
    extractedArgs[i] = parsedInstr[i+1].toInt();
  }
}

// Parses the instruction sent from the GUI. The first token, first element of parsedInstr,
// is the instructionID which is used to specify which instruction to execute. The tokens 
// following are the arguments (data members). There will either be 6 arguments for the 
// servos, 3 arguments for the coordinate or no arguments. 
void parseInstruction(String instr, String parsedInstr[], int arrSize){
   char input[BUFFER_LENGTH];
   instr.toCharArray(input, BUFFER_LENGTH);
   char *pch;
   pch = strtok(input, " ");
   for(int i=0; i<arrSize && pch != NULL; i++){
      String token(pch);    
      parsedInstr[i] = token;
      pch = strtok(NULL, " ");
   }
}

// When an instruction is received it is sent to the instruction interpretter where it will
// be parsed to determine the instructionID and arguments. If the instruction is valid, the 
// instructionID will be used to determine which branch to execute. 
void instructionInterpreter(String instr){
  int arr_size = num_servos+1;
  String parsed_instr[arr_size];
  parseInstruction(instr, parsed_instr, arr_size);
  String instructionID = parsed_instr[0];
  
  if(instructionID == "PS_moveSystem"){ 
    int args[num_servos]; 
    extractArguments(parsed_instr, args, num_servos+1);
    ps.move_system(args);
  }
}

// This system, the Adjustment System (AS) controls the adjustments made to the Positioning System. This 
// system is used when the program is set to auto mode. The AS returns the adjustment angles to be sent
// as an instruction. 
// 
// Note: The lower the light intensity value the higher the light intensity.



class Adjustment_System{
  private Light_Intensity_System lis;
  private Position_System ps;
  
  Adjustment_System(){ }
  
  Adjustment_System(Light_Intensity_System _lis, Position_System _ps){
    lis = _lis;
    ps = _ps;
  }
  
  
  // Moves to a specified position based on the name of the sensor with the highest light intensity.
  // The name is calculated using the 'calculate_highest_intensity_sensor' function from the GUI LIS. 
  int[] calculate_adjustment_angles(String highest_sensor){
     int adjustment_angles[] = {0,0};
     if(highest_sensor == "central"){ 
       adjustment_angles[0] = 90;
       adjustment_angles[1] = 90;
     } 
     else if(highest_sensor == "front"){ 
       adjustment_angles[0] = 45;
       adjustment_angles[1] = 90;
     }
     else if(highest_sensor == "back"){ 
       adjustment_angles[0] = 135;
       adjustment_angles[1] = 90;
     }
     else if(highest_sensor == "left"){ 
       adjustment_angles[0] = 45;
       adjustment_angles[1] = 0;
     }
     else if(highest_sensor == "right"){ 
       adjustment_angles[0] = 45;
       adjustment_angles[1] = 180;
     }
     return adjustment_angles;
   }
}

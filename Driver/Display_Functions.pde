// This is a helper class for GUI_Settings. This class contains the text formatting functions to display 
// onto the GUI. 



class Display_Functions{  
  // Used to format the font and alignment of a string as text.
  public void display_text(String text, int xcoord, int ycoord, int alignment, PFont f){
    fill(0, 0, 0);
    textFont(f);
    textAlign(alignment);
    text(text, xcoord, ycoord);   
  }
  
  // Used to format the font and alignment of an integer as text.
  public void display_text(int num, int xcoord, int ycoord, int alignment, PFont f){
    fill(0, 0, 0);
    textFont(f);
    textAlign(alignment);
    text(num, xcoord, ycoord);  
  }
  
  // Dispay format function, used to wrap integer data between [  ].  
  public String format_int_data(int val){
    String str = "[ " + Integer.toString(val) + " ]";
    return str;
  }
}

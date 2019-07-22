
// Java Processing code
// a set of global functions that receive messages from 
// gui components, repeated for each 'channel' 
// each channel has a channelBar that has components on it
// this is like a global switch function
// each of these simply calls the widgets 

// controls that I know of return int but some may use float
// and some settings need to be float SO by convention always send float
// soundSetting(string typeOfSetting, int channel, float newValue)
//



/////  CHANNEL 0

void gainChangeControl0(int n) {
  w_sonify.soundSetting("gain", 0, (float) n);
}

void freqChangeControl0(int n) {
  println("freq change 0 returned " + n);
  w_sonify.soundSetting("frequency", 0, (float) n);
}

void thresholdChangeControl0(int n) {
  println("threshold change 0 returned " + n);
  w_sonify.soundSetting("threshold", 0, (float) n);
}

void thresholdTextControl0(String s){
  println("threshold input 0 returned " + s);

    try
    {
      float f = Float.valueOf(s.trim()).floatValue();
      w_sonify.soundSetting("threshold", 0, f );  
    }
    catch (NumberFormatException nfe)
    {
      System.out.println("NumberFormatException: " + nfe.getMessage());
    }

}

void freqTextControl0(String s){
  println("freqinput 0 returned " + s);

    try
    {
      float f = Float.valueOf(s.trim()).floatValue();
      w_sonify.soundSetting("frequency", 0, f );  
    }
    catch (NumberFormatException nfe)
    {
      System.out.println("NumberFormatException: " + nfe.getMessage());
    }

}




/////  CHANNEL 1

void gainChangeControl1(int n) {
  w_sonify.soundSetting("gain", 1, (float) n);
}

void freqChangeControl1(int n) {
  println("freq change 1 returned " + n);
  w_sonify.soundSetting("frequency", 1, (float) n);
}

void thresholdChangeControl1(int n) {
  println("threshold change 1 returned " + n);
  w_sonify.soundSetting("threshold", 1, (float) n);
}

void thresholdTextControl1(String s){
  println("threshold input 1 returned " + s);

    try
    {
      float f = Float.valueOf(s.trim()).floatValue();
      w_sonify.soundSetting("threshold", 1, f );  
    }
    catch (NumberFormatException nfe)
    {
      System.out.println("NumberFormatException: " + nfe.getMessage());
    }

}

void freqTextControl1(String s){
  println("freqinput 1 returned " + s);

    try
    {
      float f = Float.valueOf(s.trim()).floatValue();
      w_sonify.soundSetting("frequency", 1, f );  
    }
    catch (NumberFormatException nfe)
    {
      System.out.println("NumberFormatException: " + nfe.getMessage());
    }

}




/////  CHANNEL 2

void gainChangeControl2(int n) {
  w_sonify.soundSetting("gain", 2, (float) n);
}

void freqChangeControl2(int n) {
  println("freq change 2 returned " + n);
  w_sonify.soundSetting("frequency", 2, (float) n);
}

void thresholdChangeControl2(int n) {
  println("threshold change 2 returned " + n);
  w_sonify.soundSetting("threshold", 2, (float) n);
}

void thresholdTextControl2(String s){
  println("threshold input 2 returned " + s);

    try
    {
      float f = Float.valueOf(s.trim()).floatValue();
      w_sonify.soundSetting("threshold", 2, f );  
    }
    catch (NumberFormatException nfe)
    {
      System.out.println("NumberFormatException: " + nfe.getMessage());
    }

}

void freqTextControl2(String s){
  println("freqinput 2 returned " + s);

    try
    {
      float f = Float.valueOf(s.trim()).floatValue();
      w_sonify.soundSetting("frequency", 2, f );  
    }
    catch (NumberFormatException nfe)
    {
      System.out.println("NumberFormatException: " + nfe.getMessage());
    }

}




/////  CHANNEL 3

void gainChangeControl3(int n) {
  w_sonify.soundSetting("gain", 3, (float) n);
}

void freqChangeControl3(int n) {
  println("freq change 3 returned " + n);
  w_sonify.soundSetting("frequency", 3, (float) n);
}

void thresholdChangeControl3(int n) {
  println("threshold change 3 returned " + n);
  w_sonify.soundSetting("threshold", 3, (float) n);
}

void thresholdTextControl3(String s){
  println("threshold input 3 returned " + s);

    try
    {
      float f = Float.valueOf(s.trim()).floatValue();
      w_sonify.soundSetting("threshold", 3, f );  
    }
    catch (NumberFormatException nfe)
    {
      System.out.println("NumberFormatException: " + nfe.getMessage());
    }

}

void freqTextControl3(String s){
  println("freqinput 3 returned " + s);

    try
    {
      float f = Float.valueOf(s.trim()).floatValue();
      w_sonify.soundSetting("frequency", 3, f );  
    }
    catch (NumberFormatException nfe)
    {
      System.out.println("NumberFormatException: " + nfe.getMessage());
    }

}




/////  CHANNEL 4

void gainChangeControl4(int n) {
  w_sonify.soundSetting("gain", 4, (float) n);
}

void freqChangeControl4(int n) {
  println("freq change 4 returned " + n);
  w_sonify.soundSetting("frequency", 4, (float) n);
}

void thresholdChangeControl4(int n) {
  println("threshold change 4 returned " + n);
  w_sonify.soundSetting("threshold", 4, (float) n);
}

void thresholdTextControl4(String s){
  println("threshold input 4 returned " + s);

    try
    {
      float f = Float.valueOf(s.trim()).floatValue();
      w_sonify.soundSetting("threshold", 4, f );  
    }
    catch (NumberFormatException nfe)
    {
      System.out.println("NumberFormatException: " + nfe.getMessage());
    }

}

void freqTextControl4(String s){
  println("freqinput 4 returned " + s);

    try
    {
      float f = Float.valueOf(s.trim()).floatValue();
      w_sonify.soundSetting("frequency", 4, f );  
    }
    catch (NumberFormatException nfe)
    {
      System.out.println("NumberFormatException: " + nfe.getMessage());
    }

}




/////  CHANNEL 5

void gainChangeControl5(int n) {
  w_sonify.soundSetting("gain", 5, (float) n);
}

void freqChangeControl5(int n) {
  println("freq change 5 returned " + n);
  w_sonify.soundSetting("frequency", 5, (float) n);
}

void thresholdChangeControl5(int n) {
  println("threshold change 5 returned " + n);
  w_sonify.soundSetting("threshold", 5, (float) n);
}

void thresholdTextControl5(String s){
  println("threshold input 5 returned " + s);

    try
    {
      float f = Float.valueOf(s.trim()).floatValue();
      w_sonify.soundSetting("threshold", 5, f );  
    }
    catch (NumberFormatException nfe)
    {
      System.out.println("NumberFormatException: " + nfe.getMessage());
    }

}

void freqTextControl5(String s){
  println("freqinput 5 returned " + s);

    try
    {
      float f = Float.valueOf(s.trim()).floatValue();
      w_sonify.soundSetting("frequency", 5, f );  
    }
    catch (NumberFormatException nfe)
    {
      System.out.println("NumberFormatException: " + nfe.getMessage());
    }

}




/////  CHANNEL 6

void gainChangeControl6(int n) {
  w_sonify.soundSetting("gain", 6, (float) n);
}

void freqChangeControl6(int n) {
  println("freq change 6 returned " + n);
  w_sonify.soundSetting("frequency", 6, (float) n);
}

void thresholdChangeControl6(int n) {
  println("threshold change 6 returned " + n);
  w_sonify.soundSetting("threshold", 6, (float) n);
}

void thresholdTextControl6(String s){
  println("threshold input 6 returned " + s);

    try
    {
      float f = Float.valueOf(s.trim()).floatValue();
      w_sonify.soundSetting("threshold", 6, f );  
    }
    catch (NumberFormatException nfe)
    {
      System.out.println("NumberFormatException: " + nfe.getMessage());
    }

}

void freqTextControl6(String s){
  println("freqinput 6 returned " + s);

    try
    {
      float f = Float.valueOf(s.trim()).floatValue();
      w_sonify.soundSetting("frequency", 6, f );  
    }
    catch (NumberFormatException nfe)
    {
      System.out.println("NumberFormatException: " + nfe.getMessage());
    }

}




/////  CHANNEL 7

void gainChangeControl7(int n) {
  w_sonify.soundSetting("gain", 7, (float) n);
}

void freqChangeControl7(int n) {
  println("freq change 7 returned " + n);
  w_sonify.soundSetting("frequency", 7, (float) n);
}

void thresholdChangeControl7(int n) {
  println("threshold change 7 returned " + n);
  w_sonify.soundSetting("threshold", 7, (float) n);
}

void thresholdTextControl7(String s){
  println("threshold input 7 returned " + s);

    try
    {
      float f = Float.valueOf(s.trim()).floatValue();
      w_sonify.soundSetting("threshold", 7, f );  
    }
    catch (NumberFormatException nfe)
    {
      System.out.println("NumberFormatException: " + nfe.getMessage());
    }

}

void freqTextControl7(String s){
  println("freqinput 7 returned " + s);

    try
    {
      float f = Float.valueOf(s.trim()).floatValue();
      w_sonify.soundSetting("frequency", 7, f );  
    }
    catch (NumberFormatException nfe)
    {
      System.out.println("NumberFormatException: " + nfe.getMessage());
    }

}




/////  CHANNEL 8

void gainChangeControl8(int n) {
  w_sonify.soundSetting("gain", 8, (float) n);
}

void freqChangeControl8(int n) {
  println("freq change 8 returned " + n);
  w_sonify.soundSetting("frequency", 8, (float) n);
}

void thresholdChangeControl8(int n) {
  println("threshold change 8 returned " + n);
  w_sonify.soundSetting("threshold", 8, (float) n);
}

void thresholdTextControl8(String s){
  println("threshold input 8 returned " + s);

    try
    {
      float f = Float.valueOf(s.trim()).floatValue();
      w_sonify.soundSetting("threshold", 8, f );  
    }
    catch (NumberFormatException nfe)
    {
      System.out.println("NumberFormatException: " + nfe.getMessage());
    }

}

void freqTextControl8(String s){
  println("freqinput 8 returned " + s);

    try
    {
      float f = Float.valueOf(s.trim()).floatValue();
      w_sonify.soundSetting("frequency", 8, f );  
    }
    catch (NumberFormatException nfe)
    {
      System.out.println("NumberFormatException: " + nfe.getMessage());
    }

}




/////  CHANNEL 9

void gainChangeControl9(int n) {
  w_sonify.soundSetting("gain", 9, (float) n);
}

void freqChangeControl9(int n) {
  println("freq change 9 returned " + n);
  w_sonify.soundSetting("frequency", 9, (float) n);
}

void thresholdChangeControl9(int n) {
  println("threshold change 9 returned " + n);
  w_sonify.soundSetting("threshold", 9, (float) n);
}

void thresholdTextControl9(String s){
  println("threshold input 9 returned " + s);

    try
    {
      float f = Float.valueOf(s.trim()).floatValue();
      w_sonify.soundSetting("threshold", 9, f );  
    }
    catch (NumberFormatException nfe)
    {
      System.out.println("NumberFormatException: " + nfe.getMessage());
    }

}

void freqTextControl9(String s){
  println("freqinput 9 returned " + s);

    try
    {
      float f = Float.valueOf(s.trim()).floatValue();
      w_sonify.soundSetting("frequency", 9, f );  
    }
    catch (NumberFormatException nfe)
    {
      System.out.println("NumberFormatException: " + nfe.getMessage());
    }

}




/////  CHANNEL 10

void gainChangeControl10(int n) {
  w_sonify.soundSetting("gain", 10, (float) n);
}

void freqChangeControl10(int n) {
  println("freq change 10 returned " + n);
  w_sonify.soundSetting("frequency", 10, (float) n);
}

void thresholdChangeControl10(int n) {
  println("threshold change 10 returned " + n);
  w_sonify.soundSetting("threshold", 10, (float) n);
}

void thresholdTextControl10(String s){
  println("threshold input 10 returned " + s);

    try
    {
      float f = Float.valueOf(s.trim()).floatValue();
      w_sonify.soundSetting("threshold", 10, f );  
    }
    catch (NumberFormatException nfe)
    {
      System.out.println("NumberFormatException: " + nfe.getMessage());
    }

}

void freqTextControl10(String s){
  println("freqinput 10 returned " + s);

    try
    {
      float f = Float.valueOf(s.trim()).floatValue();
      w_sonify.soundSetting("frequency", 10, f );  
    }
    catch (NumberFormatException nfe)
    {
      System.out.println("NumberFormatException: " + nfe.getMessage());
    }

}




/////  CHANNEL 11

void gainChangeControl11(int n) {
  w_sonify.soundSetting("gain", 11, (float) n);
}

void freqChangeControl11(int n) {
  println("freq change 11 returned " + n);
  w_sonify.soundSetting("frequency", 11, (float) n);
}

void thresholdChangeControl11(int n) {
  println("threshold change 11 returned " + n);
  w_sonify.soundSetting("threshold", 11, (float) n);
}

void thresholdTextControl11(String s){
  println("threshold input 11 returned " + s);

    try
    {
      float f = Float.valueOf(s.trim()).floatValue();
      w_sonify.soundSetting("threshold", 11, f );  
    }
    catch (NumberFormatException nfe)
    {
      System.out.println("NumberFormatException: " + nfe.getMessage());
    }

}

void freqTextControl11(String s){
  println("freqinput 11 returned " + s);

    try
    {
      float f = Float.valueOf(s.trim()).floatValue();
      w_sonify.soundSetting("frequency", 11, f );  
    }
    catch (NumberFormatException nfe)
    {
      System.out.println("NumberFormatException: " + nfe.getMessage());
    }

}




/////  CHANNEL 12

void gainChangeControl12(int n) {
  w_sonify.soundSetting("gain", 12, (float) n);
}

void freqChangeControl12(int n) {
  println("freq change 12 returned " + n);
  w_sonify.soundSetting("frequency", 12, (float) n);
}

void thresholdChangeControl12(int n) {
  println("threshold change 12 returned " + n);
  w_sonify.soundSetting("threshold", 12, (float) n);
}

void thresholdTextControl12(String s){
  println("threshold input 12 returned " + s);

    try
    {
      float f = Float.valueOf(s.trim()).floatValue();
      w_sonify.soundSetting("threshold", 12, f );  
    }
    catch (NumberFormatException nfe)
    {
      System.out.println("NumberFormatException: " + nfe.getMessage());
    }

}

void freqTextControl12(String s){
  println("freqinput 12 returned " + s);

    try
    {
      float f = Float.valueOf(s.trim()).floatValue();
      w_sonify.soundSetting("frequency", 12, f );  
    }
    catch (NumberFormatException nfe)
    {
      System.out.println("NumberFormatException: " + nfe.getMessage());
    }

}




/////  CHANNEL 13

void gainChangeControl13(int n) {
  w_sonify.soundSetting("gain", 13, (float) n);
}

void freqChangeControl13(int n) {
  println("freq change 13 returned " + n);
  w_sonify.soundSetting("frequency", 13, (float) n);
}

void thresholdChangeControl13(int n) {
  println("threshold change 13 returned " + n);
  w_sonify.soundSetting("threshold", 13, (float) n);
}

void thresholdTextControl13(String s){
  println("threshold input 13 returned " + s);

    try
    {
      float f = Float.valueOf(s.trim()).floatValue();
      w_sonify.soundSetting("threshold", 13, f );  
    }
    catch (NumberFormatException nfe)
    {
      System.out.println("NumberFormatException: " + nfe.getMessage());
    }

}

void freqTextControl13(String s){
  println("freqinput 13 returned " + s);

    try
    {
      float f = Float.valueOf(s.trim()).floatValue();
      w_sonify.soundSetting("frequency", 13, f );  
    }
    catch (NumberFormatException nfe)
    {
      System.out.println("NumberFormatException: " + nfe.getMessage());
    }

}




/////  CHANNEL 14

void gainChangeControl14(int n) {
  w_sonify.soundSetting("gain", 14, (float) n);
}

void freqChangeControl14(int n) {
  println("freq change 14 returned " + n);
  w_sonify.soundSetting("frequency", 14, (float) n);
}

void thresholdChangeControl14(int n) {
  println("threshold change 14 returned " + n);
  w_sonify.soundSetting("threshold", 14, (float) n);
}

void thresholdTextControl14(String s){
  println("threshold input 14 returned " + s);

    try
    {
      float f = Float.valueOf(s.trim()).floatValue();
      w_sonify.soundSetting("threshold", 14, f );  
    }
    catch (NumberFormatException nfe)
    {
      System.out.println("NumberFormatException: " + nfe.getMessage());
    }

}

void freqTextControl14(String s){
  println("freqinput 14 returned " + s);

    try
    {
      float f = Float.valueOf(s.trim()).floatValue();
      w_sonify.soundSetting("frequency", 14, f );  
    }
    catch (NumberFormatException nfe)
    {
      System.out.println("NumberFormatException: " + nfe.getMessage());
    }

}




/////  CHANNEL 15

void gainChangeControl15(int n) {
  w_sonify.soundSetting("gain", 15, (float) n);
}

void freqChangeControl15(int n) {
  println("freq change 15 returned " + n);
  w_sonify.soundSetting("frequency", 15, (float) n);
}

void thresholdChangeControl15(int n) {
  println("threshold change 15 returned " + n);
  w_sonify.soundSetting("threshold", 15, (float) n);
}

void thresholdTextControl15(String s){
  println("threshold input 15 returned " + s);

    try
    {
      float f = Float.valueOf(s.trim()).floatValue();
      w_sonify.soundSetting("threshold", 15, f );  
    }
    catch (NumberFormatException nfe)
    {
      System.out.println("NumberFormatException: " + nfe.getMessage());
    }

}

void freqTextControl15(String s){
  println("freqinput 15 returned " + s);

    try
    {
      float f = Float.valueOf(s.trim()).floatValue();
      w_sonify.soundSetting("frequency", 15, f );  
    }
    catch (NumberFormatException nfe)
    {
      System.out.println("NumberFormatException: " + nfe.getMessage());
    }

}





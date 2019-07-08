
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


/////  CHANNEL 1

void gainChangeControl1(int n) {
  w_sonify.soundSetting("gain", 1, (float) n);
}

void freqChangeControl1(int n) {
  println("freq change 1 returned " + n);
  w_sonify.soundSetting("frequency", 1, (float) n);
}


/////  CHANNEL 2

void gainChangeControl2(int n) {
  w_sonify.soundSetting("gain", 2, (float) n);
}

void freqChangeControl2(int n) {
  println("freq change 2 returned " + n);
  w_sonify.soundSetting("frequency", 2, (float) n);
}


/////  CHANNEL 3

void gainChangeControl3(int n) {
  w_sonify.soundSetting("gain", 3, (float) n);
}

void freqChangeControl3(int n) {
  println("freq change 3 returned " + n);
  w_sonify.soundSetting("frequency", 3, (float) n);
}


/////  CHANNEL 4

void gainChangeControl4(int n) {
  w_sonify.soundSetting("gain", 4, (float) n);
}

void freqChangeControl4(int n) {
  println("freq change 4 returned " + n);
  w_sonify.soundSetting("frequency", 4, (float) n);
}


/////  CHANNEL 5

void gainChangeControl5(int n) {
  w_sonify.soundSetting("gain", 5, (float) n);
}

void freqChangeControl5(int n) {
  println("freq change 5 returned " + n);
  w_sonify.soundSetting("frequency", 5, (float) n);
}


/////  CHANNEL 6

void gainChangeControl6(int n) {
  w_sonify.soundSetting("gain", 6, (float) n);
}

void freqChangeControl6(int n) {
  println("freq change 6 returned " + n);
  w_sonify.soundSetting("frequency", 6, (float) n);
}


/////  CHANNEL 7

void gainChangeControl7(int n) {
  w_sonify.soundSetting("gain", 7, (float) n);
}

void freqChangeControl7(int n) {
  println("freq change 7 returned " + n);
  w_sonify.soundSetting("frequency", 7, (float) n);
}


/////  CHANNEL 8

void gainChangeControl8(int n) {
  w_sonify.soundSetting("gain", 8, (float) n);
}

void freqChangeControl8(int n) {
  println("freq change 8 returned " + n);
  w_sonify.soundSetting("frequency", 8, (float) n);
}


/////  CHANNEL 9

void gainChangeControl9(int n) {
  w_sonify.soundSetting("gain", 9, (float) n);
}

void freqChangeControl9(int n) {
  println("freq change 9 returned " + n);
  w_sonify.soundSetting("frequency", 9, (float) n);
}


/////  CHANNEL 10

void gainChangeControl10(int n) {
  w_sonify.soundSetting("gain", 10, (float) n);
}

void freqChangeControl10(int n) {
  println("freq change 10 returned " + n);
  w_sonify.soundSetting("frequency", 10, (float) n);
}


/////  CHANNEL 11

void gainChangeControl11(int n) {
  w_sonify.soundSetting("gain", 11, (float) n);
}

void freqChangeControl11(int n) {
  println("freq change 11 returned " + n);
  w_sonify.soundSetting("frequency", 11, (float) n);
}


/////  CHANNEL 12

void gainChangeControl12(int n) {
  w_sonify.soundSetting("gain", 12, (float) n);
}

void freqChangeControl12(int n) {
  println("freq change 12 returned " + n);
  w_sonify.soundSetting("frequency", 12, (float) n);
}


/////  CHANNEL 13

void gainChangeControl13(int n) {
  w_sonify.soundSetting("gain", 13, (float) n);
}

void freqChangeControl13(int n) {
  println("freq change 13 returned " + n);
  w_sonify.soundSetting("frequency", 13, (float) n);
}


/////  CHANNEL 14

void gainChangeControl14(int n) {
  w_sonify.soundSetting("gain", 14, (float) n);
}

void freqChangeControl14(int n) {
  println("freq change 14 returned " + n);
  w_sonify.soundSetting("frequency", 14, (float) n);
}


/////  CHANNEL 15

void gainChangeControl15(int n) {
  w_sonify.soundSetting("gain", 15, (float) n);
}

void freqChangeControl15(int n) {
  println("freq change 15 returned " + n);
  w_sonify.soundSetting("frequency", 15, (float) n);
}



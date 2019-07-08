
////////////////////////////////////////////////////
//
//    W_Sonify.pde 
//
//    Widget for the OpenBCI_GUI Processing application to convert EEG signals to audio 
//
//    By Patrick Bills June 2019, based on W_template widget Created by: Conor Russomanno, November 2016
//
//    this widget provides the UI for controlling 
//    sound generation from the timeSeries data
//    it creates channels like the 
///////////////////////////////////////////////////

// uses the beads processing library 
import beads.AudioContext;
import beads.WavePlayer;
import beads.Buffer;
import beads.Glide;

class W_Sonify extends Widget {

    //to see all core variables/methods of the Widget class, refer to Widget.pde
    
    // global  isRunning
    //put your custom variables here...
    
    private boolean visible = true;
    private boolean updating = true;

    // store sound settings for each brain wave in a list of objects, keyed on wave type
    // List<SoundSetting  waveSounds IntList  SoundSetting;
    // waveSounds.set(THETA) = new SoundSettings("sine", 440, 10, 100); 
    
    float[] waveScales;
    private boolean soundEnabled;    
    // private AudioContext sonifyAC;
    // private WavePlayer sonifyWP;
    // private int waveFreq;
    // private Buffer sinetone;
    // private Buffer squaretone;
    // private Glide frequencyGlide;
        
    // Slider gainSlider;
    float sonifyData, sonifyDelta;
    int sonifyDeltaScale, scaleGain;
    int sonifyWave = ALPHA;

    int numChannelBars;
    SoundChannelBar[] channelBars;
    int channelBarHeight;
    float xF, yF, wF, hF, ts_padding, ts_x, ts_y, ts_w, ts_h;
    
    // all sound management goes in this object
    SoundManager soundMgr;

    W_Sonify(PApplet _parent){
     
        super(_parent); //calls the parent CONSTRUCTOR method of Widget (DON'T REMOVE)
        
        //This is the protocol for setting up dropdowns.
        //Note that these 3 dropdowns correspond to the 3 global functions below
        //You just need to make sure the "id" (the 1st String) has the same name as the corresponding function
        
        addDropdown("sonifySoundDropdown", "Tone", Arrays.asList("Sine", "Square"), 0);
        addDropdown("sonifyScaleDropdown", "Scale", Arrays.asList("1", "2","5","10"), 0);
        addDropdown("sonifySoundEnableDropdown", "Audio Enabled", Arrays.asList("off", "on"), 0);
        // parent declared cp5_widget
                
        // is sound for this widget on or off? 
        soundEnabled = false;

        // sinetone = Buffer.SINE;
        // squaretone = Buffer.SQUARE;
 
        // sonifyAC = new AudioContext();
        // waveFreq = 440;

        sonifyDeltaScale = 100;
        scaleGain = 2;
        
        // this is the scaling of the delta to actually hear a sound
        // this should be based on the data we are listening to, and the brain wave (e.g. ALPHA > DELTA => alpha scale < delta scale ) 
        // perhaps an array based on wave types (alpha, beta, etc).   freqScale[ALPHA] = 10, etc.  
        
        xF = float(x); //float(int( ... is a shortcut for rounding the float down... so that it doesn't creep into the 1px margin
        yF = float(y);
        wF = float(w);
        hF = float(h);

        // stolen from time series spacing (10 px padding around)
        ts_padding = 10.0;
        ts_x = xF + ts_padding;
        ts_y = yF + (ts_padding);
        ts_w = wF - ts_padding*2;
        ts_h = hF;


        numChannelBars = nchan; //nchan global var current number of system  (4, 8, or 16)
        println(numChannelBars + " num channelbars");
        channelBars = new SoundChannelBar[numChannelBars];
        
        // ts_h = height of space for bars
        channelBarHeight = int(ts_h/numChannelBars);

       //create our channel bars and populate our channelBars array!
       // channelBar indexing is 0-based, unlike the OpenBCI time series bars
       
        for(int i = 0; i < numChannelBars; i++){
            int channelBarY = int(ts_y) + i*(channelBarHeight); //iterate through bar locations
            channelBars[i] = new SoundChannelBar(_parent, i, int(ts_x), channelBarY, int(ts_w), channelBarHeight, cp5_widget); //int _channelNumber, int _x, int _y, int _w, int _h            
        }

        soundMgr = new SoundManager(100.0f, nchan);

         // baseFrequency is 100, need to change that basedd on drop down
        
          // gainSlider = cp5_widget.addSlider("gainChangeControl")
          //   .setPosition(x + 50, y + 50)
          //   .setRange(1,10)
          //   .setWidth(100)
          //   .setHeight(50)
          //   .setNumberOfTickMarks(10)
          //   .setValue(scaleGain)
          //   .setId(101);

        // all sound moved to sound manager
        // frequencyGlide = new Glide(sonifyAC, waveFreq, 10);
        // sonifyWP = new WavePlayer(sonifyAC, frequencyGlide, sinetone);
        // sonifyAC.out.addInput(sonifyWP);
                
    }

    public boolean isVisible() {
        return visible;
    }
    public boolean isUpdating() {
        return updating;
    }

    public void setVisible(boolean _visible) {
        visible = _visible;
    }
    public void setUpdating(boolean _updating) {
        updating = _updating;
    }
  

    void update(){ 
        // if(visible && updating){     
        super.update(); //calls the parent update() method of Widget (DON'T REMOVE)
      
        //If using a TopNav object, ignore interaction with widget object 
        if (topNav.configSelector.isVisible || topNav.layoutSelector.isVisible) {
          // move channel bar updates?
        } else {
          // do something anyway
        }

        //update channel bars 
        for(int i = 0; i < channelBars.length; i++){
                // each bar simply sets values via UI sent back here
                channelBars[i].update();
        }
        // udpate sound datas
        soundMgr.update();
    }

    void draw(){
        if(visible){  // not sure where this is set.  
          super.draw(); //calls the parent draw() method of Widget (DON'T REMOVE)
          pushStyle();

          for(int i = 0; i < channelBars.length; i++){
              channelBars[i].draw();
          }
          // update sound aspect (this should move to a SoundManager class)
          if (soundEnabled) {
             soundMgr.draw();
            // float newfreq = waveFreq + (sonifyDelta * sonifyDeltaScale * scaleGain);
            // frequencyGlide.setValue(newfreq);         
          }

          popStyle();

        }
    }



    void screenResized(){
        super.screenResized(); //calls the parent screenResized() method of Widget (DON'T REMOVE)

        xF = float(x); //float(int( ... is a shortcut for rounding the float down... so that it doesn't creep into the 1px margin
        yF = float(y);
        wF = float(w);
        hF = float(h);

        ts_x = xF + ts_padding;
        ts_y = yF + (ts_padding);
        ts_w = wF - ts_padding*2;
        ts_h = hF; //  - playbackWidgetHeight - plotBottomWell - (ts_padding*2);
        channelBarHeight = int(ts_h/numChannelBars);

        for(int i = 0; i < channelBars.length; i++){
            int channelBarY = int(ts_y) + i*(channelBarHeight); //iterate through bar locations
            channelBars[i].screenResized(int(ts_x), channelBarY, int(ts_w), channelBarHeight); //bar x, bar y, bar w, bar h
        }

        // all sliders in channelbars now
        // gainSlider.setPosition(x0 + 50, y0 + 50);

    }

    void mousePressed(){
        super.mousePressed(); //calls the parent mousePressed() method of Widget (DON'T REMOVE)

        //put your code here...
        //If using a TopNav object, ignore interaction with widget object (ex. soundStateButton)
        if (!topNav.configSelector.isVisible && !topNav.layoutSelector.isVisible) {
            // if(soundStateButton.isMouseHere()){
            //      soundStateButton.setIsActive(true);
            // }
        }

        for(int i = 0; i < channelBars.length; i++){
            channelBars[i].mousePressed();
        }

    }

    void mouseReleased(){
        super.mouseReleased(); //calls the parent mouseReleased() method of Widget (DON'T REMOVE)

        //put your code here...
        // forward the mouse released to all the bars
        for(int i = 0; i < channelBars.length; i++){
            channelBars[i].mouseReleased();
        }

    }


    void setSoundEnable(boolean b){  
      println ("w_sonify soundEnabled currently " + soundEnabled );
      println ( " message to change to " + b);    
      // check to see if it's actually changed before changing anything
      if (soundEnabled != b){
        soundEnabled = b;
        // now that it's changed, forward message to soundMgr
        if (soundEnabled) {            
            soundMgr.turnSoundOn();
        }
        else {
            soundMgr.turnSoundOff();         
        }
      }
    }
    
    // this is called byt he global GUI callbacks
    // and forwared to the current soundManager
    void soundSetting(String settingName, int channel, int newValue){      
      soundMgr.soundSetting(settingName, channel, newValue);
    }

    void channelOff(int c){
      soundMgr.turnChannelOff(c);
    }

    void channelOn(int c){
      soundMgr.turnChannelOn(c);
    }
  //   void setScale(int s){
  //     scaleGain = s;
  //   }
    
  //   void selectTone(int toneID){
  //     println("tone selected " + toneID);
      
  //     switch(toneID) {
  //       case  1:
                      
  //         break;
  //       case 2:          
  //         sonifyWP.setBuffer(squaretone);          
  //         break;
  //       //  default:
  //       //  sonifyWP.setBuffer(sinetone);
  //     }
  //  }
   
}; // end of widget W_Sonify



void sonifySoundEnableDropdown(int n){
  boolean enableSound;
  switch(n){
    case 0:
      enableSound = false;
      break;
    case 1:
      enableSound = true;      
      break;
    default:
      enableSound = true;
  }
  w_sonify.setSoundEnable(enableSound);
}

//These functions need to be global! These functions are activated when an item from the corresponding dropdown is selected
void sonifySoundDropdown(int n){
    println("Item " + (n+1) + " selected from sonifySoundDropdown");
    // TODO implement tone selection w_sonify.selectTone(n+1);
    closeAllDropdowns(); // do this at the end of all widget-activated functions to ensure proper widget interactivity ... we want to make sure a click makes the menu close
}

void sonifyScaleDropdown(int n){
  // "1", "2","5","10"
  int s = 1;
  
  switch(n){
  case 1:
    s = 1;
   case 2:
     s = 2;
   case 3:
     s = 5;
   case 4:
     s = 10;
   default:
     s = 1;
  }
  // TODO implement scale selection
  // w_sonify.setScale(s);
   
}


// WIP
 
//class SoundManager {
//  // class for one of the sounds generated
//  // based on beads audio lib for Processing
  
//  private WavePlayer soundWP;
//  private String soundToneName;
//  private float soundLevel; // volume level relative to other 
//  private float soundGain;  // volume multiplier to original signal
//  private Buffer soundGen; 
//  private float soundDeltaScale; 
//  private Glide frequencyGlide;
//  private float soundFreq;

//  // constructor
//  SoundSettings(String _toneName, float _freq, float _gain, float _deltaScale){
//    soundToneName = _toneName;
//    // soundWP = new WavePlayer(sonifyAC, frequencyGlide, sinetone);
//    //
  
//  }
  
//  void  setFreq(float _f){
//    soundFreq = _f;
//  }
  
//  float getFreq(){
//    return(soundFreq); 
//  } 
  //   void soundStateChange(){ 
  //     if (soundOn)
  //       soundOff();
  //     else
  //       soundOn();        
  //   }
   
  //   void soundOn(){
  //       println("turn sound on");
  //       soundStateButton.setString("Sound Off");
  //       soundOn = true;
  //       sonifyAC.start();        
  //   }
    
  //   void soundOff(){
  //       println("turning sound off");
  //       soundStateButton.setString("Sound On");
  //       soundOn = false;
  //       sonifyAC.stop();       
  //   }
    
  //   void setScale(int s){
  //     scaleGain = s;
  //   }
    
  //   void selectTone(int toneID){
  //     println("tone selected " + toneID);
      
  //     switch(toneID) {
  //       case  1:
  //         sonifyWP.setBuffer(sinetone);          
  //         break;
  //       case 2:          
  //         sonifyWP.setBuffer(squaretone);          
  //         break;
  //       //  default:
  //       //  sonifyWP.setBuffer(sinetone);
  //     }
  //  }
  
//}

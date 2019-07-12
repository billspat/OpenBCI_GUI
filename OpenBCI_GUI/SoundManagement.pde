import beads.AudioContext;
// for sonify
import beads.WavePlayer;
import beads.Gain;
import beads.Glide;

class SoundManager {
//     a sound manager, input by any kind of data
//     requires a data processing method for handinlg dat

    AudioContext ac;
    int numChannels;
    boolean soundEnabled = false; // changed by sonifier widget
    boolean soundOn = false; // changed by several things
    float baseFreq;  
    Sonifier[] channelSounds;
    ThresholdFilter[] channelFilters;
    // this doesn't belong here but it's here for now
    float[] channelThresholds;

    // this is the scaling of the delta to actually hear a sound
    // this should be based on the data we are listening to, and the brain wave (e.g. ALPHA > DELTA => alpha scale < delta scale ) 
    // perhaps an array based on wave types (alpha, beta, etc).   freqScale[ALPHA] = 10, etc.  
    // these are not used right now, but soon 
    // the sound manager will assign scales to sonifiers based
    // on the data source (channel or wave) known properties
    // int[] deltaScale;
    // deltaScale = new int[5]
    // use the system-wide globals
    // deltaScale[DELTA] = 100
    
    int sonifyDeltaScale = 100;
    int scaleGain = 2;


    SoundManager(float _baseFreq, int _numChannels){
        // master audio context for sounds produced here
        ac = new AudioContext();
        numChannels = _numChannels;
        channelSounds = new Sonifier[numChannels];    
        baseFreq = _baseFreq; // this will likely be removed
       //create our channel bars and populate our channelBars array!

        // this should be in data processing but it's here for now
        channelThresholds = new float[] { 68.0f, 12.0f, 36.0f, 6.75f, 6.7f, 6.7f, 6.7f, 6.7f, 6.7f, 6.7f, 6.7f, 6.7f, 6.7f, 6.7f, 6.7f, 6.7f};
        channelFilters = new ThresholdFilter[16];

        for(int i = 0; i < numChannels; i++){
            // temporary way to make
            channelSounds[i] = new Sonifier(ac, baseFreq * (i+1));
            channelSounds[i].setSoundOn();
            channelSounds[i].setGain(0.2f);
            channelFilters[i] = new ThresholdFilter(channelThresholds[i]);
        } 
        
    }

    void turnSoundOn(){
        println(" sound manager turning sound on");
        soundOn = true;
        // turn it on only if it's not already running
        if ( ! ac.isRunning()) {
                println("sound mgr sound on");
                ac.start();  //
        } else {
            println("turn sound on message received but sound was already running " );
        }
    }
    
    void turnSoundOff(){
        println("sound manager sound off");    
        soundOn = false;
        if ( ac.isRunning() ){ 
            ac.stop();
        } else {
            println("turn sound off message received but sound was not running " );
        }
    }

    // turn each channel on or off
    void turnChannelOn(int c){
         // TODO Chekc boundary  conditions
        // if (c > 0 and c < channelSounds.length()){
           channelSounds[c].setSoundOn(); 
        //}
    }

    void turnChannelOff(int c){
        // TODO Chekc boundary  conditions
    // if (c > 0 and c < channelSounds.length()){ 
        channelSounds[c].setSoundOff(); 
    }

    void soundSetting(String settingName, int channelNum, float settingValue){
        // called by w_sonify widget which is called by the global callback. 
        // values sent as floats 
        // see W_Sonify_channelbar_callbacks.jinja for strings of settingnames
        // TODO use java enum instead of strings here

        println("sound manager got message for " + settingName + " channel " + channelNum + " value " + settingValue);
        switch (settingName) {
            case "gain":
                // possibly process the gain value here
                channelSounds[channelNum].setGain( settingValue);
                break;	
            case "frequency":
                // process value here
                
                channelSounds[channelNum].setFrequency( settingValue);
                break;            
        }
    }

    void printChannelStatus(int c){
        // for debugging, printing state of channel

        println("stat chan,data in, filtered data, gainsetting, actual gain", 
        c, 
        dataProcessing.data_std_uV[c], 
        channelFilters[c].onoff(dataProcessing.data_std_uV[c]), 
        channelSounds[c].gainSetting, 
        channelSounds[c].gain.getValue()
        ) ;
    }

    void update(){
        // time series data, from global dataProcessing object

        // send new data from global data objects
        for(int i = 0; i < numChannels; i++){
            // time series data, from global dataProcessing object            
            // filter using our stored files, returns 0 or 1
            channelSounds[i].update(channelFilters[i].onoff(dataProcessing.data_std_uV[i]));
        } 

        // sync sound processing state with state of widget and state of system
        if (soundEnabled && isRunning)  {
            if (! soundOn )  { turnSoundOn(); } 
        }

        if ( (! soundEnabled) || (! isRunning ) ) {
            if ( soundOn ) { turnSoundOff(); }
        } 

    }  

    void draw(){ // and by 'draw', I mean make noise
        // saved code, this used to adjust the tone frequency with the data
        // float newfreq = waveFreq + (sonifyDelta * sonifyDeltaScale * scaleGain);        
        if (soundOn) {
            for(int i = 0; i < numChannels; i++){
                channelSounds[i].draw();  
                // printChannelStatus(i);  // to debug, uncomment this print statment
            } 
        }
    }

}



///////////////////////////////// filter class
// TODO move to new file, create real OO for filtering data to sound

class ThresholdFilter{
    // simple class to detect when value is above/below a threshold
    // experimenting with different methods
    // TODO look into filters that come with this system
    // or other filtering signal processing libaries

    float threshold;

    ThresholdFilter(float _threshold){
        threshold = _threshold;
    }

    float filter(float x){
        return( Math.abs(x) < threshold ? 0.0f : x);
    }

    float onoff(float x){
        return( Math.abs(x) < threshold ? 0.0f : 1.0f);
    }

    boolean yesno(float x){
        return( Math.abs(x) < threshold ? false : true);
    }

}

///////////////////////////////// sound class
// TODO convert this to an abstract class

class Sonifier {

    AudioContext ac;
    float gainMax, baseFreq;
    float gainSetting;
    float currentData, previousData, maxData, minData;
    Glide gainGlide, frequencyGlide;
    Gain gain;
    WavePlayer wp;
    ThresholdFilter filter;
    float defaultThreshold = 6.0f;

    Sonifier(AudioContext _ac){
        init(_ac);
    }

    Sonifier(AudioContext _ac, float _baseFreq){
        init(_ac);
        setBaseFreq(_baseFreq);
    // another construction but this one takes a filter setting
    }

    Sonifier(AudioContext _ac, float _baseFreq, float _filtersetting){    
        init(_ac);
        setBaseFreq(_baseFreq);
        setFilterSetting(_filtersetting);
    }

    void setBaseFreq(float f){
        baseFreq = f;
        setFrequency(baseFreq);
    }

    void init(AudioContext _ac){
                // parent audio context, controlled by parent object (manager)
        ac = _ac;
        // initial gain setting, could be a param
        gainSetting = 0.2f; 
        gainGlide = new Glide(ac, gainSetting, 10);
        gain = new Gain(ac, 1, gainGlide);

        baseFreq = 100;
        frequencyGlide = new Glide(ac, baseFreq , 10);
        // sine wave, this could be a param
        
        wp = new WavePlayer(ac, frequencyGlide, Buffer.SINE);
        gain.addInput(wp);
        ac.out.addInput(gain);
        filter = new ThresholdFilter(defaultThreshold);

    }

    void setFilterSetting(float v){
        // abstract setter for future dev
        // getter is currently self.filter.threshold
        filter.threshold = v;
    }

    void setSoundOn(){
        if (wp.isPaused()){
            wp.pause(false);
            }
    }

    void setSoundOff(){
        // TODO: check if already stopped
        if (! wp.isPaused()){
            wp.pause(true); 
            }
    }

    void setGain(float gainVal){
        // process the value sent
        if ( gainGlide.getValue() != gainVal){
            gainSetting = gainVal;
            gainGlide.setValue(gainVal);
        }
    }

    void gainZero(){
        // zero out gain does not pause the audo context
        // but produces zero sound. 
        // this is used in response to data inputs, not on/off switch
        // first check if gain is already zero to avoid audio artifacts
        if ( gainGlide.getValue() != 0.0f){
            gainGlide.setValue(0.0f);}
    }

    void gainRestore(){
        // restore the gain does not pause/unpaus audio 
        // but produces zero sound. 
        // this is used in response to data inputs, not on/off switch
        // first check if gain is already at setting, to avoid audio artifacts
        if ( gainGlide.getValue() != gainSetting){
            gainGlide.setValue(gainSetting);
        }
    }

    void setFrequency(float freqVal){        
        frequencyGlide.setValue(freqVal);         
    }
    
    void update(float newData){
        // called by sound manager update method
        // unlike other Processing update() methods, this one
        // receieves data from the manager
        // this is so the sonifier doesn't need to know the channel
        // or about any global data structures 
        // TODO actually process the data for this sonifier
        previousData = currentData;
        currentData = newData;

        // track the extremes.... for adjusting the scale dynamically
        maxData = ( maxData >=currentData) ? maxData : currentData;
        minData = ( minData <=currentData) ? minData : currentData;
    }

    void draw(){ 
        // called by parent sound manager draw method
        // this current basic method turns this sonifier on/off based on 1/0 filter
        // it changes the gain instead of turning the whole channel on/off
        // the UI has a button for turning it on/off
        if (currentData > 0) {            
           gainRestore();
        } else {
            // zero data, zero gain
            // use method to set gain to zero, to preserve gain setting
            gainZero();
        }
    }

}  // end sonifier class

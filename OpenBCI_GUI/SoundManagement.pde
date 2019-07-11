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
        channelThresholds = new float[] { 68.0f, 12.0f, 36.0f, 6.75f, 5.0f, 5.0f, 5.0f, 5.0f, 5.0f, 5.0f, 5.0f, 5.0f, 5.0f, 5.0f, 5.0f, 5.0f};
        channelFilters = new ThresholdFilter[16];

        for(int i = 0; i < numChannels; i++){
            // temporary way to make
            println(" chan " + i + " baseFreq " + baseFreq * (i+1) + " theshold " + channelThresholds[i]);
            channelSounds[i] = new Sonifier(ac, baseFreq * (i+1));
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


    void update(){
        // time series data, from global dataProcessing object
        // get new data from global data objects
        for(int i = 0; i < numChannels; i++){
            // time series data, from global dataProcessing object            
            // filter using our stored files, returns 0 or 1
            channelSounds[i].update(channelFilters[i].onoff(dataProcessing.data_std_uV[i]));
        } 

        // set the new delta for each channel
        // types of data that can be gotten        
        // dataProcessing.headWidePower[ALPHA]
        // Float savedValue = sonifyData;
        // sonifyData = dataProcessing.headWidePower[sonifyWave];
        // sonifyDelta = savedValue - sonifyData;
        // float newfreq = waveFreq + (sonifyDelta * sonifyDeltaScale * scaleGain);
        // frequencyGlide.setValue(newfreq);  
        if (soundEnabled && isRunning)  {
            if (! soundOn )  { turnSoundOn(); } 
        }

        if ( (! soundEnabled) || (! isRunning ) ) {
            if ( soundOn ) { turnSoundOff(); }
        } 

        
    }  

    void draw(){
        // float newfreq = waveFreq + (sonifyDelta * sonifyDeltaScale * scaleGain);        

        // if updating and soundEnabled and 
        
        if (soundOn) {
            for(int i = 0; i < numChannels; i++){
                channelSounds[i].draw();  
            } // and by 'draw', I mean make noise
        }
    }

}

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
////////// sound class
// TODO convert this to an abstract class

class Sonifier {

    AudioContext ac;
    float gainMax, baseFreq;
    float gainSetting;
    float currentData, previousData, maxData, minData;
    Glide gainGlide, frequencyGlide;
    Gain gain;
    WavePlayer wp;

    Sonifier(AudioContext _ac, float _baseFreq){
        // parent audio context, controlled by parent object (manager)
        ac = _ac;
        // initial gain setting, could be a param
        gainSetting = 0.2f; 
        gainGlide = new Glide(ac, gainSetting, 10);
        gain = new Gain(ac, 1, gainGlide);

        baseFreq = _baseFreq;
        frequencyGlide = new Glide(ac, _baseFreq , 10);
        // sine wave, this could be a param
        
        wp = new WavePlayer(ac, frequencyGlide, Buffer.SINE);
        gain.addInput(wp);
        ac.out.addInput(gain);

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
        // Gain modulation by data
        // TODO process the data to make sense of the gain
        // println("freq " + baseFreq + " data is " + currentData );
        if (currentData > 0) {
            // zero data, gain zero
            gainZero();
        } else {
            gainRestore();
        }
        
    }

}



// class TimeSeriesSoundManager extends SoundManager{
    // a class of sound manager just for time series channels
    // has an array of sound mangers for n channels?
    // however we wan_t an api that can handle mutlp
// }


// two ways for channels
// TimeSeriesSoundManager[] ts_sound_mgrs new TimeSeriesSoundManager[nchan];
// thischan = 3;
// ts_sound_mgrs[thischan].setGain(n);
// 
// or manager of managers
// only valuable to do something will all channels at once
// ts_manager.setGain(thischan, gain_n);
// ts_manager.silence_all_channels();
// save settings for all channels and apply them all at once
//
// ts_manager.setttings(ts_sound_settings); 
// 
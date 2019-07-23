
//------------------------------------------------------------------------
//                       Global Variables & Instances
//------------------------------------------------------------------------

DataProcessing_User dataProcessing_user;
boolean drawEMG = false; //if true... toggles on EEG_Processing_User.draw and toggles off the headplot in Gui_Manager
boolean drawAccel = false;
boolean drawPulse = false;
boolean drawFFT = true;
boolean drawBionics = false;
boolean drawHead = true;

//------------------------------------------------------------------------
//                            Classes
//------------------------------------------------------------------------

class DataProcessing_User {
    private float fs_Hz;  //sample rate
    private int n_chan;

    // added by sonifier
    // dataProcessing_user.channelStats[c].peaked();
    RunningStats[] channelStats;

    //class constructor
    DataProcessing_User(int NCHAN, float sample_rate_Hz) {
        n_chan = NCHAN;
        fs_Hz = sample_rate_Hz;

        // sonifier - store running statistics for each channel
        channelStats  = new RunningStats[n_chan];
        for( int c=0; c < n_chan; c++){
            channelStats[c] = new RunningStats();
        }
    }

    //add some functions here...if you'd like
    
    //here is the processing routine called by the OpenBCI main program...update this with whatever you'd like to do
    public void process(float[][] data_newest_uV, //holds raw bio data that is new since the last call
        float[][] data_long_uV, //holds a longer piece of buffered EEG data, of same length as will be plotted on the screen
        float[][] data_forDisplay_uV, //this data has been filtered and is ready for plotting on the screen
        FFT[] fftData) {              //holds the FFT (frequency spectrum) of the latest data

        //for example, you could loop over each EEG channel to do some sort of time-domain processing
        //using the sample values that have already been filtered, as will be plotted on the display
        // float EEG_value_uV;

        // sonifier - update the running stats
        for(int i=0; i < n_chan; i++){
            int lastIndex = data_forDisplay_uV[i].length-1;
            // float[] chanData = data_forDisplay_uV[i][];
            float lastValue = data_forDisplay_uV[i][ lastIndex ]; // chanData[chanData.length - 1]
            channelStats[i].push( lastValue );

            // for example
            // data_avg_uV[c] =  channelStats[c].mean();
            
        }
        
    }

}

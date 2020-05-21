// Sonify_Stats.pde
// numerical processing added for EEG Sonifier project
// used by DataProcessing_User.pde 

class RunningStats{
    // this is to help calculate running stats on the float arrays used in this program
    // example
    // RunningStats[] rs = new RunningStats()[n_chan];  
    // new data ==> data_newest_uV[][]
    // for (int i = 0; i < n_chan; i++;){
    //      rs[i].push(data_newest_uV[i][data_newest_uV.length -1]);
    //      float channel_mean = rs[i].mean();
    //      println("mean for channel", i, channel_mean);
    // }
    private int m_n;
    float m_oldM, m_newM, m_oldS, m_newS, m_delta, m_oldDelta, m_oldX, m_Max, m_Min;
    boolean m_deltaChange;

   RunningStats(){
        m_n = 0;
        m_deltaChange = false;
        m_Max = m_Min = 0.0f;

    }

    void clear() { 
        m_n = 0;
    }

    void push(float x){
        ++m_n;

        // See Knuth TAOCP vol 2, 3rd edition, page 232
        if (m_n == 1) {
            m_oldM = m_newM = m_delta = x;
            m_oldS = 0.0;
            m_Min = m_Max = m_oldX = x;
            m_deltaChange = false;
            

        } else {
            m_newM = m_oldM + (x - m_oldM)/m_n;
            m_newS = m_oldS + (x - m_oldM)*(x - m_newM);

            // update delta
            m_oldDelta = m_delta;
            m_delta = x - m_oldX;
            
            // check if the sign of delta has change changed.  
            // If the signs of two nums a,b are different then  a*b < 0 ) 
            // if at least on delta is 0, then data was 0 and is now changing, don't count that
            m_deltaChange = ( m_oldDelta * m_delta < 0 ) ? false : true; 
            m_Max = ( m_Max < x ) ? x : m_Max;
            m_Min = ( m_Min > x ) ? x : m_Min;


            // set up for next iteration
            m_oldM = m_newM; 
            m_oldS = m_newS;
            m_oldX = x;
        }   
    }


    int numValues(){
        return( m_n);
    }
    // aliases
 
    int n(){ 
        return( numValues()); 
     }

    float delta(){
        return(m_delta);
    }

    float max(){
        // this is zero when no data pushed, which is not correct
        return m_Max;
    }

    float min(){
        // this is zero when no data pushed, which is not correct
        return m_Min;
    }
    

    boolean peaked(){
        return m_deltaChange ;
    }

    float mean(){
        return ((m_n > 0) ? m_newM : 0.0);
    }

    float variance(){
        return ( (m_n > 1) ? m_newS/(m_n - 1) : 0.0 );
    }

    float standardDeviation(){
        // need to do some float conversion since Math uses double
        float v = (float) Math.sqrt( variance() ) ;
        return(v);
    }
}

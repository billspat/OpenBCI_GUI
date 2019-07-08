// channelBar for W_Sonify widget
// currently managing sound settings for each channel 

class SoundChannelBar{
    // this is based on ChannelBar used in the TimeSeries Widget
    // main differences are 
    // 1) that channel number stars with 0 here, and to match all other zero-based arrays
    // time series widgets the channel array starts at 1, here it starts at zero
    //  the String channelString does start at 1
    // 2) no plotting here (so far, may have a volume display)
    // 3) channels have CP5 controls 
    
    // 
    int channelNumber; // starts at zero, so this is technically true channel-1 
    String channelString; // starts at 1 so it dispalys ok. 
    int x, y, w, h;
    private boolean isOn; //true means data is streaming and channel is active on hardware ... this will send message to OpenBCI Hardware
    Button onOffButton;
    int onOff_diameter;
    public float gainMax;
    TextBox voltageValue;
    boolean drawVoltageValue = true;
    ControlP5 parentCP5;
    Slider gainSlider;

    SoundChannelBar(PApplet _parent, int _channelNumber, int _x, int _y, int _w, int _h, ControlP5 _cp5){ // channel number, x/y location, height, width

        parentCP5 = _cp5;
        // zero-based index channel numbers in this version
        channelNumber = _channelNumber;
        // display should be 1-based index
        channelString = str(channelNumber+1);  // since channelNumbers like Java arrays start at zero

        isOn = true;

        x = _x;
        y = _y;
        w = _w;
        h = _h;

        if(h > 26){
            onOff_diameter = 26;
        } else{
            onOff_diameter = h - 2;
        }

        onOffButton = new Button (x + 6, y + int(h/2) - int(onOff_diameter/2), onOff_diameter, onOff_diameter, channelString, fontInfo.buttonLabel_size);
        onOffButton.setHelpText("Click to toggle sound for channel " + channelString + ".");
        onOffButton.setFont(h2, 16);
        onOffButton.setCircleButton(true);
        onOffButton.setColorNotPressed(channelColors[(channelNumber)%8]); //Set channel button background colors
        onOffButton.textColorNotActive = color(255); //Set channel button text to white
        onOffButton.hasStroke(false);


        voltageValue = new TextBox("", x + 36 + 4  + (w - 36 - 4 ) - 2, y + h);
        voltageValue.textColor = color(bgColor);
        voltageValue.alignH = RIGHT;
        // voltageValue.alignV = TOP;
        voltageValue.drawBackground = true;
        voltageValue.backgroundColor = color(255,255,255,125);


        // new var slider hieight or control heigh
        // functions are  gainChangeControl01,  gainChangeControl02, etc

        // yuck setting this value by hand
        gainMax = 10.0f;  //TODO put this in the constructor, or determine from parent 
        // need to sync this value between the slider creation and value return
        gainSlider = parentCP5.addSlider("gainChangeControl" + channelNumber) 
            .setPosition(x + 50,  y + int(h/2) - int(onOff_diameter/2))
            .setRange(0,gainMax)
            .setWidth(110)
            .setHeight(onOff_diameter-1)
            .setLabel("gain")
            .setNumberOfTickMarks((int) gainMax + 1)
            .showTickMarks(true)
            .setValue(5);
        
    }


    void update(){

        //update the voltage value text string
        String fmt; float val;

        //update the voltage values
        val = dataProcessing.data_std_uV[channelNumber];
        voltageValue.string = String.format(getFmt(val),val) + " uVrms";

        // get data for audio for this channel!
        // process audio for this channel
        // send data to the sound manager for this channel

        // soundChannelMgr.update(data);

        // if (is_railed != null) {
        //     if (is_railed[channelNumber-1].is_railed == true) {
        //         voltageValue.string = "RAILED";
        //     } else if (is_railed[channelNumber-1].is_railed_warn == true) {
        //         voltageValue.string = "NEAR RAILED - " + String.format(getFmt(val),val) + " uVrms";
        //     }
        // }
    }

    void draw(){
        pushStyle();

        //draw channel holder background
        stroke(31,69,110, 50);
        fill(255);
        rect(x,y,w,h);

        //draw onOff Button
        onOffButton.draw();

        //draw plot
        stroke(31,69,110, 50);
        fill(color(125,30,12,30));

        rect(x + 36 + 4, y, w - 36 - 4, h);

        if(isOn){
            voltageValue.draw();
        }

        popStyle();
    }


    private String getFmt(float val) {
        String fmt;
            if (val > 100.0f) {
                fmt = "%.0f";
            } else if (val > 10.0f) {
                fmt = "%.1f";
            } else {
                fmt = "%.2f";
            }
            return fmt;
    }


    void screenResized(int _x, int _y, int _w, int _h){
        x = _x;
        y = _y;
        w = _w;
        h = _h;

        if(h > 26){
            onOff_diameter = 26;
            onOffButton.but_dx = onOff_diameter;
            onOffButton.but_dy = onOff_diameter;
        } else{
            // println("h = " + h);
            onOff_diameter = h - 2;
            onOffButton.but_dx = onOff_diameter;
            onOffButton.but_dy = onOff_diameter;
        }

        onOffButton.but_x = x + 6;
        onOffButton.but_y = y + int(h/2) - int(onOff_diameter/2);
        
        voltageValue.x = x + 36 + 4  + (w - 36 - 4) - 2;
        voltageValue.y = y + h;
    
        gainSlider.setPosition(x + 50,  y + int(h/2) - int(onOff_diameter/2));
    }

    void mousePressed(){
        if(onOffButton.isMouseHere()){
            println("[" + channelNumber + "] onOff pressed");
            onOffButton.setIsActive(true);
        }

    }

    void mouseReleased(){
        if(onOffButton.isMouseHere()){
            println( channelNumber + " onOff released");
            if(isOn){  // if channel is active
                isOn = false; // deactivate it                
                w_sonify.channelOff(channelNumber);
                onOffButton.setColorNotPressed(color(50));
            }
            else { // if channel is not active
                isOn = true;
                w_sonify.channelOn(channelNumber);
                onOffButton.setColorNotPressed(channelColors[(channelNumber)%8]);
            }

            onOffButton.setIsActive(false);
        }

    }
}


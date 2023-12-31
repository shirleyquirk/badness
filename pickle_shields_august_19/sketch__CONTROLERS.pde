import controlP5.*;
ControlFrame cf;

float vizTimeSlider, colorSwapSlider, colorTimerSlider, bgDimmer, boothDimmer, digDimmer, roofPulse, backParsSlider, backDropSlider, cansSlider, movesSlider;
float cansPulse, cans1Pulse, cans2Pluse, cans3Pulse, speedSlider, tweakSlider, testSlider3, blurSlider, rigDimmer, multiViz1, multiViz2, multiViz3;
float shimmerSlider, beatSlider, boothParSlider, backParSlider, secondVizSlider, roofDimmer;

class ControlFrame extends PApplet {

  int controlW, controlH;
  PApplet parent;
  ControlP5 cp5;

  public ControlFrame(PApplet _parent, int _w, int _h, String _name) {
    super();   
    parent = _parent;
    controlW=_w;
    controlH=_h;
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
  }

  public void settings() {
    size(controlW, controlH);
  }

  public void setup() {
    surface.setAlwaysOnTop(true);
    surface.setLocation(surfacePositionX, surfacePositionY+parent.height);

    //drawingSetup();
    myFont = createFont("Lucida Sans", 18);
    textFont(myFont);
    rectMode(CENTER);
    ellipseMode(RADIUS);
    imageMode(CENTER);
    noStroke();

    cp5 = new ControlP5(this);

    // slider colours
    color act = #07E0D3;
    color act1 = #00FC84;
    color bac = #370064;
    color bac1 = #225F01;
    color slider = #E07F07;
    color slider1 = #E0D607;
    /// font for slider info
    //PFont pfont = createFont("Abadi MT Condensed Light", 16, true);  // what the fuk?!
    //ControlFont font = new ControlFont(pfont);

    float x = 10;
    float y = 20;
    int wide = 80;           // x size of sliders
    int high = 14;           // y size of slider
    float row = high +4;     // distance between rows
    float clm = 210;         // distance between coloms

    //////////////////////////////// FIRST COLOUM OF SLIDERS
    cp5.addSlider("vizTimeSlider") // name used throughout sketch to link to slider
      .plugTo(parent, "vizTimeSlider")
      .setPosition(x, y)
      .setSize(wide, high)
      //.setFont(font)
      .setRange(0, 1)
      .setValue(0.5) // start value of slider
      .setColorActive(act) 
      .setColorBackground(bac) 
      .setColorForeground(slider) 
      ;
    cp5.addSlider("colorTimerSlider")
      .plugTo(parent, "colorTimerSlider")
      .setPosition(x, y+row)
      .setSize(wide, high)
      //.setFont(font)
      .setRange(0, 1)
      .setValue(0.45) // start value of slider
      .setColorActive(act1) 
      .setColorBackground(bac1) 
      .setColorForeground(slider1) 
      ;
    cp5.addSlider("colorSwapSlider")
      .plugTo(parent, "colorSwapSlider")
      .setPosition(x, y+row*2)
      .setSize(wide, high)
      //.setFont(font)
      .setRange(0, 1)
      .setValue(0.9) // start value of slider
      .setColorActive(act) 
      .setColorBackground(bac) 
      .setColorForeground(slider) 
      ;
    ////////////////////////////////// 2nd coloum of sliders
    cp5.addSlider("boothDimmer")
      .plugTo(parent, "boothDimmer")
      .setPosition(x+clm, y)
      .setSize(wide, high)
      //.setFont(font)
      .setRange(0, 1)
      .setValue(0.32)    // start value of slider
      .setColorActive(act1) 
      .setColorBackground(bac1) 
      .setColorForeground(slider1) 
      ;
    cp5.addSlider("digDimmer")
      .plugTo(parent, "digDimmer")

      .setPosition(x+clm, y+row)
      .setSize(wide, high)
      //.setFont(font)
      .setRange(0, 1)
      .setValue(0.32) // start value of slider
      .setColorActive(act) 
      .setColorBackground(bac) 
      .setColorForeground(slider) 
      ;
    cp5.addSlider("rigDimmer")
      .plugTo(parent, "rigDimmer")
      .setPosition(x+clm, y+row*2)
      .setSize(wide, high)
      //.setFont(font)
      .setRange(0, 1)
      .setValue(dimmer) // start value of slider
      .setColorActive(act1) 
      .setColorBackground(bac1) 
      .setColorForeground(slider1) 
      ;

    ////////////// set x to start of 2nd panel
    //x = x+rx-(rw/2);
    x +=clm+clm;

    ///////////////////////////////// third coloum of sliders
    cp5.addSlider("bgDimmer")
      .plugTo(parent, "bgDimmer")

      .setPosition(x, y)
      .setSize(wide, high)
      //.setFont(font)
      .setRange(0, 1)
      .setValue(1)    // start value []ppof slider
      .setColorActive(act) 
      .setColorBackground(bac) 
      .setColorForeground(slider) 
      ;
    cp5.addSlider("shimmerSlider")
      .plugTo(parent, "shimmerSlider")
      .setPosition(x, y+row)
      .setSize(wide, high)
      //.setFont(font)
      .setRange(0, 1)
      .setValue(0.3) // start value of slider
      .setColorActive(act1) 
      .setColorBackground(bac1) 
      .setColorForeground(slider1) 
      ;
    cp5.addSlider("beatSlider")
      .plugTo(parent, "beatSlider")
      .setPosition(x, y+row*2)
      .setSize(wide, high)
      //.setFont(font)
      .setRange(0, 1)
      .setValue(0.85) // start value of slider
      .setColorActive(act) 
      .setColorBackground(bac) 
      .setColorForeground(slider) 
      ;

    /////////////////////////////// FOURTH coloum of sliders
    cp5.addSlider("secondVizSlider")
      .plugTo(parent, "secondVizSlider")
      .setPosition(x+clm, y)
      .setSize(wide, high)
      //.setFont(font)
      .setRange(0, 1)
      .setValue(1) // start value of slider
      .setColorActive(act1) 
      .setColorBackground(bac1) 
      .setColorForeground(slider1) 
      ;
    cp5.addSlider("tweakSlider")
      .plugTo(parent, "tweakSlider")
      .setPosition(x+clm, y+row)
      .setSize(wide, high)
      //.setFont(font)
      .setRange(0, 1)
      .setValue(0) // start value of slider
      .setColorActive(act) 
      .setColorBackground(bac) 
      .setColorForeground(slider) 
      ;
    cp5.addSlider("blurSlider")
      .plugTo(parent, "blurSlider")
      .setPosition(x+clm, y+row*2)
      .setSize(wide, high)
      //.setFont(font)
      .setRange(0, 1)
      .setValue(1) // start value of slider
      .setColorActive(act1) 
      .setColorBackground(bac1) 
      .setColorForeground(slider1) 
      ;


    clm+=clm;
    /////////////////////////////// FITH coloum of sliders
    cp5.addSlider("roofDimmer")
      .plugTo(parent, "roofDimmer")
      .setPosition(x+clm, y)
      .setSize(wide, high)
      //.setFont(font)
      .setRange(0, 1)
      .setValue(0) // start value of slider
      .setColorActive(act1) 
      .setColorBackground(bac1) 
      .setColorForeground(slider1) 
      ;
    //cp5.addSlider("tweakSlider")
    //  .plugTo(parent, "tweakSlider")
    //  .setPosition(x+clm, y+row)
    //  .setSize(wide, high)
    //  //.setFont(font)
    //  .setRange(0, 1)
    //  .setValue(0) // start value of slider
    //  .setColorActive(act) 
    //  .setColorBackground(bac) 
    //  .setColorForeground(slider) 
    //  ;
    //cp5.addSlider("blurSlider")
    //  .plugTo(parent, "blurSlider")
    //  .setPosition(x+clm, y+row*2)
    //  .setSize(wide, high)
    //  //.setFont(font)
    //  .setRange(0, 1)
    //  .setValue(1) // start value of slider
    //  .setColorActive(act1) 
    //  .setColorBackground(bac1) 
    //  .setColorForeground(slider1) 
    //  ;


    ///////////////////////////////// FIFTH coloum of sliders
    //cp5.addSlider("multiViz1")
    //  .setPosition(x+clm+clm+clm+clm, y)
    //  .setSize(wide, high)
    //  .setFont(font)
    //  .setRange(0, 1)
    //  .setValue(0)    // start value of slider
    //  .setColorActive(act) 
    //  .setColorBackground(bac) 
    //  .setColorForeground(slider) 
    //  ;
    //// extra slider f0r pulse
    //cp5.addSlider("multiViz2")
    //  .setPosition(x+clm+clm+clm+clm, y+row)
    //  .setSize(wide, high)
    //  .setFont(font)
    //  .setRange(0, 1)
    //  .setValue(0) // start value of slider
    //  .setColorActive(act1) 
    //  .setColorBackground(bac1) 
    //  .setColorForeground(slider1) 
    //  ;
    //cp5.addSlider("multiViz3")
    //  .setPosition(x+clm+clm+clm+clm, y+row*2)
    //  .setSize(wide, high)
    //  .setFont(font)
    //  .setRange(0, 1)
    //  .setValue(0) // start value of slider
    //  .setColorActive(act) 
    //  .setColorBackground(bac) 
    //  .setColorForeground(slider) 
    //  ;


    /////////////////////// test sliders to change variables vertical 
    //cp5.addSlider("speedSlider")
    //  .setPosition(5, 130)
    //  .setSize(high, wide)
    //  .setFont(font)
    //  .setRange(0, 1)
    //  .setValue(0.5) // start value of slider
    //  .setColorActive(act1) 
    //  .setColorBackground(bac1) 
    //  .setColorForeground(slider1) 
    //  ;
    //cp5.addSlider("tweakSlider")
    //  .setPosition(5, 230)
    //  .setSize(high, wide)
    //  .setFont(font)
    //  .setRange(0, 1)
    //  .setValue(0.2) // start value of slider
    //  .setColorActive(act) 
    //  .setColorBackground(bac) 
    //  .setColorForeground(slider) 
    //  ;
    //cp5.addSlider("testSlider3")
    //  .setPosition(5, 530)
    //  .setSize(high, wide)
    //  .setFont(font)
    //  .setRange(0, 1)
    //  .setValue(0.5) // start value of slider
    //  .setColorActive(act1) 
    //  .setColorBackground(bac1) 
    //  .setColorForeground(slider1) 
    //  ;
  }

  void draw() {
    background(0);
    fill(c);
    rect(ww, 0, w, 2);


    //if (keyT[97]) {
    //  y = 80;
    //  x=20;
    //  textAlign(LEFT);
    //  fill(c, 300);
    //  ///// NEXT VIZ IN....
    //  String sec = nf(int(vizTime - (millis()/1000 - time[0])) % 60, 2, 0);
    //  int min = int(vizTime - (millis()/1000 - time[0])) /60 % 60;
    //  text("next viz in: "+min+":"+sec, x, y);
    //  ///// NEXT COLOR CHANGE IN....
    //  sec = nf(int(colTime - (millis()/1000 - time[3])) %60, 2, 0);
    //  min = int(colTime - (millis()/1000 - time[3])) /60 %60;
    //  text("color change in: "+ min+":"+sec, x, y+20);
    //  text("c-" + co + "  " + "flash-" + co1, x, y+40);
    //  text("counter: " + counter, x, y+60);
    //}
  }
}

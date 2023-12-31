OPC opc;
OPC opcLocal;
OPC opcMirrors; 
OPC opcMirror1; 
OPC opcMirror2;
OPC opcSeeds;
OPC opcCans;
OPC opcStrip;
OPC opcControllerA;
OPC opcControllerB;
DMXGrid dmx;


final int PORTRAIT = 0;
final int LANDSCAPE = 1;
final int RIG = 0;
final int ROOF = 1;

SizeSettings size;
OPCGrid grid;
ControlFrame controlFrame;
Toggle toggle = new Toggle();

SketchColor rigColor, roofColor, cansColor;
ColorLayer rigLayer, roofLayer, cansLayer;
Buffer rigBuffer, roofBuffer, cansBuffer;

ArrayList <Anim> animations;

import javax.sound.midi.ShortMessage;       // shorthand names for each control on the TR8
import oscP5.*;
import netP5.*;
OscP5 oscP5[] = new OscP5[4];

import themidibus.*;  
MidiBus TR8bus;       // midibus for TR8
MidiBus faderBus;     // midibus for APC mini
MidiBus LPD8bus;      // midibus for LPD8

PFont myFont;
boolean onTop = false;
void settings() {
  size = new SizeSettings(LANDSCAPE);

  size(size.sizeX, size.sizeY, P2D);
  size.surfacePositionX = 1920-width-50;
  size.surfacePositionY = 150;
}
float dimmer = 1;
void setup()
{
  surface.setAlwaysOnTop(onTop);
  surface.setLocation(size.surfacePositionX, size.surfacePositionY);
  grid = new OPCGrid();
  dmx = new DMXGrid();

  ///////////////// LOCAL opc /////////////////////
  //opcMirrors = new OPC(this, "127.0.0.1", 7890);       // Connect to the local instance of fcserver - MIRRORS
  opcLocal = new OPC(this, "127.0.0.1", 7890);          // Connect to the remote instance of fcserver - CANS BOX
  //opcStrip = new OPC(this, "127.0.0.1", 7890);          // Connect to the remote instance of fcserver - CANS BOX

  ///////////////// OPC over NETWORK /////////////////////
  //opcMirrors = new OPC(this, "192.168.0.70", 7890);       // Connect to the remote instance of fcserver - MIRROR 1
  opcCans = new OPC(this, "192.168.0.10", 7890);          // Connect to the remote instance of fcserver - CANS BOX
  opcStrip = new OPC(this, "192.168.0.20", 7890);          // Connect to the remote instance of fcserver - CANS BOX

  //grid.mirrorsOPC(opcMirrors, opcMirrors, 0);               // grids 0-3 MIX IT UPPPPP 
  grid.kingsHeadCansOPC(opcCans);               
  grid.kingsHeadStripOPC(opcStrip);
  grid.kingsHeadBoothOPC(opcLocal);

  dmx.FMSmoke(opcLocal, width - 120, 115);

  audioSetup(100); ///// AUDIO SETUP - sensitivity /////
  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.
  println();
  TR8bus = new MidiBus(this, "TR-8S", "TR8-S"); // Create a new MidiBus using the device index to select the Midi input and output devices respectively.
  LPD8bus = new MidiBus(this, "LPD8", "LPD8"); // Create a new MidiBus using the device index to select the Midi input and output devices respectively.

  rigBuffer = new Buffer(size.rigWidth, size.rigHeight);
  roofBuffer = new Buffer(size.roofWidth, size.roofHeight);
  cansBuffer = new Buffer(size.cansWidth, size.cansHeight);

  drawingSetup();
  loadImages();
  loadGraphics();
  loadShaders();
  colorSetup();  
  rigColor = new SketchColor();
  roofColor = new SketchColor(); 
  cansColor = new SketchColor();

  rigViz = 2;
  roofViz = 1;
  rigBgr = 0;
  roofBgr = 4;

  rigColor.colorA = 9;
  rigColor.colorB = 6;
  roofColor.colorA = 3;
  roofColor.colorB = 4;
  cansColor.colorA = 7;
  cansColor.colorB = 11;
  //dimmer = 0.3;

  for (int i = 0; i < cc.length; i++) cc[i]=0;   // set all midi values to 0;
  for (int i = 0; i < 100; i++) cc[i] = 1;         // set all knobs to 1 ready for shit happen
  cc[1] = 0.75;
  cc[2] = 0.75;
  cc[5] = 0.3;
  cc[6] = 0.75;
  cc[4] = 0.05;
  cc[8] = 0.015;
  cc[MASTERFXON] = 0;

  vizHold=true;

  controlFrame = new ControlFrame(this, width, 130, "Controls"); // load control frame must come after shild ring etc
  animations = new ArrayList<Anim>();
  animations.add(new Anim(0, alphaSlider, funcSlider, rigDimmer));
  frameRate(30);
}
float vizTime, colTime;
int roofViz, rigViz, colStepper = 1;
int time_since_last_anim=0;
void draw()
{
  surface.setAlwaysOnTop(onTop);
  background(0);
  noStroke();
  beatDetect.detect(in.mix);
  beats();
  pause(10);                                ////// number of seconds before no music detected and auto kicks in
  globalFunctions();
  vizTime = 60*15*vizTimeSlider;
  if (frameCount > 10) playWithYourself(vizTime);
  rigColor.clash(beat);

  //////////// WHY DOESN't THIS WORK???? ?/////////////////////////////
  ///// ECHO RIG DIMMER SLIDER AND MIDI SLIDER 4 to control rig dimmer but only whne slider is changed
  //if (cc[4]!=prevcc[4]) {
  //  prevcc[4]=cc[4];
  //  if (cc[4] != rigDimmer) cp5.getController("rigDimmer").setValue(cc[4]);
  //}  

  //if (cc[8]!=prevcc[8]) {
  //   prevcc[8]=cc[8];
  //   if (cc[8] != roofDimmer) cp5.getController("roofDimmer").setValue(cc[8]);
  // }  

  rigDimmer = cc[4]; // come back to this with wigxxxflex code?!
  roofDimmer = cc[8]; // come back to this with wigflex code?!

  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  playWithMe();
  // create a new anim object and add it to the beginning of the arrayList
  if (beatTrigger) {
    if (rigToggle)    animations.add(new MirrorsAnim(rigViz, alphaSlider, funcSlider, rigDimmer));   
    if (cansToggle)   animations.add(new CansAnim(roofViz, cansAlpha, funcSlider, cansDimmer));              // create an anim object for the cans 
    if (roofToggle) {
      if (roofBasic) animations.add(new RoofAnim(10, alphaSlider, funcSlider, roofDimmer));            // create a new anim object for the roof
      else animations.add(new RoofAnim(roofViz, alphaSlider, funcSlider, roofDimmer));
    }
  }
  // limit the number of animations
  while (animations.size()>0 && animations.get(0).deleteme) animations.remove(0);
  if (animations.size() >= 28) animations.remove(0);  
  // adjust animations
  //if (keyT['a']) 

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////
  for (Anim anim : animations)  anim.alphFX *=rigDimmer;
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////

  if (keyT['s']) for (Anim anim : animations)  anim.funcFX = 1-(stutter*noize1*0.1);
  //draw animations
  blendMode(LIGHTEST);
  for (int i = animations.size()-1; i >=0; i--) {                                  // loop  through the list
    Anim anim = animations.get(i);  
    anim.drawAnim();           // draw the animation
  }
  ////////////////////// draw colour layer /////////////////////////////////////////////////////////////////////////////////////////////////////
  blendMode(MULTIPLY);
  rigLayer = new ColorLayer(rigBgr);
  roofLayer = new RoofColorLayer(roofBgr);
  cansLayer = new CansColorLayer(roofBgr);
  // this donesnt work anymore....
  //if (cc[106] > 0 || keyT['r'] || glitchToggle) bgNoise(rigBuffer.colorLayer, 0, 0, cc[6]); //PGraphics layer,color,alpha
  ////
  rigLayer.drawColorLayer();
  roofLayer.drawColorLayer();
  cansLayer.drawColorLayer();
  blendMode(NORMAL);
  //////////////////////////////////////////// PLAY WITH ME MORE /////////////////////////////////////////////////////////////////////////////////
  playWithMeMore();
  //////////////////////////////////////////// BOOTH & DIG ///////////////////////////////////////////////////////////////////////////////////////
  boothLights();
  ////////////////////////////////////// MONKY WITH AN AK //////////////////////////////////

  fill(0, 360-(360*cansDimmer));
  rect(600, 450, 320, 10);
  if (beatCounter %64 < 4) fill(rigColor.clash, 200*stutter*roofDimmer);
  rect(600, 450, 320, 10);


  //////////////////////////////////////////// DISPLAY ///////////////////////////////////////////////////////////////////////////////////////////
  workLights(keyT['w']);
  testColors(keyT['t']);
  onScreenInfo();                   // display info about current settings, viz, funcs, alphs etc
  //gid.mirrorTest(false);          // true to test physical mirror orientation
} 
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////// THE END //////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

OPC opc;
OPC opcESP;
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
OPCGrid opcGrid;
ControlFrame controlFrame;

Rig rigg, roof, cans, mirrors, strips;
//Grids rigGrid, roofGrid, cansGrid;
SketchColor rigColor, roofColor, cansColor;
ColorLayer rigLayer, roofLayer, cansLayer;

ArrayList <Anim> animations;

import javax.sound.midi.ShortMessage;       // shorthand names for each control on the TR8
import oscP5.*;
import netP5.*;
OscP5 oscP5[] = new OscP5[4];

import themidibus.*;  
MidiBus TR8bus;           // midibus for TR8
MidiBus faderBus;         // midibus for APC mini
MidiBus LPD8bus;          // midibus for LPD8
MidiBus beatStepBus;      // midibus for Artuia BeatStep

PFont myFont;
boolean onTop = false;
void settings() {
  size = new SizeSettings(LANDSCAPE);
  size(size.sizeX, size.sizeY, P2D);
  size.surfacePositionX = 1920-width-50;
  size.surfacePositionY = 150;
}
void setup()
{
  surface.setAlwaysOnTop(onTop);
  surface.setLocation(size.surfacePositionX, size.surfacePositionY);

  opcGrid = new OPCGrid();
  dmx = new DMXGrid();

  rigg = new Rig(size.rig.x, size.rig.y, size.rigWidth, size.rigHeight, rigg);
  roof = new Rig(size.roof.x, size.roof.y, size.roofWidth, size.roofHeight, roof);
  cans = new Rig(size.cans.x, size.cans.y, size.cansWidth, size.cansHeight, cans);
  println();

  ///////////////// LOCAL opc /////////////////////
  opcLocal   = new OPC(this, "127.0.0.1", 7890);       // Connect to the local instance of fcserver - MIRRORS

  ///////////////// OPC over NETWORK /////////////////////
  opcMirrors = new OPC(this, "192.168.0.70", 7890);        // Connect to the remote instance of fcserver - MIRROR 1
  opcCans    = new OPC(this, "192.168.0.10", 7890);           // Connect to the remote instance of fcserver - CANS BOX
  opcStrip   = new OPC(this, "192.168.0.20", 7890);          // Connect to the remote instance of fcserver - CANS BOX
  opcESP     = new OPC(this, "############", 7890);          // Connect to the remote instance of fcserver - CANS BOX

  opcGrid.mirrorsOPC(opcLocal, opcLocal, 0);               // grids 0-3 MIX IT UPPPPP 
  //opcGrid.pickleCansOPC(cans, opcLocal);               
  opcGrid.kingsHeadStripOPC(cans, opcLocal);
  //grid.kingsHeadBoothOPC(opcLocal);
  opcGrid.individualCansOPC(roof, opcLocal);

  dmx.FMSmoke(opcLocal, width - 120, 115);

  audioSetup(100); ///// AUDIO SETUP - sensitivity /////
  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.
  println();
  TR8bus = new MidiBus(this, "TR-8S", "TR8-S"); // Create a new MidiBus using the device index to select the Midi input and output devices respectively.
  LPD8bus = new MidiBus(this, "LPD8", "LPD8"); // Create a new MidiBus using the device index to select the Midi input and output devices respectively.
  beatStepBus = new MidiBus(this, "Arturia BeatStep", "Arturia BeatStep"); // Create a new MidiBus using the device index to select the Midi input and output devices respectively.

  drawingSetup();
  loadImages();
  loadGraphics();
  loadShaders();
  colorSetup();  
  rigColor = new SketchColor(rigg);
  roofColor = new SketchColor(roof); 
  cansColor = new SketchColor(cans);

  rigg.vizIndex = 2;
  roof.vizIndex = 1;
  rigg.bgIndex = 0;
  roof.bgIndex = 4;

  rigg.colorIndexA = 0;
  rigg.colorIndexB = 14;
  roof.colorIndexA = 3;
  roof.colorIndexB = 4;
  cans.colorIndexA = 7;
  cans.colorIndexB = 11;

  for (int i = 0; i < cc.length; i++) cc[i]=0;   // set all midi values to 0;
  for (int i = 0; i < 100; i++) cc[i] = 1;         // set all knobs to 1 ready for shit happen
  cc[1] = 0.75;
  cc[2] = 0.75;
  cc[5] = 0.3;
  cc[6] = 0.75;
  cc[4] = 1;
  cc[8] = 1;
  cc[MASTERFXON] = 0;

  controlFrame = new ControlFrame(this, width, 130, "Controls"); // load control frame must come after shild ring etc
  animations = new ArrayList<Anim>(); 
  frameRate(30);
}
float vizTime, colTime;
int colStepper = 1;
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

  // dimmer knobs are ehcoed by on screen sliders - code in controller tab
  /// DIMMING CONTROL STILL NOT QUITE AS EXPECTED 
  rigg.dimmer = rigDimmer;     // cc[4]
  roof.dimmer = roofDimmer;    // cc[8]
  cans.dimmer = cansDimmer;    // cc[5]

  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  playWithMe();
  // create a new anim object and add it to the beginning of the arrayList
  if (beatTrigger) {
    if (rigToggle)    animations.add(new Anim(rigg.vizIndex, alphaSlider, funcSlider, rigg));   
    if (cansToggle)   animations.add(new Anim(10, cansAlpha, funcSlider, cans));              // create an anim object for the cans 
    if (roofToggle) {
      if (roofBasic) animations.add(new Anim(10, alphaSlider, funcSlider, roof));            // create a new anim object for the roof
      else animations.add(new Anim(roof.vizIndex, alphaSlider, funcSlider, roof));
    }
  }
  // limit the number of animations
  while (animations.size()>0 && animations.get(0).deleteme) animations.remove(0);
  if (animations.size() >= 28) animations.remove(0);  
  // adjust animations
  //if (keyT['a']) 

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
  rigLayer = new ColorLayer(rigg);
  roofLayer = new ColorLayer(roof);
  cansLayer = new ColorLayer(cans);
  // this donesnt work anymore....
  if (cc[107] > 0 || keyT['r'] || glitchToggle) bgNoise(rigg.colorLayer, 0, 0, cc[7]); //PGraphics layer,color,alpha
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

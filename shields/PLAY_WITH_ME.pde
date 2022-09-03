float[] lastTime = new float[cc.length];

void playWithMe() {

if (rigg != null){
  ////////////////////////////////////// COLOR SWAP AND FLIP BUTTONS /////////////////////////////////////////
  if (keyP['o']) rigg.colorSwap(0.9999999999);               // COLOR SWAP MOMENTARY 
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////
  if (keyT['i']) rigg.colorFlip(keyT['i']);                  // COLOR FLIP TOGGLE 
  if (keyP['u']) rigg.colorFlip(keyP['u']);                  // COLOR FLIP MOMENTARY
}
  ////////////////////////////// LERP COLOUR ON BEAT /////////////////////////////////////////////////////////
  //if (keyT['y']) {
  //  colorLerping(shields, (1-beat)*2);
  //  colorLerping(roof, (1-beat)*1.5);
  //}

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


  float  debouncetime=100;
  ///////////////////////////// *** MANUAL ANIM WORK THAT DOESNT WORK **** ////////////////////////////
  /*
  try {
   if (millis()-lastTime[44]>debouncetime) {
   if (padVelocity[44]>0) rigg.animations.add(new Checkers (shields));
   if (rigg.animations.size() > 0 ) { 
   Anim theanim = rigg.animations.get(rigg.animations.size()-1);
   //Envelope manualA = CrushPulse(0.0, 0, 1, rigg.manualAlpha*500, 0.0, 0.0);
   Envelope manualA = CrushPulse(0.05, 0.0, 1.0, avgmillis*(rigg.manualAlpha+0.5), 0.0, 0.0);
   theanim.alphaEnvelopeA = manualA;
   theanim.alphaEnvelopeB = manualA;
   lastTime[44]=millis();
   }
   }
   } 
   catch (Exception e) {
   println(e, "playwithyourself error");
   }
   */

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////// ADD ANIM ////////////////////////////////////////////////////////////////////
  if (millis()-lastTime[0]>debouncetime*2.5) {
    if (keyP[' ']) {
      for (Rig rig : rigs) {
        if (rig.toggle) {
          rig.addAnim(rig.vizIndex);
        }
      }
      lastTime[0]=millis();
    }
  }
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////

  int ccc = 101;
  if (millis()-lastTime[ccc]>debouncetime) {
    if (padVelocity[ccc]>0) rigg.animations.add(new StarMesh (rigg));
    lastTime[ccc]=millis();
  }

  //if (millis()-lastTime[45]>debouncetime) {
  //  if (padVelocity[45]>0) rigg.animations.add(new SpiralFlower(shields));
  //  lastTime[45]=millis();
  //}
  ccc= 102;
    if (millis()-lastTime[ccc]>debouncetime) {
    if (padVelocity[ccc]>0) rigg.animations.add(new Stars(rigg));
    lastTime[ccc]=millis();
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////// ALL ON ///////////////////////////////////////////////

  if (millis()-lastTime[46]>debouncetime) {
    if (padVelocity[46]>0) {
      rigg.animations.add( new AllOn(rigg)); //rigg.anim.alphaEnvelopeA = new CrushPulse(0.031, 0.040, 0.913, avgmillis*rigg.alphaRate*3+0.5, 0.0, 0.0);
      //anim = rigg.animations.get(rigg.animations.size()-1);
      lastTime[46]=millis();
    }
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////// KILL ALL ANIMS - BLACKOUT ///////////////////////////////////////////////

  ///// DEBOUNCE?! /////

  if (millis()-lastTime[47]>debouncetime) {
    if (padVelocity[47]>0) for (Anim anim : rigg.animations) anim.deleteme = true;  // immediately delete all anims
    lastTime[47]=millis();
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////// STUTTER ///////////////////////////////////////////////x

  /// doesnt work as expected ///

  if (millis()-lastTime[48]>debouncetime) {
    if (padVelocity[48]>0) for (Anim anim : rigg.animations) {
      anim.alphaEnvelopeA = anim.alphaEnvelopeA.mul((1-cc[45])+(stutter*cc[45])); // anim.alphaEnvelopeA.mul(0.6+(stutter*0.4));     //anim.alphaEnvelopeA.mul((1-cc[46])+(stutter*cc[46]));
      anim.alphaEnvelopeB = anim.alphaEnvelopeB.mul((1-cc[45])+(stutter*cc[45])); //anim.alphaEnvelopeA.mul(0.6+(stutter*0.4)); //anim.alphaEnvelopeB.mul((1-cc[46])+(stutter*cc[46]));
    }
    lastTime[48]=millis();
  }
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////  COLOUR //////////////////////////////////////////////////////////////////////////////

  if (padVelocity[49] > 0) rigg.colorFlip(true);
  if (padVelocity[50] > 0) rigg.colorSwap(0.9999999999);



  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  //if (millis()-lastTime[36]>debouncetime) {
  // if (padVelocity[36]>0) rigg.animations.add(new StarMesh (roof));
  // lastTime[36]=millis();
  // }

  // if (millis()-lastTime[37]>debouncetime) {
  // if (padVelocity[37]>0) rigg.animations.add(new SingleDonut(roof));
  // lastTime[37]=millis();
  // }

  // if (millis()-lastTime[38]>debouncetime) {
  // if (padVelocity[38]>0) rigg.animations.add(new BenjaminsBoxes(roof));
  // lastTime[38]=millis();
  // }
  /*
  if (millis()-lastTime[39]>debouncetime) {
   if (padVelocity[39]>0) roof.animations.add( new AllOn(roof));
   lastTime[39]=millis();
   }
   */
  /*
  if (millis()-lastTime[40]>debouncetime) {
   if (padVelocity[40]>0) for (Anim anim : roof.animations) anim.deleteme = true;  // immediately delete all anims
   lastTime[40]=millis();
   }
   */
  /*
   if (millis()-lastTime[41]>debouncetime) {
   if (padVelocity[41]>0) for (Anim anim : rigg.animations) {
   anim.functionEnvelopeA = anim.functionEnvelopeA.mul(0.6+(stutter*0.4));  //     anim.functionEnvelopeA.mul((1-cc[54])+(stutter*cc[54]));
   anim.functionEnvelopeB = anim.functionEnvelopeB.mul(0.6+(stutter*0.4));    //anim.functionEnvelopeB.mul((1-cc[54])+(stutter*cc[54]));
   }
   lastTime[41]=millis();
   }
   */
  //  if (padVelocity[36] > 0) {
  //    rigg.colorIndexA = (rigg.colorIndexA+1)%rigg.col.length;      //// CYCLE FORWARD THROUGH ROOF COLORS
  //    cans.colorIndexA = (cans.colorIndexA+1)%cans.col.length;      //// CYCLE FORWARD THROUGH ROOF COLORS
  //  }
  //  if (padVelocity[37] > 0) {
  //    rigg.colorIndexB = (rigg.colorIndexB+1)%rigg.col.length;      //// CYCLE FORWARD THROUGH ROOF COLORS
  //    cans.colorIndexB = (cans.colorIndexB+1)%cans.col.length;      //// CYCLE FORWARD THROUGH ROOF COLORS
  //  }
  //if (padVelocity[51] > 0) roof.colorSwap(0.9999999999);
  //if (padVelocity[43] > 0) pars.colorSwap(0.9999999999);                // COLOR SWAP MOMENTARY



  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////// PLAY WITH DRAWING FUNCTIONS ////////////////////////////////////////////////////////////// 
void playWithMeMore() {

  /////////////////////////////////////////////////////// 

  /////background noise over whole window/////
  if (padVelocity[51] > 0) {
    rigg.colorLayer.beginDraw();
    rigg.colorLayer.background(0, 0, 0, 0);
    rigg.colorLayer.endDraw();
    bgNoise(rigg.colorLayer, rigg.flash, map(padVelocity[51], 0, 1, 0, rigg.dimmer/1.5), cc[48]);   //PGraphics layer,color,alpha
    image(rigg.colorLayer, rigg.size.x, rigg.size.y, rigg.wide, rigg.high);
  }
  if (padVelocity[43] > 0) {
    roof.colorLayer.beginDraw();
    roof.colorLayer.background(0, 0, 0, 0);
    roof.colorLayer.endDraw();
    bgNoise(roof.colorLayer, roof.flash, map(padVelocity[43], 0, 1, 0, roof.dimmer), cc[56]);   //PGraphics layer,color,alpha
    image(roof.colorLayer, roof.size.x, roof.size.y, roof.wide, roof.high);
  }
  /*
  if (padVelocity[50] > 0) {
   pars.colorLayer.beginDraw();
   pars.colorLayer.background(0, 0, 0, 0);
   pars.colorLayer.endDraw();
   //void bgNoise(PGraphics layer, color _col, float bright, float fizzyness) {
   
   bgNoise(pars.colorLayer, pars.flash, map(padVelocity[50], 0, 1, 0, pars.dimmer), cc[47]);   //PGraphics layer,color,alpha
   image(pars.colorLayer, pars.size.x, pars.size.y, pars.wide, pars.high);
   }
   */
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void cansControl(color col, float alpha) {
  fill(col, 360*alpha);
  rect(opcGrid.cans[0].x, opcGrid.cans[0].y, opcGrid.cansLength, 3);
  rect(opcGrid.cans[1].x, opcGrid.cans[1].y, opcGrid.cansLength, 3);
}






int counter, alphIndex, alph1Index = 1, fctIndex, fct1Index = 1, swap;
int roofAlphIndex, roofAlph1Index = 1, roofFctIndex, roofFct1Index = 1;

float alf, bt, bt1, dimmer, func, func1;
float roofBt, roofBt1, roofFunc, roofFunc1;
color col1, col2;

float alpha[] = new float[4];
float alpha1[] = new float[4];
float roofAlpha[] = new float[4];
float roofAlpha1[] = new float[4];

float function[] = new float[4];
float function1[] = new float[4];
float roofFunction[] = new float[4];
float roofFunction1[] = new float[4];

void playWithYourself(float vizTm) {

  ///////////////// VIZ TIMER ////////////////////////////////////////
  if (millis()/1000 - time[0] >= vizTm) {
    counter = (counter + 1) % 3;
    if (counter == 0) {
      rigViz = int(random(11));
      roofViz = int(random(8));
      alf = 0;                       ////// set new viz to 0 to fade up viz /////
    }
    if (counter > 0 ) {
      rigViz = int(random(11));
      roofViz = int(random(8));
      alf = 0;                       ////// set new viz to 0 to fade up viz /////
    }
    println("RIG VIZ:", rigViz, "COUNTER:", counter, "@", (hour()+":"+minute()+":"+second()));
    time[0] = millis()/1000;
  }
  float divide = 4; ///////// NUMBER OF TIMES ALPHA CHANGES PER VIZ
  ///////////// ALPHA TIMER ///////////////////////////////////////////////////////////
  if (millis()/1000 - time[1] >= vizTm/divide) { ///// alpha timer changes 4 times every viz change /////
    alphIndex = int(random(alph.length));  //// select from alpha array
    alph1Index = int(random(alph.length)); //// select from alpha array
    roofAlphIndex = int(random(roofAlph.length));  //// select from alpha array
    roofAlph1Index = int(random(roofAlph.length)); //// select from alpha array
    alf = 0; ////// set  viz to 0 to fade up viz when alpha changes /////
    println("alpha change @", (hour()+":"+minute()+":"+second()), "new af:", alphIndex, "new af1:", alph1Index);
    time[1] = millis()/1000;
  }
  divide = 6; //////////////// NUMBER OF TIMES FUNCTION CHANGES PER VIZ
  //////////// FUNCTION TIMER ////////////////////////////////////////////////////////
  if (millis()/1000 - time[2] >= vizTm/divide) {    ////// change function n times for every state change
    fctIndex = int(random(fct.length));  //// select from function array
    fct1Index = int(random(fct.length));  //// select from function array
    roofFctIndex = int(random(roofFct.length));  //// select from function array
    roofFct1Index = int(random(roofFct.length));  //// select from function array
    alf = 0; ////// set  viz to 0 to fade up viz when fucntion changes /////
    println("function change @", (hour()+":"+minute()+":"+second()), "new function:", fctIndex, "new function1:", fct1Index);
    time[2] = millis()/1000;
  }
  ////////////////////////////////// FADE UP NEXT VIZ ///////////////////////////////////////////////////////////////
  if (alf < 1) alf += 0.05;
  if (alf > 1) alf = 1;
  //////////////////////////////////////////////////// END OF PLAY WITH YOURSELF AUTO CONTROL //////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  ///////////////////////////////////////// SET FUNCTIONS AND ALPHAS TO USE THROUGHT SKETCH ////////////////
  for (int i =0; i< beats.length; i++) {
    /////////////////////////////////////// SHIMMER control for rig ////////////////////////////
    if (beatCounter % 36 > 24) { 
      alpha[i] = alph[alphIndex][i]+(shimmerSlider/2+(stutter*0.4*noize1*0.2));
      alpha1[i] = alph[alph1Index][i]+(shimmerSlider/2+(stutter*0.4*noize1*0.2));

      if (beatCounter%4 == i) {
        bt = alph[alphIndex][i]+(shimmerSlider/2+(stutter*0.4*noize1*0.2));
        bt1 = alph[alph1Index][i]+(shimmerSlider/2+(stutter*0.4*noize1*0.2));
      }
    } else {
      alpha[i] = alph[alphIndex][i]/1;    //*(0.6+0.4*noize12)/1.5;  //// set alpha to selected alpha with bit of variation
      alpha1[i] = alph[alph1Index][i]/1;   //*(0.6+0.4*noize1)/1.5;  //// set alpha1 to selected alpha with bit of variation
      if (beatCounter%4 == i) {
        bt = alph[alphIndex][i];
        bt1 = alph[alph1Index][i];
      }
      //////////////// bright flash every 6 beats - counters all code above /////////
      if (beatCounter%6 == 0) {
        alpha[i]  = alph[alphIndex][i];
        alpha1[i]  = alph[alph1Index][i];
      }
    }

    ////////////////// shimmer control for roof ////////////////////////////
    if (beatCounter % 96 < 64) { 
      roofAlpha[i] = roofAlph[roofAlphIndex][i]+(shimmerSlider/2+(stutter*0.4*noize1*0.2));
      roofAlpha1[i] = roofAlph[roofAlph1Index][i]+(shimmerSlider/2+(stutter*0.4*noize1*0.2));
      if (beatCounter%4 == i) {
        roofBt = roofAlph[roofAlphIndex][i]+(shimmerSlider/2+(stutter*0.4*noize1*0.2));
        roofBt1 = roofAlph[roofAlph1Index][i]+(shimmerSlider/2+(stutter*0.4*noize1*0.2));
      }
    } else {
      roofAlpha[i] = roofAlph[roofAlphIndex][i]/1;
      roofAlpha1[i] = roofAlph[roofAlph1Index][i]/1;
      if (beatCounter%4 == i) {
        roofBt = roofAlph[roofAlphIndex][i];
        roofBt1 = roofAlph[roofAlph1Index][i];
      }
      //////////////// bright flash every 12 beats - counters all code above /////////
      if (beatCounter%12 == 12) {
        roofAlpha[i]  = roofAlph[roofAlphIndex][i];
        roofAlpha1[i]  = roofAlph[roofAlph1Index][i];
      }
    }
  }
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////
  for (int i =0; i< beats.length; i++) {
    function[i] = fct[fctIndex][i];                    /// set func to selected function
    function1[i] = fct[fct1Index][i];                  /// set func1 to selected function
    //roof
    roofFunction[i] = roofFct[roofFctIndex][i];                    /// set func to selected function
    roofFunction1[i] = roofFct[roofFct1Index][i];                  /// set func1 to selected function
    if (beatCounter%4 == i) {
      func = fct[fctIndex][i];
      func1 = fct[fct1Index][i];
      // roof
      roofFunc = roofFct[roofFctIndex][i];
      roofFunc1 = roofFct[roofFct1Index][i];
    }
  }
  /////////////////////////////////////// COLORSWAP TIMER ///////////////////////////////////
  if (colorSwapSlider > 0)  colorSwap(colorSwapSlider*10000000*oskP);         //// spped of  colour swap; c/flash
  if (beatCounter%64<8) colorSwap(1000000*noize);   
  if (colorSwapSlider == 0) colorSwap(0);

  ////////////////////////////////////////// HOLD BUTTONS FOR VIZ AND COLOUR ///////////////////////////
  if (hold)  time[0] = millis()/1000;  //// hold viz change timer
  if (hold1) time[3] = millis()/1000;  //// hold color change timer

  ////////////////////////////////////// COLOR SWAP AND FLIP BUTTONS //////////////////////////////////////
  colorFlip(colFlip);                      // COLOR FLIP on ';' key (toggle)
  if (keyP[92])  colorSwap(0.9999999999); /// COLOR SWAP on '\'  key
  if (keyP[39])  colorFlip(keyP[39]);      // COLOR SWAP ON '"' key (press and hold)

  ///////////////////////////////////////  COLOR FLIP ON BEAT ///////////////////////////////////
  for (int i=0; i<13; i+=2) if (beatCounter%32 == i) colorFlip(true);

  ////////////////////////////// LERP COLOUR ON BEAT /////////////////////////////
  if (keyT[111]) {
    c = lerpColor(col[co1], col[co], beatFast);
    flash = lerpColor(col[co], col[co1], beatFast);
  }
  if (beatCounter % 18 > 13) {
    c = lerpColor(col[co1], col[co], beatFast);
    flash = lerpColor(col[co], col[co1], beatFast);
  }

  /////////////////////////// TOGGLE MODIFIERS ///////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////////
  /////////////// *** key X toggles different beat pattern 
  //if (keyT[120]) {
  //  steps = 4;
  //  if (beatCounter%steps==0) bt = beats[0];
  //  if (beatCounter%steps==1) bt = pulz;
  //  if (beatCounter%steps==2) bt = beats[2];
  //  if (beatCounter%steps==3) bt = beats[2];

  //  if (beatCounter%steps==0) bt1 = pulz;
  //  if (beatCounter%steps==1) bt1 = beat;
  //  if (beatCounter%steps==2) bt1 = pulzSlow;
  //  if (beatCounter%steps==3) bt1 = beat;
  //}
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
}
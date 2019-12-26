/* KEY FUNCTIONS
 
 'c' toggles on/off the info
 'b' steps the animations backwards 
 'n' steps the animations forward
 'm' changes the backgrounds
 ',' changes the function
 '.' changes the alpha
 '/' changes the colours
 'l' toggle colour change on beat
 ';' toggle swaps color c/flash
 ''' swaps color c/flash - press and hold
 '\' color swap
 '[' viz hold - stops the timer counting down for next viz change
 ']' color hold - stops the timer counting down for next colour change
 'q' toggles mouse coordiantes and moveable dot
 't' toggle TEST - cycles though all colours to test LEDs
 'w' toggle WORK LIGHTS - all WHITE 
 'a' toggle colorSteps - changes colour in pairs or not
 
 */
void frameRateInfo(float x, float y) {
  textAlign(LEFT);
  textSize(18);
  fill(360);  
  text(int(frameRate) + " fps", x, y); // framerate display
  //frame.setTitle(int(frameRate) + " fps"); //framerate as title
}

void onScreenInfo() {
  toggleInfo(width/2+90, 20);
  fill(300+(60*stutter));
  textAlign(RIGHT);
  text("RIG PANEL", size.rigWidth-5, size.rig.y-(size.rigHeight/2)+20);
  text("ROOF PANEL", size.rigWidth+size.roofWidth-5, size.roof.y-(size.roofHeight/2)+20);

  textAlign(LEFT);
  textSize(18);
  fill(360);
  float x = 10;
  float y = 20;

  /////// SHOW INFO ABOUT CURRENT ARRAY SELECTION ////
  fill(flash, 300);
  textSize(18);
  y = height-size.sliderHeight+20;
  ///////////// rig info
  text("rigViz: " + rigViz, x, y);
  text("bkgrnd: " + rigBgr, x, y+20);
  text("func's: " + fctIndex + " / " + fct1Index, x+100, y);
  text("alph's: " + alphIndex + " / " + alph1Index, x+100, y+20);
  //////////// roof info
  x = x+size.roof.x-(size.roofWidth/2);
  text("roofViz: " + roofViz, x, y);
  text("bkgrnd: " + roofBgr, x, y+20);
  text("func's: " + roofFctIndex + " / " + roofFct1Index, x+100, y);
  text("alph's: " + roofAlphIndex + " / " + roofAlph1Index, x+100, y+20);

  /////////// info about PLAYWITHYOURSELF functions
  y = 20;
  x=width-5;
  textAlign(RIGHT);
  fill(c, 300);
  ///// NEXT VIZ IN....
  String sec = nf(int(vizTime - (millis()/1000 - time[0])) % 60, 2, 0);
  int min = int(vizTime - (millis()/1000 - time[0])) /60 % 60;
  text("next viz in: "+min+":"+sec, x, y);
  ///// NEXT COLOR CHANGE IN....
  sec = nf(int(colTime - (millis()/1000 - time[3])) %60, 2, 0);
  min = int(colTime - (millis()/1000 - time[3])) /60 %60;
  text("next color in: "+ min+":"+sec, x, y+20);
  text("c-" + co + "  " + "flash-" + co1, x, y+40);
  text("counter: " + counter, x, y+60);

  ////////////// booth lights info
  textSize(12);
  textAlign(CENTER);
  text("BOOTH", booth.bth.x+10, booth.bth.y-10);
  fill(flash);
  text("DIG", booth.dig.x+10, booth.dig.y+20);

  if (info) {
    /////  LABLELS to show what PVectors are what 
    textSize(12);
    textAlign(CENTER);
    for (int i = 0; i < grid.shield.length; i++) text(i, grid.shield[i][0].x, grid.shield[i][0].y+4);    /// SHIELD POSTION INFO
    fill(c);
    for (int i = 0; i < grid._shield.length; i++) text("/ "+i, grid._shield[i][0].x+15, grid._shield[i][0].y+4);    /// SHIELD POSTION INFO
  }

  // moving rectangle displays alpha and functions
  textSize(12);
  textAlign(CENTER);
  fill(flash);
  text("FUNCTION", (size.rigWidth-50)/2, height-10);
  rect((size.rigWidth-50)*func, height-15, 10, 10); // moving rectangle to show current function
  fill(c, 360);
  text("ALPHA", (size.rigWidth-50)/2, height);
  rect((size.rigWidth-50)*bt, height-5, 10, 10); // moving rectangle to show current alpha

  // sequencer
  fill(flash);
  int dist = 20;
  y = 80;
  for (int i = 0; i<(size.infoHeight-size.sliderHeight)/dist-(y/dist); i++) if (int(beatCounter%(dist-(y/dist))) == i) rect(size.info.x-(size.infoWidth/2)+10, 10+i*dist+y, 10, 10);
  fill(c, 100);
  for (int i = 0; i<(size.infoHeight-size.sliderHeight)/dist-(y/dist); i++) rect(size.info.x-(size.infoWidth/2)+10, 10+i*dist+y, 10, 10);

  // beats[] visulization
  y=10;
  dist = 15;
  for (int i = 0; i<beats.length; i++) {
    if (beatCounter % 4 == i) fill(flash1, 360);
    else fill(c1, 100);
    rect((size.info.x-(size.infoWidth/2)+10)+(beats[i]*100), y+(dist*i), 10, 10);
    fill(c1, 65);
    rect((size.info.x-(size.infoWidth/2)+10)+(50), y+(dist*i), 110, 10);
  }

  // text to show no audio
  if (pause >0) { 
    textAlign(RIGHT);
    textSize(20); 
    fill(300);
    text("NO AUDIO!!", width-5, height-2);
  }

  if (info) {
    /////// DISPLAY MOUSE COORDINATES
    textAlign(LEFT);
    fill(c);  
    ellipse(mouseX, mouseY+10, 15, 15);
    textSize(14);
    text( " x" + mouseX + " y" + mouseY, mouseX, mouseY );
  }
}

void colorInfo() {
  ///// RECTANGLES TO SHOW BEAT DETECTION AND CURRENT COLOURS /////
  int y = height-5;

  fill(col[co1]);          
  rect(size.rigWidth-20, y, 10, 10);        // rect to show CURRENT color FLASH 
  fill(col[(co1+1)%col.length]);
  rect(size.rigWidth-7.5, y, 10, 10);       // rect to show NEXT color FLASH1
  fill(col[co]);
  rect(size.rigWidth-20, y-10, 10, 10);     // rect to show CURRENT color C 
  fill(col[(co+1)%col.length]);
  rect(size.rigWidth-7.5, y-10, 10, 10);    // rect to show NEXT color C 
  fill(360, beat*360); 
  rect(size.rigWidth-32.5, y, 10, 10);      // rect to show B alpha
  fill(360, bt*360); 
  rect(size.rigWidth-32.5, y-10, 10, 10);   // rect to show CURRENT alpha
}

void toggleInfo(float xpos, float ypos) {
  textSize(18);
  textAlign(CENTER);
  float x = 20;
  float y = 0;

  //if (shift)   text("SHIFT!!", xpos+(x*6), ypos+(y*1));
  textAlign(RIGHT);
  y = 180;
  x = width-5;
  fill(50);
  if (hold)  fill(300+(60*stutter));
  text("[ = VIZ HOLD", x, y);
  fill(50);
  if (hold1) fill(300+(60*stutter));
  text("] = COL HOLD", x, y+20);
  y +=20;
  fill(50);
  if (keyT[107]) fill(300+(60*stutter));
  text("K = shimmer", x, y+40);
  fill(50);
  if (!colSwap) fill(300+(60*stutter));
  text("| = color swap", x, y+60);
  fill(50);
  if (colorFlipped) fill(300+(60*stutter));
  text("; / ' = color flip", x, y+80);
  fill(50);
  if (colBeat) fill(300+(60*stutter));
  text("L = color beat", x, y+100);
  y+=20;
  fill(50);
  if (keyT[120]) fill(300+(60*stutter));
  text("X = B/P/B2/B2", x, y+120);
  fill(50);
  if (keyT[122]) fill(300+(60*stutter));
  text("Z = viz flip", x, y+140);
}
//////////////////////////////////////////////////// COLOR TIMER ////////////////////////////////
color c, flash, c1, flash1, co, co1 = 1, co2, co3, colA, colB, colC, colD;
float go;
boolean change;
void colorTimer(float colTime, int steps) {
  if (change == false) {
    colA = c;
    colC = flash;
  }

  if (millis()/1000 - time[3] >= colTime) {
    change = true;
    println("COLOR CHANGE @", (hour()+":"+minute()+":"+second()));
    time[3] = millis()/1000;
  } else change = false;
  if (change == true) {
    go = 1;
    co =  (co + steps) % (col.length-1);
    colB =  col[co];
    co1 = (co1 + steps) % (col.length-1);
    colD = col[co1];
    co2 = (co2 + steps) % (col.length-1);
    co3 = (co3 + steps) % (col.length-1);
  }

  c = col[co];
  c1 = col[co];
  flash = col[co1];
  flash1 = col[co1];

  if (go > 0.1) change = true;
  else change = false;
  if (change == true) {
    c = lerpColorHSB(colB, colA, go);
    flash = lerpColorHSB(colD, colC, go);
  }

  go *= 0.97;
  if (go < 0.01) go = 0.001;
}
////////////////////////////////////////////////////// HSB LERP COLOR FUNCTION //////////////////////////////
// linear interpolate two colors in HSB space 
color lerpColorHSB(color c1, color c2, float amt) {
  amt = min(max(0.0, amt), 1.0);
  float h1 = hue(c1), s1 = saturation(c1), b1 = brightness(c1);
  float h2 = hue(c2), s2 = saturation(c2), b2 = brightness(c2);
  // figure out shortest direction around hue
  float z = g.colorModeZ;
  float dh12 = (h1>=h2) ? h1-h2 : z-h2+h1;
  float dh21 = (h2>=h1) ? h2-h1 : z-h1+h2;
  float h = (dh21 < dh12) ? h1 + dh21 * amt : h1 - dh12 * amt;
  if (h < 0.0) h += z;
  else if (h > z) h -= z;
  colorMode(HSB);
  return color(h, lerp(s1, s2, amt), lerp(b1, b2, amt));
}
////////////////////////////// COLOR SWAP //////////////////////////////////
boolean colSwap;
void colorSwap(float spd) {
  int t = int(millis()/70*spd % 2);
  int colA = c;
  int colB = flash;
  if ( t == 0) {
    colSwap = true;
    c = colB;
    flash = colA;
  } else colSwap = false;
} 
////////////////////////////// COLOR FLIP //////////////////////////////////
boolean colFlip;
boolean colorFlipped;
void colorFlip(boolean toggle) {
  int colA = c;
  int colB = flash;
  if (toggle) {
    colorFlipped = true;
    c = colB;
    flash = colA;
  } else colorFlipped = false;
}


///////////////////////////////////////// CLASH COLOR SETUP /////////////////////////////////
color clash, clash1, clash2, clash12, clashed;
void clash(float func) { 
  color flashHalf = lerpColor(c, flash, 0.75);
  color cHalf = lerpColor(c, flash, 0.25); 

  clash = lerpColorHSB(cHalf, flashHalf, func);     ///// MOVING, HALF RNAGE BETWEEN C and FLASH
  clash1 = lerpColorHSB(cHalf, flashHalf, 1-func);            ///// MOVING, HALF RANGE BETWEEN FLASH and C
  clash2 = lerpColorHSB(flash, c, func);          ///// MOVING, FULL RANGE BETWEEN C and FLASH
  clash12 = lerpColorHSB(flash, c, 1-func);          ///// MOVING, FULL RANGE BETWEEN FLASH and C
  clashed = lerpColor(c, flash, 0.5);    ///// STATIC - HALFWAY BETWEEN C and FLASH
}
/////////////////////////////////////// COLOR ARRAY SETUP ////////////////////////////////////////
color col[] = new color[15];
void colorArray() {
  col[0] = purple; 
  col[1] = pink; 
  col[2] = orange1; 
  col[3] = aqua;
  col[4] = yell;
  col[5] = bloo;
  col[6] = purple;
  col[7] = grin;
  col[8] = orange;
  col[9] = aqua;
  col[10] = pink;
  col[11] = purple;
  col[12] = orange;
  col[13] = orange1;
  col[14] = teal;
  
}
/////////////////////////// COLOR SETUP CHOSE COLOUR VALUES ///////////////////////////////////////////////
color red, pink, yell, grin, bloo, purple, teal, orange, aqua, white, black;
color red1, pink1, yell1, grin1, bloo1, purple1, teal1, aqua1, orange1;
color red2, pink2, yell2, grin2, bloo2, purple2, teal2, aqua2, orange2;
void colorSetup() {
  colorMode(HSB, 360, 100, 100);
  white = color(0, 0, 80);
  black = color(0, 0, 0);

  float alt = 0;
  float sat = 100;
  aqua = color(150+alt, sat, 100);
  pink = color(323+alt, sat, 90);
  bloo = color(239+alt, sat, 100);
  yell = color(50+alt, sat, 100);
  grin = color(115+alt, sat, 100);
  orange = color(34.02+alt, sat, 90);
  purple = color(290+alt, sat, 70);
  teal = color(170+alt, sat, 85);
  red = color(7+alt, sat, 100);
  // colors that aren't affected by color swap
  float sat1 = 100;
  aqua1 = color(190+alt, 80, 100);
  pink1 = color(323-alt, sat1, 90);
  bloo1 = color(239-alt, sat1, 100);
  yell1 = color(50-alt, sat1, 100);
  grin1 = color(160-alt, sat1, 100);
  orange1 = color(34.02-alt, sat1, 90);
  purple1 = color(290-alt, sat1, 70);
  teal1 = color(170-alt, sat1, 85);
  red1 = color(15-alt, sat1, 100);
  /// alternative colour similar to original for 2 colour blends
  float sat2 = 100;
  alt = +6;
  aqua2 = color(190-alt, 80, 100);
  pink2 = color(323-alt, sat2, 90);
  bloo2 = color(239-alt, sat2, 100);
  yell2 = color(50-alt, sat2, 100);
  grin2 = color(160-alt, sat2, 100);
  orange2 = color(34.02-alt, sat2, 90);
  purple2 = color(290-alt, sat2, 70);
  teal2 = color(170-alt, sat2, 85);
  red2 = color(15-alt, sat2, 100);
}

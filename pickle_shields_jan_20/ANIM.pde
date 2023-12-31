
abstract class ManualAnim extends Anim {
  ManualAnim(Rig _rig) {
    super(_rig);
    alphaRate = rig.manualAlpha;
  }
  void draw() {
  }
  void drawAnim() {
    super.drawAnim();
    window.beginDraw();
    window.background(0);
    draw();
    window.endDraw();
    image(window, rig.size.x, rig.size.y, window.width, window.height);
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////
class AllOn extends Anim {
  AllOn(Rig _rig) {
    super( _rig);
    alphaRate=rig.manualAlpha;
  }
  void draw() {
    window.beginDraw();
    window.background(360*alphaA);
    window.endDraw();
  }
}
///////////////////////////////////////////////////////////////////////////////////////////////////////
class AllOff extends Anim {
  AllOff(Rig _rig) {
    super( _rig);
    alphaRate=rig.manualAlpha;
  }
  void draw() {
    window.beginDraw();
    window.background(0);
    window.endDraw();
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class StarMesh extends Anim {
  StarMesh ( Rig _rig) {
    super (_rig);
    animName = "starMesh";
  }
  void draw() {
    window.beginDraw();
    window.background(0);
    stroke = (rig.high+rig.wide)/2/20*strokeSlider;
    //println("function A", functionA);
    wide = (10+(functionA*rig.wide*1.5));
    high = (10+((1-functionA)*rig.high*1.5));
    rotate = -30*functionB;
    star(position[3].x, position[3].y, col1, stroke, wide, high, rotate, alphaA);
    star(position[4].x, position[4].y, col1, stroke, wide, high, rotate, alphaA);
    star(position[5].x, position[5].y, col1, stroke, wide, high, rotate, alphaA);
    window.endDraw();
  }
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class Celtic extends Anim {
  Celtic (Rig _rig) {
    super(_rig);
  }
  void draw() {
    window.beginDraw();
    window.background(0);
    stroke = 10+((rig.high+rig.wide)/2/20*strokeSlider); //16+(10*func1);
    wide = (10+(rig.wide-(rig.wide*functionA-20)))*wideSlider;
    high = wide;
    rotate = 0;
    donut(positionX[8][0].x, positionX[8][0].y, col1, stroke, wide, high, rotate, alphaA);
    donut(positionX[5][0].x, positionX[5][0].y, col1, stroke, wide, high, rotate, alphaA);
    donut(positionX[2][0].x, positionX[2][0].y, col1, stroke, wide, high, rotate, alphaA);
    window.endDraw();
  }
}

class SpiralFlower extends Anim {
  SpiralFlower(Rig _rig) {
    super(_rig);
  }
  void draw() {
    window.beginDraw();
    window.background(0);
    stroke = (rig.high+rig.wide)/2/20*strokeSlider;
    wide = (rig.wide)-(rig.wide/10);
    wide = 5+(wide-(wide*functionA)); //100+(20*i); //
    high = wide;
    rotate = 0;

    donut(positionX[1][1].x, positionX[1][1].y, col1, stroke, wide, high, rotate, alphaA);
    donut(positionX[4][1].x, positionX[4][1].y, col1, stroke, wide, high, rotate, alphaA);
    donut(positionX[7][1].x, positionX[7][1].y, col1, stroke, wide, high, rotate, alphaA);

    donut(positionX[0][2].x, positionX[0][2].y, col1, stroke, wide, high, rotate, alphaB);
    donut(positionX[3][2].x, positionX[3][2].y, col1, stroke, wide, high, rotate, alphaB);
    donut(positionX[6][2].x, positionX[6][2].y, col1, stroke, wide, high, rotate, alphaB);

    wide = (rig.wide/3.5)-(rig.wide/10);
    wide = 10+(wide-(wide*(1-functionA))); 
    high = wide;
    donut(viz.x, viz.y, col1, stroke, wide, high, rotate, alphaA);
    window.endDraw();
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class BenjaminsBoxes extends Anim {
  BenjaminsBoxes (Rig _rig) {
    super(_rig);
  }
  void draw() {
    window.beginDraw();
    window.background(0);
    wide = 600;
    high = 1000;

    //stroke *=strokeSlider;
    //wide *=wideSlider;
    //high *=highSlider;

    rotate = 45+(15*noize); //+(functionB*30);
    float xpos = 10+(noize*window.width/4);
    float ypos = viz.y;
    benjaminsBox(xpos, ypos, col1, wide, high, functionA, rotate, alphaA);
    benjaminsBox(xpos, ypos, col1, wide, high, functionA, -rotate, alphaA);

    xpos = vizWidth-10-(noize*window.width/4);
    benjaminsBox(xpos, ypos, col1, wide, high, 1-functionA, rotate, alphaA);
    benjaminsBox(xpos, ypos, col1, wide, high, 1-functionA, -rotate, alphaA);

    window.endDraw();
  }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class Anim1 extends Anim { ///////// COME BACK TO THIS WITH NEW ENVELOPES
  Anim1(Rig _rig) {
    super(_rig);
  }
  void draw() {
    window.beginDraw();
    window.background(0);
    stroke = 10+(30*functionA);
    if (_beatCounter % 8 < 3) rotate = -60*functionA;   /////////// CHANGE THIS TO A SPECIFIC FUNCTION IN THE ABOVE SECTION OF CODE
    else rotate = 60*functionB;                         /////////// CHANGE THIS TO A SPECIFIC FUNCTION IN THE ABOVE SECTION OF CODE
    wide = 10+(functionB*vizWidth);
    high = 110-(functionA*vizHeight);

    stroke *=strokeSlider;
    wide *=wideSlider;
    high *=highSlider;

    star(positionX[2][0].x, positionX[2][0].y, col1, stroke, wide, high, rotate, alphaA);
    star(positionX[4][2].x, positionX[4][2].y, col1, stroke, wide, high, rotate, alphaA);
    //
    println("functionA / B", functionA, functionB);
    println("wide/high 1", wide, high);

    wide = 10+(functionA*vizWidth);
    high = 110+(functionB*vizHeight);

    stroke *=strokeSlider;
    wide *=wideSlider;
    high *=highSlider;

    println("wide/high 2", wide, high);

    if (_beatCounter % 8 < 3) rotate = 60*functionA;    /////////// CHANGE THIS TO A SPECIFIC FUNCTION IN THE ABOVE SECTION OF CODE
    else rotate = -60*functionB;                        /////////// CHANGE THIS TO A SPECIFIC FUNCTION IN THE ABOVE SECTION OF CODE
    star(positionX[4][0].x, positionX[4][0].y, col1, stroke, wide, high, rotate, alphaA);
    star(positionX[2][2].x, positionX[2][2].y, col1, stroke, wide, high, rotate, alphaA);
    window.endDraw();
  }
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class Checkers extends Anim {
  Checkers(Rig _rig) {
    super(_rig);
  }
  void draw() {
    window.beginDraw();
    window.background(0);
    stroke = 20+(10*strokeSlider);
    rotate = 0;
    if (_beatCounter % 9 <4) { 
      for (int i = 0; i < opcGrid.columns; i+=2) {
        wide = (vizWidth*2)-(vizWidth/10);
        wide = 50+(wide-(wide*functionA)); 
        high = wide;

        //stroke *=strokeSlider;
        wide *=wideSlider;
        high *=highSlider;

        donut(position[i].x, position[i].y, col1, stroke, wide, high, rotate, alphaA);
        donut(position[i+1 % opcGrid.columns+6].x, position[i+1 % opcGrid.columns+6].y, col1, stroke, wide, high, rotate, alphaA);

        wide = (vizWidth/4)-(vizWidth/10);
        wide = (wide-(wide*functionA)); 
        high = wide;

        //stroke *=strokeSlider;
        wide *=wideSlider;
        high *=highSlider;

        donut(position[i+1 % opcGrid.columns].x, position[i+1 % opcGrid.columns].y, col1, stroke, wide, high, rotate, alphaA);
        donut(position[i+6].x, position[i+6].y, col1, stroke, wide, high, rotate, alphaA);
      }
    } else { // opposite way around
      for (int i = 0; i < opcGrid.columns; i+=2) {
        wide  = (vizWidth*2)-(vizWidth/10);
        wide = 50+(wide-(wide*functionA)); 
        high = wide;

        //stroke *=strokeSlider;
        wide *=wideSlider;
        high *=highSlider;

        donut(position[i+1 % opcGrid.columns].x, position[i+1 % opcGrid.columns].y, col1, stroke, wide, high, rotate, alphaB);
        donut(position[i+6].x, position[i+6].y, col1, stroke, wide, high, rotate, alphaB);
        wide = (vizWidth/4)-(vizWidth/10);
        wide = (wide-(wide*functionB)); 
        high = wide;

        //stroke *=strokeSlider;
        wide *=wideSlider;
        high *=highSlider;

        donut(position[i].x, position[i].y, col1, stroke, wide, high, rotate, alphaA);
        donut(position[i+1 % opcGrid.columns+6].x, position[i+1 % opcGrid.columns+6].y, col1, stroke, wide, high, rotate, alphaA);
      }
    }
    window.endDraw();
  }
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class Rings extends Anim {
  /*
  what benjamin would do
   Object wide,stroke,high; in anim main class
   make Processing/Java complain when you try to set wide/high
   so you get an error if you do it wrong
   in draw:
   wide.set(vizWidth*1.2) etc.
   wide.set(wide.get() - (wide.get()*functionA);
   if wide is a Ref, this allows us to later
   anim.wide.mul(wideslider);
   and the internals of the anim subclass don't need to have to remember to * by wideslider every time
   this is sort of what Ref() is for.
   */

  Rings(Rig _rig) {
    super(_rig);
    //animDimmer = animDimmer.mul(0.5);//this one is somehow blinding
  }
  void draw() {
    window.beginDraw();
    window.background(0);
    stroke = 15+((rig.high+rig.wide)/2/20*functionA)+(10*strokeSlider);
    wide = vizWidth*1.2;
    wide = wide-(wide*functionA);
    high = wide*2;
    rotate = 120*noize*functionB;

    wide *=wideSlider;
    high *=highSlider;

    donut(position[0].x, position[0].y, col1, stroke, wide, high, -rotate, alphaA);
    donut(position[1].x, position[1].y, col1, stroke, wide, high, -rotate-60, alphaA);
    donut(position[2].x, position[2].y, col1, stroke, wide, high, -rotate+60, alphaA);
    stroke = 15+((rig.high+rig.wide)/2/20*functionB*oskP)+(10*strokeSlider);
    wide = vizWidth*1.2;
    wide = wide-(wide*functionB);
    high = wide*2;
    rotate = -120*noize*functionA;

    wide *=wideSlider;
    high *=highSlider;

    donut(position[6].x, position[6].y, col1, stroke, wide, high, rotate, alphaB);
    donut(position[7].x, position[7].y, col1, stroke, wide, high, rotate-60, alphaB);
    donut(position[8].x, position[8].y, col1, stroke, wide, high, rotate+60, alphaB);
    window.endDraw();
  }
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class Rush extends Anim {
  Rush (Rig _rig) {
    super(_rig);
  }
  void draw() {
    window.beginDraw();
    window.background(0);
    wide = 500+(noize*150);

    stroke *=strokeSlider;
    wide *=wideSlider;
    high *=highSlider;

    if (_beatCounter % 8 < 3) {
      rush(position[0].x, position[3].y, col1, wide, vizHeight/2, functionA, alphaA);
      rush(position[11].x, position[8].y, col1, wide, vizHeight/2, -functionA, alphaA);
    } else {    
      rush(position[0]. x, position[3].y, col1, wide, vizHeight/2, -functionA, alphaA);
      rush(position[11].x, position[8].y, col1, wide, vizHeight/2, functionA, alphaA);
    }
    window.endDraw();
  }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class Rushed extends Anim {
  Rushed(Rig _rig) {
    super(_rig);
  }
  void draw() {
    window.beginDraw();
    window.background(0);
    wide = 150+(noize*600*functionA);
    high = vizHeight/2;

    stroke *=strokeSlider;
    wide *=wideSlider;
    high *=highSlider;

    if (beatCounter % 6 < 4) {
      rush(viz.x, position[3].y, col1, wide, high, functionA, alphaA);
      rush(viz.x, position[3].y, col1, wide, high, -functionB, alphaB);
      rush(viz.x, position[3].y, col1, wide, high, -functionA, alphaA);
      rush(viz.x, position[3].y, col1, wide, high, functionB, alphaB);
      //
      rush(viz.x, position[8].y, col1, wide, high, -functionA, alphaB);
      rush(viz.x, position[8].y, col1, wide, high, functionB, alphaA);
      rush(viz.x, position[8].y, col1, wide, high, functionA, alphaB);
      rush(viz.x, position[8].y, col1, wide, high, -functionB, alphaA);
    } else {
      rush(viz.x, position[3].y, col1, wide, high, functionB, alphaB);
      rush(viz.x, position[3].y, col1, wide, high, -functionA, alphaA);
      rush(viz.x, position[3].y, col1, wide, high, -functionB, alphaB);
      rush(viz.x, position[3].y, col1, wide, high, functionA, alphaA);
      //
      rush(viz.x, position[8].y, col1, wide, high, -functionB, alphaA);
      rush(viz.x, position[8].y, col1, wide, high, functionA, alphaB);
      rush(viz.x, position[8].y, col1, wide, high, functionB, alphaA);
      rush(viz.x, position[8].y, col1, wide, high, -functionA, alphaB);
    }
    window.endDraw();
  }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class SquareNuts extends Anim { 
  SquareNuts(Rig _rig) { 
    super(_rig);
  }                                // maybe add beatcounter flip postion for this
  void draw() {
    window.beginDraw();
    window.background(0);
    stroke = 300-(200*functionB);
    wide = vizWidth+(50);
    high = wide;

    stroke *=strokeSlider;
    wide *=wideSlider;
    high *=highSlider;

    if (rig == rigg) {
      squareNut(position[1].x, viz.y, col1, stroke, wide-(wide*functionA), high-(high*functionA), 0, alphaA);
      squareNut(position[4].x, viz.y, col1, stroke, wide-(wide*functionA), high-(high*functionA), 0, alphaA);
    } else {
      squareNut(window.width/4, window.height/4, col1, stroke, wide-(wide*functionA), high-(high*functionA), 0, alphaA);
      squareNut(window.width/4*3, window.height/4*3, col1, stroke, wide-(wide*functionA), high-(high*functionA), 0, alphaA);
    }
    window.endDraw();
  }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class DiagoNuts extends Anim { 
  DiagoNuts(Rig _rig) { 
    super(_rig);
  }                                // maybe add beatcounter flip postion for this
  void draw() {
    window.beginDraw();
    window.background(0);
    stroke = 100-(400*functionA);
    wide = vizWidth+(50);
    high = wide;

    stroke *=strokeSlider;
    wide *=wideSlider;
    high *=highSlider;

    if (rig == rigg) {
      squareNut(position[1].x, viz.y, col1, stroke, wide-(wide*functionA), high-(high*functionA), 45, alphaA);
      squareNut(position[4].x, viz.y, col1, stroke, wide-(wide*functionA), high-(high*functionA), 45, alphaA);
    } else {
      squareNut(window.width/4, window.height/4, col1, stroke, wide-(wide*functionA), high-(high*functionA), 45, alphaA);
      squareNut(window.width/4*3, window.height/4*3, col1, stroke, wide-(wide*functionA), high-(high*functionA), 45, alphaA);
    }
    window.endDraw();
  }
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class Stars extends Anim {
  Stars(Rig _rig) {
    super(_rig);
  }
  void draw() {
    window.beginDraw();
    window.background(0);
    wide = 2+(functionA*vizWidth*1.5);
    high = 2+(functionB*vizHeight*1.5);
    stroke = 15+(30*functionA);
    rotate = 30+(30*functionB);

    stroke *=strokeSlider;
    wide *=wideSlider;
    high *=highSlider;

    star(positionX[1][2].x, positionX[1][2].y, col1, stroke, wide, high, -rotate, alphaA);
    star(positionX[4][2].x, positionX[4][2].y, col1, stroke, wide, high, -rotate, alphaA);
    star(positionX[7][2].x, positionX[7][2].y, col1, stroke, wide, high, -rotate, alphaA);

    stroke = 12+(10*functionA);
    wide = 5+(shieldsGrid.bigShieldRad*1.2*(1-functionB));
    high = wide;
    donut(viz.x, viz.y, col1, stroke, wide, high, 0, alphaB);
    window.endDraw();
  }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class Swipe extends Anim {
  Swipe(Rig _rig) {
    super(_rig);
    //opcGrid.mirrorsOPC(opcMirror1, opcMirror2, 0);               // grids 0-3 MIX IT UPPPPP
  }
  void draw() {

    window.beginDraw();
    window.background(0);
    wide = 500+(noize*300);

    stroke *=strokeSlider;
    wide *=wideSlider;
    high *=highSlider;

    if   (beatCounter % 3 < 1) rush(position[0].x, viz.y, col1, wide, vizHeight, functionA, alphaA);
    else rush(position[0].x, viz.y, col1, wide, vizHeight, 1-functionA, alphaA);
    window.endDraw();
  }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class Swiped extends Anim {
  Swiped(Rig _rig) {
    super(_rig);
  }
  void draw() {

    window.beginDraw();
    window.background(0);
    wide = 150+(noize1*500*functionB);

    stroke *=strokeSlider;
    wide *=wideSlider;
    high *=highSlider;

    rush(viz.x, viz.y, col1, wide, vizHeight, functionA, alphaA);
    rush(-vizWidth/2, viz.y, col1, wide, vizHeight, 1-functionA, alphaA);
    window.endDraw();
  }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class Teeth extends Anim {
  Teeth(Rig _rig) {
    super( _rig);
    //functionBEnvelope = new(oskP Envelope); /////////////////////////////////
  }
  void draw() {
    window.beginDraw();
    window.background(0);
    //stroke = 50+(100*functionB);
    stroke = 50+(100*oskP);
    wide = vizWidth+(50);
    wide = wide-(wide*functionA);
    high = wide;

    stroke *=strokeSlider;
    wide *=wideSlider;
    high *=highSlider;

    //squareNut(positionX[0][2].x, positionX[0][2].y, col1, stroke, wide, high, -45, alphaA);
    squareNut(positionX[1][0].x, positionX[1][0].y, col1, stroke, wide, high, -45, alphaA);
    squareNut(positionX[2][2].x, positionX[2][2].y, col1, stroke, wide, high, -45, alphaA);
    //squareNut(positionX[3][0].x, positionX[3][0].y, col1, stroke, wide, high, -45, alphaA);
    squareNut(positionX[4][2].x, positionX[4][2].y, col1, stroke, wide, high, -45, alphaA);
    squareNut(positionX[5][0].x, positionX[5][0].y, col1, stroke, wide, high, -45, alphaA);
    //squareNut(positionX[6][2].x, positionX[6][2].y, col1, stroke, wide, high, -45, alphaA);

    wide = wide-(wide*functionB);
    high = wide;
    squareNut(positionX[0][2].x, positionX[0][2].y, col1, stroke, wide, high, -45, alphaA);
    squareNut(positionX[3][0].x, positionX[3][0].y, col1, stroke, wide, high, -45, alphaA);
    squareNut(positionX[6][2].x, positionX[6][2].y, col1, stroke, wide, high, -45, alphaA);

    window.endDraw();
  }
}
class TwistedStar extends Anim {
  TwistedStar(Rig _rig) {
    super(_rig);
  }
  void draw() {
    window.beginDraw();
    window.background(0);
    // star(int n, float wide, float high, float rotate, color col, float stroke, float alph) {
    stroke = 10+((rig.high+rig.wide)/2/20*functionB);
    wide = shieldsGrid.bigShieldRad/2+(functionA*rig.wide*1.2);
    high = shieldsGrid.bigShieldRad/2+((1-functionA)*rig.high*1.2);

    float wideB = shieldsGrid.bigShieldRad/2+(functionB*rig.high*1.2);
    float highB = shieldsGrid.bigShieldRad/2+((1-functionB)*rig.wide*1.2);
    rotate = 60*functionA;
    //void star(float xpos, float ypos, color col, float stroke, float wide, float high, float rotate, float alph) {
    starNine(viz.x, viz.y, col1, stroke, wide, high, wideB, highB, 40+rotate, alphaA, alphaB); 
    //10+(beats[i]*mw), 110-(pulzs[i]*mh), -60*beats[i], col1, stroke, alpha[i]/4*alf*dimmer);

    window.endDraw();
  }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class SingleDonut extends Anim {
  SingleDonut(Rig _rig) {            
    super(_rig);
  }
  void draw() {
    window.beginDraw();
    window.background(0);
    wide = 10+(rig.wide*1.2*(1-functionB));
    high = 10+(rig.high*1.2*(1-functionB));
    ;
    stroke = (rig.high+rig.wide)/2/15*strokeSlider;
    wide *=wideSlider;
    high *=highSlider;
    donut(viz.x, viz.y, col1, stroke, wide, high, 0, alphaA);
    window.endDraw();
  }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class BouncingDonut extends Anim {
  int beatcounted;
  int numberofanims;
  BouncingDonut(Rig _rig) {            
    super(_rig);
    numberofanims = rig.animations.size();
    beatcounted = (_beatCounter % (numberofanims+1));
  }
  void draw() {
    window.beginDraw();
    window.background(0);
    wide = rig.wide*1.2-(rig.wide*1.2*functionA*((beatcounted+1)));
    high = rig.high*1.2-(rig.high*1.2*functionA*((beatcounted+1)));
    ;
    stroke = (rig.high+rig.wide)/2/15*strokeSlider;
    wide *=wideSlider;
    high *=highSlider;
    donut(viz.x, viz.y, col1, stroke, wide, high, 0, alphaA);
    window.endDraw();
  }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class BouncingPolo extends Anim {
  int beatcounted;
  int numberofanims;
  BouncingPolo(Rig _rig) {            
    super(_rig);
    numberofanims = rig.animations.size();
    beatcounted = (_beatCounter % (numberofanims+1));
  }
  void draw() {
    window.beginDraw();
    window.background(0);
    wide = (rig.wide*1.2*functionA*((beatcounted+1)));
    high = (rig.high*1.2*functionA*((beatcounted+1)));
    ;
    stroke = wide*functionA;
    wide *=wideSlider;
    high *=highSlider;
    donut(viz.x, viz.y, col1, stroke, wide, high, 0, alphaA); 
    window.endDraw();
  }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class Polo extends Anim {
  Polo(Rig _rig) {            
    super(_rig);
  }
  void draw() {
    window.beginDraw();
    window.background(0);
    wide = rig.wide*1.2*(1-functionA);
    high = rig.high*1.2*(1-functionA);
    ;
    stroke = wide*functionA;
    wide *=wideSlider;
    high *=highSlider;
    donut(viz.x, viz.y, col1, stroke, wide, high, 0, alphaA);
    window.endDraw();
  }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class Fill extends Anim {
  Fill(Rig _rig) {
    super(_rig);
  }
  void draw() {
    window.beginDraw();
    window.background(0);
    window.noStroke();

    if (_beatCounter % 9 < 4) window.fill(360*alphaA);
    else window.fill(360*alphaB);
    window.rect(window.width/4, viz.y, window.width/2, window.height);
    //
    if (_beatCounter % 9 < 4) window.fill(360*alphaB);
    else window.fill(360*alphaA);
    window.rect(window.width/4*3, viz.y, window.width/2, window.height);
    window.endDraw();
  }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class Avoid extends Anim {
  Avoid(Rig _rig) {
    super(_rig);
  }
  void draw() {
    window.beginDraw();
    window.background(0);
    stroke = -window.width*functionA;
    wide = window.width;
    high = wide;
    squareNut(viz.x, viz.y, col1, stroke, wide, high, 0, 1);
    window.endDraw();
  }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class Test extends Anim {
  int atk, sus, dec, atk1, sus1, dec1, str, dur, str_per, end_per;
  float atk_curv, dec_curv, atk_curv1, dec_curv1;
  Test(Rig _rig) {
    super(_rig);
  }
  void draw() {  
    window.beginDraw();
    window.background(0);
    wide = 100;
    high = vizHeight/2; //*functionB;

    window.fill(360*alphaA);
    window.rect(viz.x, viz.y, 100, 100);
    window.endDraw();
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class Anim {
  float alphaRate, funcRate, dimmer, alphMod=1, funcMod=1, funcFX=1, alphFX=1, alphaA, alphaB, functionA, functionB;
  int blury, prevblury, vizIndex, alphaIndexA, alphaIndexB, functionIndexA, functionIndexB, _beatCounter;
  color col1, col2;
  PVector viz;
  PVector[] position = new PVector[18];
  PVector[][] positionX = new PVector[7][3];  
  PGraphics window, pass1, pass2;
  float alph[] = new float[7];
  float func[] = new float[8];
  boolean deleteme=false;
  String animName;
  Envelope alphaEnvelopeA, alphaEnvelopeB, functionEnvelopeA, functionEnvelopeB;
  Ref animDimmer;
  Rig rig;
  float overalltime;
  float strokeSlider, wideSlider, highSlider;

  Anim(Rig _rig) {
    animDimmer=new Ref(new float[]{1.0}, 0);
    rig = _rig;
    alphaRate = rig.alphaRate;
    funcRate = rig.funcRate;
    _beatCounter = (int)beatCounter;
    col1 = white;
    col2 = white;
    animName = "default";

    blury = int(map(rig.blurValue, 0, 1, 0, 100));     //// adjust blur amount using slider only when slider is changed - cheers Benjamin!! ////////
    if (blury!=prevblury) prevblury=blury;

    window = rig.buffer;
    viz = new PVector(window.width/2, window.height/2);
    vizWidth = float(this.window.width);
    vizHeight = float(this.window.height);

    pass1 = rig.pass1;
    pass2 = rig.pass2;
    position = rig.position; 
    positionX = rig.positionX;

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    overalltime = avgmillis;

    alphaEnvelopeA = envelopeFactory(rig.availableAlphaEnvelopes[rig.alphaIndexA], rig, overalltime);
    alphaEnvelopeB = envelopeFactory(rig.availableAlphaEnvelopes[rig.alphaIndexB], rig, overalltime);
    //if(functionEnvelopeFactory(rig.availableFunctionEnvelopes[rig.functionIndexA], rig) != NaN)
    functionEnvelopeA = functionEnvelopeFactory(rig.availableFunctionEnvelopes[rig.functionIndexA], rig);
    functionEnvelopeB = functionEnvelopeFactory(rig.availableFunctionEnvelopes[rig.functionIndexB], rig);

    strokeSlider = rig.strokeSlider;
    wideSlider = rig.wideSlider;
    highSlider = rig.highSlider;
  }

  void draw() {
    //Override Me in subclass
    fill(300+(60*stutter));
    textSize(30);
    textAlign(CENTER);
    text("OOPS!!\nCHECK YOUR ANIM LIST", rig.size.x, rig.size.y-15);
  }
  float stroke, wide, high, rotate;
  //Object highobj;
  Float vizWidth, vizHeight;
  void drawAnim() {
    int now = millis();
    alphaA = alphaEnvelopeA.value(now);
    alphaB = alphaEnvelopeB.value(now);

    alphaA *=rig.dimmer;
    alphaB *=rig.dimmer;

    Float funcX = functionEnvelopeA.value(now);
    if (!Float.isNaN(funcX)) functionA = funcX; 
    //functionEnvelopeA.value(now); 

    Float funcZ = functionEnvelopeB.value(now);
    if (!Float.isNaN(funcZ)) functionB = funcZ;
    //functionB = functionEnvelopeB.value(now);

    //println("functionA "+functionA,"alphaA "+alphaA, "rigdimmer " +rigg.dimmer);

    if (alphaEnvelopeA.end_time<now && alphaEnvelopeB.end_time<now) deleteme = true;  // only delete when all finished


    this.draw();

    /*
    if (syphonToggle) {
     if (this.rig == rigg) {
     ///// only send the rig animations???!!!???!!! /////
     syphonImageSent.beginDraw();
     syphonImageSent.blendMode(LIGHTEST);
     syphonImageSent.image(pass2, syphonImageSent.width/2, syphonImageSent.height/2, syphonImageSent.width, syphonImageSent.height);
     syphonImageSent.endDraw();
     }
     }
     */
    blurPGraphics();
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  
  void squareNut(float xpos, float ypos, color col, float stroke, float wide, float high, float rotate, float alph) {
    window.strokeWeight(-stroke);
    window.stroke(360*alph);
    window.noFill();
    window.pushMatrix();
    window.translate(xpos, ypos);
    window.rotate(radians(rotate));
    window.rect(0, 0, wide, high);
    window.popMatrix();
  }
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
  void donut(float xpos, float ypos, color col, float stroke, float wide, float high, float rotate, float alph) {
    try {
      window.strokeWeight(-stroke);
      window.stroke(360*alph);
      window.noFill();
      window.pushMatrix();
      window.translate(xpos, ypos);
      window.rotate(radians(rotate));
      window.ellipse(0, 0, wide, high);
      window.popMatrix();
    }
    catch(Exception e) {
      println(e, "BENJAMIN REALLY NEEDDS TO FIX THIS");
    }
  }
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
  void star(float xpos, float ypos, color col, float stroke, float wide, float high, float rotate, float alph) {
    try {
      this.window.strokeWeight(-stroke);
      this.window.stroke(360*alph);
      this.window.noFill();
      this.window.pushMatrix();                      //  ERROR too many calls to push matrix
      this.window.translate(xpos, ypos);
      this.window.rotate(radians(rotate));
      this.window.ellipse(0, 0, wide, high);         //  ERROR neagtive array size exception
      this.window.rotate(radians(120));
      this.window.ellipse(0, 0, wide, high);
      this.window.rotate(radians(120));
      this.window.ellipse(0, 0, wide, high);
      this.window.popMatrix();
    }  
    catch(Exception e) {
      println(wide, high);
      //NegativeArraySizeException();
      String message = e.getMessage();
      Throwable cause = e.getCause();
      println("message:", e, "cause", cause);
    }
  }
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
  void starNine(float xpos, float ypos, color col, float stroke, float wide, float high, float wideB, float highB, float rotate, float alph, float alphB) {
    try {
      int rot = 36;
      this.window.strokeWeight(-stroke);
      this.window.stroke(360*alph);
      this.window.noFill();
      this.window.pushMatrix();                      //  ERROR too many calls to push matrix
      this.window.translate(xpos, ypos);
      this.window.rotate(radians(rotate));
      this.window.ellipse(0, 0, wide, high);         //  ERROR neagtive array size exception
      this.window.rotate(radians(rot));
      this.window.ellipse(0, 0, wideB, highB);
      this.window.rotate(radians(rot));
      this.window.ellipse(0, 0, wide, high);
      this.window.rotate(radians(rot));
      this.window.ellipse(0, 0, wideB, highB);
      this.window.rotate(radians(rot));
      this.window.ellipse(0, 0, wide, high);
      this.window.rotate(radians(rot));
      this.window.ellipse(0, 0, wideB, highB);
      this.window.rotate(radians(rot));
      this.window.ellipse(0, 0, wide, high);
      this.window.rotate(radians(rot));
      this.window.ellipse(0, 0, wideB, highB);
      this.window.rotate(radians(rot));
      this.window.ellipse(0, 0, wide, high);
      this.window.rotate(radians(rot));
      this.window.ellipse(0, 0, wideB, highB);
      this.window.popMatrix();
    }  
    catch(Exception e) {
      println(wide, high);
      //NegativeArraySizeException();
      String message = e.getMessage();
      Throwable cause = e.getCause();
      println("message:", e, "cause", cause);
    }
  }
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
  void starNineA(float xpos, float ypos, color col, float stroke, float wide, float high, float wideB, float highB, float rotate, float alph, float alphB) {
    try {
      this.window.strokeWeight(-stroke);
      this.window.stroke(360*alph);
      this.window.noFill();
      this.window.pushMatrix();                      //  ERROR too many calls to push matrix
      this.window.translate(xpos, ypos);
      this.window.rotate(radians(rotate));
      this.window.ellipse(0, 0, wide, high);         //  ERROR neagtive array size exception
      this.window.rotate(radians(40));
      this.window.stroke(360*alphB);
      this.window.ellipse(0, 0, wideB, highB);
      this.window.rotate(radians(40));
      this.window.stroke(360*alph);
      this.window.ellipse(0, 0, wide, high);
      this.window.rotate(radians(40));
      this.window.stroke(360*alphB);
      this.window.ellipse(0, 0, wideB, highB);
      this.window.rotate(radians(40));
      this.window.stroke(360*alph);
      this.window.ellipse(0, 0, wide, high);
      this.window.rotate(radians(40));
      this.window.stroke(360*alphB);
      this.window.ellipse(0, 0, wideB, highB);
      this.window.rotate(radians(40));
      this.window.stroke(360*alph);
      this.window.ellipse(0, 0, wideB, highB);
      this.window.rotate(radians(40));
      this.window.stroke(360*alphB);
      this.window.ellipse(0, 0, wideB, highB);
      this.window.rotate(radians(40));
      this.window.stroke(360*alph);
      this.window.ellipse(0, 0, wideB, highB);
      this.window.popMatrix();
    }  
    catch(Exception e) {
      println(wide, high);
      //NegativeArraySizeException();
      String message = e.getMessage();
      Throwable cause = e.getCause();
      println("message:", e, "cause", cause);
    }
  }
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
  void rush(float xpos, float ypos, color col, float wide, float high, float func, float alph) {
    float moveA;
    float strt = xpos;
    moveA = (strt+((window.width)*func));
    window.imageMode(CENTER);
    window.tint(360, 360*alph);
    window.image(bar1, moveA, ypos, wide, high);
    window.noTint();
  }
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
  float diagonallen(PVector w, float r) {
    r=abs(r)%PI;
    if (r>PI*0.5) r = PI-r;
    if (r<atan(w.y/w.x)) return w.x/cos(r);
    return w.y/cos(PI*0.5-r);
  }


  void benjaminsBox(float xpos, float ypos, color col, float wide, float high, float func, float rotate, float alph) {
    rotate = radians(rotate);

    PVector box = new PVector(window.width, window.height);
    float distance = (-diagonallen(box, rotate)*0.5)-(diagonallen(box, rotate)*0.5);
    float moveA = (-(distance/2)+(distance*func))*1.3;

    window.imageMode(CENTER);
    window.tint(360*alph);
    window.pushMatrix();
    window.translate(xpos, ypos);
    window.rotate(rotate);
    window.image(bar1, moveA, 0, wide, high);
    window.noTint();
    window.popMatrix();
  }
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
  void drop(float xpos, float ypos, color col, float wide, float high, float func, float alph) {
    float moveA;
    float strt = window.height-ypos;
    moveA = (strt-((window.height)*func))*1.3;
    window.imageMode(CENTER);
    window.pushMatrix();
    window.translate(xpos, ypos);
    window.rotate(radians(90));
    window.tint(360*alph);
    window.image(bar1, moveA, 0, high, wide);
    window.noTint();
    window.popMatrix();
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
  void blurPGraphics() {
    blur.set("blurSize", blury);
    blur.set("horizontalPass", 0);
    pass1.beginDraw();            
    pass1.shader(blur); 
    pass1.imageMode(CENTER);
    pass1.image(window, pass1.width/2, pass1.height/2, pass1.width, pass1.height);
    pass1.endDraw();
    blur.set("horizontalPass", 1);
    pass2.beginDraw();            
    pass2.shader(blur);  
    pass2.imageMode(CENTER);
    pass2.image(pass1, pass2.width/2, pass2.height/2, pass2.width, pass2.height);
    pass2.endDraw();
    image(pass2, rig.size.x, rig.size.y, window.width, window.height);
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  PApplet getparent () {
    try {
      return (PApplet) getClass().getDeclaredField("this$0").get(this);
    }
    catch (ReflectiveOperationException cause) {
      throw new RuntimeException(cause);
    }
  }
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  float getval() {
    try {
      return animDimmer.f[animDimmer.i];
    } 
    catch (Exception e) {
      return 1;
    }
  }
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
}

interface Animation {
  void trigger();
  void decay();
}
abstract class ManualAnim extends Anim {
  ManualAnim(float _alphaRate, float _funcRate, Rig rig) {
    super( -1, _alphaRate, _funcRate, rig);
  }
  void draw() {
  }
  void drawAnim() {
    super.drawAnim();
    decay();
    alphaFunction();
    window.beginDraw();
    window.background(0);
    draw();
    window.endDraw();
    image(window, rig.size.x, rig.size.y, window.width, window.height);
  }
}
///////////////////////////////////////////////////////////////////////////////////////////////////////
class AllOn extends ManualAnim {
  float manualAlpha;
  void trigger() {
    super.trigger();
    manualAlpha=1;
  }
  void decay() {
    super.decay();
    manualAlpha*=map(this.alphaRate, 0, 1, 0.5, 0.97);
    manualAlpha*=this.funcRate;
  }
  AllOn(float _alphaRate, float _funcRate, Rig _rig) {
    super(_alphaRate, _funcRate, _rig);
    alphaRate=_alphaRate;
    funcRate=_funcRate;
  }
  void draw() {
    window.background(360*manualAlpha);
  }
}
///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////
class Anim implements Animation {
  float alphaRate, funcRate, dimmer, alphaA, functionA, alphaB, functionB, alphMod=1, funcMod=1, funcFX=1, alphFX=1;
  int blury, prevblury, vizIndex, alphaIndexA, alphaIndexB, functionIndexA, functionIndexB;
  color col1, col2;
  PVector viz;
  PVector[] position = new PVector[18];
  PVector[][] positionX = new PVector[7][3];  
  PGraphics window, pass1, pass2;
  float alph[] = new float[7];
  float func[] = new float[8];
  Rig rig;

  Anim(int _vizIndex, float _alphaRate, float _funcRate, Rig _rig) {
    alphaRate = _alphaRate;
    funcRate = _funcRate;
    rig = _rig;
    vizIndex = rig.vizIndex; 
    resetbeats(); 
    trigger();

    //// adjust blur amount using slider only when slider is changed - cheers Benjamin!! ////////
    blury = int(map(blurSlider, 0, 1, 0, 100));
    if (blury!=prevblury) {
      prevblury=blury;
    }
    col1 = white;
    col2 = white;

    vizIndex = _vizIndex;
    window = rig.buffer;
    viz = new PVector(window.width/2, window.height/2);
    pass1 = rig.pass1;
    pass2 = rig.pass2;
    alphaIndexA = rig.alphaIndexA;
    alphaIndexB = rig.alphaIndexB;
    functionIndexA = rig.functionIndexA;
    functionIndexB = rig.functionIndexB;

    position = rig.position; 
    positionX = rig.positionX;
  }

  float stroke, wide, high, rotate;
  Float vizWidth, vizHeight;
  void drawAnim() {
    decay();
    alphaFunction();

    vizWidth = float(this.window.width);
    vizHeight = float(this.window.height);


    /////////////////////////////////////// SHIMMER control for rig ////////////////////////////
    /* ////////////////////// should probably go inside play withyourself //////////////////////
     if (beatCounter % 42 > 36) { 
     alphaA = alph[alphaIndexA]+(shimmerSlider/2+(stutter*0.4*noize1*0.2));
     alphaB = alph[alphaIndexB]+(shimmerSlider/2+(stutter*0.4*noize1*0.2));
     } else {
     alphaA = alph[alphaIndexA]/1.2;    //*(0.6+0.4*noize12)/1.5;  //// set alpha to selected alpha with bit of variation
     alphaB = alph[alphaIndexB]/1.2;   //*(0.6+0.4*noize1)/1.5;  //// set alpha1 to selected alpha with bit of variation
     }
    /*
     //////////////// bright flash every 6 beats - counters all code above /////////
     if (beatCounter%6 == 0) {
     alphaA  = alph[alphaIndexA]*1.2;
     alphaB  = alph[alphaIndexB]*1.2;
     }
     */
    alphaA = alph[alphaIndexA];
    alphaB  = alph[alphaIndexB];

    alphaA*=rig.dimmer;
    alphaB*=rig.dimmer;

    functionA = func[functionIndexA]*funcFX;
    functionB = func[functionIndexB]*funcFX;
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    switch (vizIndex) {
    case 0:
      window.beginDraw();
      window.background(0);
      stroke = 30+(90*functionA*oskP);
      wide = vizWidth*1.2;
      wide = wide-(wide*functionA);
      high = wide*2;
      rotate = 90*noize*functionB;
      donut(position[2].x, position[2].y, col1, stroke, wide, high, rotate, alphaA);
      donut(position[9].x, position[9].y, col1, stroke, wide, high, rotate, alphaA);
      stroke = 30+(90*functionB*oskP);
      wide = vizWidth*1.2;
      wide = wide-(wide*functionB);
      high = wide*2;
      rotate = -90*noize*functionA;
      donut(position[3].x, position[3].y, col1, stroke, wide, high, rotate, alphaA);
      donut(position[8].x, position[8].y, col1, stroke, wide, high, rotate, alphaA);
      window.endDraw(); 
      break; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    case 1:
      window.beginDraw();
      window.background(0);
      stroke = 20+(400*tweakSlider);
      rotate = 0;
      if (beatCounter % 9 <3) { 
        for (int i = 0; i < opcGrid.columns; i+=2) {
          wide = (vizWidth*2)-(vizWidth/10);
          wide = 50+(wide-(wide*functionA)); 
          high = wide;
          donut(position[i].x, position[i].y, col1, stroke, wide, high, rotate, alphaA);
          donut(position[i+1 % opcGrid.columns+6].x, position[i+1 % opcGrid.columns+6].y, col1, stroke, wide, high, rotate, alphaA);
          //
          wide = (vizWidth/4)-(vizWidth/10);
          wide = 10+(wide-(wide*functionB)); 
          high = wide;
          donut(position[i+1 % opcGrid.columns].x, position[i+1 % opcGrid.columns].y, col1, stroke, wide, high, rotate, alphaB);
          donut(position[i+6].x, position[i+6].y, col1, stroke, wide, high, rotate, alphaB);
        }
      } else { // opposite way around
        for (int i = 0; i < opcGrid.columns; i+=2) {
          wide  = (vizWidth*2)-(vizWidth/10);
          wide = 50+(wide-(wide*functionA)); 
          high = wide;
          donut(position[i+1 % opcGrid.columns].x, position[i+1 % opcGrid.columns].y, col1, stroke, wide, high, rotate, alphaB);
          donut(position[i+6].x, position[i+6].y, col1, stroke, wide, high, rotate, alphaB);
          //
          wide = (vizWidth/4)-(vizWidth/10);
          wide = 10+(wide-(wide*functionB)); 
          high = wide;
          donut(position[i].x, position[i].y, col1, stroke, wide, high, rotate, alphaA);
          donut(position[i+1 % opcGrid.columns+6].x, position[i+1 % opcGrid.columns+6].y, col1, stroke, wide, high, rotate, alphaA);
        }
      }
      window.endDraw();
      break; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    case 2:
      window.beginDraw();
      window.background(0);
      stroke = 10+(30*function);
      if (beatCounter % 8 < 3) rotate = -60*func[0];
      else rotate = 60* func[0];
      wide = 10+(func[0]*vizWidth);
      high = 110-(func[1]*vizHeight);
      star(positionX[2][0].x, positionX[2][0].y, col1, stroke, wide, high, rotate, alphaA);
      star(positionX[4][2].x, positionX[4][2].y, col1, stroke, wide, high, rotate, alphaA);
      //
      wide = 10+(func[1]*vizWidth);
      high = 110+(func[0]*vizHeight);
      if (beatCounter % 8 < 3) rotate = 60*func[1];
      else rotate = -60*func[1];
      star(positionX[4][0].x, positionX[4][0].y, col1, stroke, wide, high, rotate, alphaA);
      star(positionX[2][2].x, positionX[2][2].y, col1, stroke, wide, high, rotate, alphaA);
      window.endDraw();
      break; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    case 3:
      window.beginDraw();
      window.background(0);
      wide = 500+(noize*150);
      if (beatCounter % 8 < 3) {
        rush(position[0].x, position[3].y, col1, wide, vizHeight/2, functionA, alphaA);
        rush(position[11].x, position[8].y, col1, wide, vizHeight/2, -functionA, alphaA);
      } else {    
        rush(position[0]. x, position[3].y, col1, wide, vizHeight/2, -functionA, alphaA);
        rush(position[11].x, position[8].y, col1, wide, vizHeight/2, functionA, alphaA);
      }
      window.endDraw();
      break; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    case 4:
      window.beginDraw();
      window.background(0);
      wide = 150+(noize*600*functionA);
      high = vizHeight/2;
      println(beatCounter % 6);
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
      break; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    case 5:
      window.beginDraw();
      window.background(0);
      wide = 10+(functionA*vizWidth*1.5);
      high = 10+(functionB*vizHeight*1.5);
      stroke = 30+(60*functionA*noize1);
      rotate = 30;
      star(positionX[1][1].x, viz.y, col1, stroke, wide, high, rotate, alphaA);
      rotate = -30;
      star(positionX[5][1].x, viz.y, col1, stroke, wide, high, rotate, alphaA);
      window.endDraw();
      break; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    case 6:
      window.beginDraw();
      window.background(0);
      stroke = 300-(200*noize);
      wide = vizWidth+(50);
      high = wide;
      squareNut(position[1].x, viz.y, col1, stroke, wide-(wide*functionA), high-(high*functionA), 0, alphaA);
      squareNut(position[4].x, viz.y, col1, stroke, wide-(wide*functionA), high-(high*functionA), 0, alphaA);
      window.endDraw();
      break; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    case 7:
      window.beginDraw();
      window.background(0);
      stroke = 50+(100*oskP);
      wide = vizWidth+(50);
      wide = wide-(wide*functionA);
      high = wide;
      squareNut(positionX[0][2].x, positionX[0][2].y, col1, stroke, wide, high, -45, alphaA);
      squareNut(positionX[1][0].x, positionX[1][0].y, col1, stroke, wide, high, -45, alphaA);
      squareNut(positionX[2][2].x, positionX[2][2].y, col1, stroke, wide, high, -45, alphaA);
      squareNut(positionX[3][0].x, positionX[3][0].y, col1, stroke, wide, high, -45, alphaA);
      squareNut(positionX[4][2].x, positionX[4][2].y, col1, stroke, wide, high, -45, alphaA);
      squareNut(positionX[5][0].x, positionX[5][0].y, col1, stroke, wide, high, -45, alphaA);
      squareNut(positionX[6][2].x, positionX[6][2].y, col1, stroke, wide, high, -45, alphaA);
      window.endDraw();
      break; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    case 8:
      window.beginDraw();
      window.background(0);
      wide = 500+(noize*300);
      if   (beatCounter % 3 < 1) rush(position[0].x, viz.y, col1, wide, vizHeight, functionA, alphaA);
      else rush(position[0].x, viz.y, col1, wide, vizHeight, 1-functionA, alphaA);
      window.endDraw();
      break; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    case 9:
      window.beginDraw();
      window.background(0);
      wide = 150+(noize1*500*functionA);
      rush(viz.x, viz.y, col1, wide, vizHeight, func[6], alphaA);
      rush(-vizWidth/2, viz.y, col1, wide, vizHeight, 1-func[6], alphaA);
      window.endDraw();
      break; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    case 10:
      window.beginDraw();
      window.background(0);
      //wide = 100*functionA;
      // donut(viz.x, viz.y, col1, wide, vizHeight, func[6], 0, alphaA);
      window.fill(360, 360*alphaA);
      window.noStroke();
      println(viz.x, viz.y);
      window.rect(viz.x, viz.y, window.width, window.height);
      window.endDraw();
    default: 
      break; ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    }
    //image(window, viz.x, viz.y, window.width, window.height);
    blurPGraphics();

    if (this.rig == rigg) {
      ///// only send the rig animations???!!!???!!! /////
      syphonImageSent.beginDraw();
      syphonImageSent.blendMode(LIGHTEST);
      syphonImageSent.image(pass2, syphonImageSent.width/2, syphonImageSent.height/2, syphonImageSent.width, syphonImageSent.height);
      syphonImageSent.endDraw();
    }
  }
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////// SQUARE NUT /////////////////////////////////////////////////////////////////////////////////////////////////
  void squareNut(float xpos, float ypos, color col, float stroke, float wide, float high, float rotate, float alph) {
    window.strokeWeight(-stroke);
    window.stroke(360, 360*alph);
    window.noFill();
    window.pushMatrix();
    window.translate(xpos, ypos);
    window.rotate(radians(rotate));
    window.rect(0, 0, wide, high);
    window.popMatrix();
  }
  /////////////////////////////////// DONUT /////////////////////////////////////////////////////////////////////////////////////////////////
  void donut(float xpos, float ypos, color col, float stroke, float wide, float high, float rotate, float alph) {
    window.strokeWeight(-stroke);
    window.stroke(360, 360*alph);
    window.noFill();
    window.pushMatrix();
    window.translate(xpos, ypos);
    window.rotate(radians(rotate));
    window.ellipse(0, 0, wide, high);
    window.popMatrix();
  }
  /////////////////////////////////// STAR ////////////////////////////////////////////////////////////////////////
  void star(float xpos, float ypos, color col, float stroke, float wide, float high, float rotate, float alph) {
    window.strokeWeight(-stroke);
    window.stroke(360, 360*alph);
    window.noFill();
    window.pushMatrix();
    window.translate(xpos, ypos);
    window.rotate(radians(rotate));
    window.ellipse(0, 0, wide, high);
    window.rotate(radians(120));
    window.ellipse(0, 0, wide, high);
    window.rotate(radians(120));
    window.ellipse(0, 0, wide, high);
    window.popMatrix();
  }
  /////////////////////////////////////// RUSH /////////////////////////////////////////////////////////
  void rush(float xpos, float ypos, color col, float wide, float high, float func, float alph) {
    float moveA;
    float strt = xpos;
    moveA = (strt+((window.width)*func));
    window.imageMode(CENTER);
    window.tint(360, 360*alph);
    window.image(bar1, moveA, ypos, wide, high);
    window.noTint();
  }
  ////////////////////////////////////////////////////////////////////////////////////////
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
  ///////////////////////////////////// DIMMER //////////////////////////////////////////////////////////////

  /////////////////////////////////// FUNCTION AND ALPHA ARRAYS //////////////////////////////////////////////
  void alphaFunction() {
    //// array of functions
    func[0] = 1-function;         
    func[1] = function;        
    func[2] = 1-functionSlow; 
    func[3] = (functionSlow*0.99)+(0.01*stutter);
    func[4] = (0.99*1-function)+(stutter*(1-function)*0.01);       
    func[5] = (0.99*functionSlow)+(stutter*(1-function)*0.01);
    func[6] = 1-functionSlow;
    func[7] = functionSlow;
    //// array of alphas
    alph[0] = alpha;
    alph[1] = 1-alpha;
    alph[2] = alpha+(0.05*stutter*alpha);
    alph[3] = (0.98*alpha)+(stutter*(1-alpha)*0.02);
    alph[4] = (0.98*(1-alpha))+(alpha*0.02*stutter);
    alph[5] = alphaFast;
    alph[6] = alphaSlow;
    //for (int i = 0; i < alph.length; i++) alph[i] *=dimmer;
    //for (int i = 0; i < func.length; i++) func[i] *=funcMod;
  }
  //////////////////////////////////// TRIGGER //////////////////////////////////////////////
  float alpha, alphaFast, alphaSlow;
  float function, functionFast, functionSlow;
  float deleteMeTimer;
  void trigger() {
    alpha = 1;
    alphaFast = 1;
    alphaSlow = 1;
    function = 1;
    functionFast = 1;
    functionSlow = 1;
    deleteMeTimer = 1;
  }
  //////////////////////////////////////// DECAY ////////////////////////////////////////////////
  boolean deleteme=false;
  void decay() {            
    if (avgtime>0) {
      alpha*=pow(alphaRate, (1/avgtime));       //  changes rate alpha fades out!!
      function*=pow(funcRate, (1/avgtime));     //  changes rate alpha fades out!!
      deleteMeTimer*=pow(deleteMeSlider, 1/avgtime); //lifetime
    } else {
      alpha*=0.95*alphaRate;
      function*=0.95*funcRate;
      deleteMeTimer*=0.98*deleteMeSlider;
    }

    if (alpha < 0.8) alpha *= 0.9;
    if (function < 0.8) function *= 0.9;

    alphaFast *=0.7;                 
    alphaSlow -= 0.05;

    functionFast *=0.7;  
    if (functionSlow < 0.4) functionSlow *= 0.99*noize1;
    else functionSlow -= 0.02;

    float end = 0.001;

    if (alpha < end) alpha = end+(shimmer*0.1);
    if (alphaFast < end) alphaFast = end;
    if (alphaSlow < 0.4+(noize1*0.2)) alphaSlow = 0.4+(noize1*0.2);

    if (function < end) function = end;
    if (functionFast < end) functionFast = end;
    if (functionSlow < end)  functionSlow = end;

    if (deleteMeTimer < end) deleteme = true;
  }
}

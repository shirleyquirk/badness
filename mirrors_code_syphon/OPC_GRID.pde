class OPCGrid {
  PVector[] mirror = new PVector[12];
  PVector[][] mirrorX = new PVector[7][4];
  PVector[] _mirror = new PVector[12];
  PVector[] seed = new PVector[3];
  PVector[] cansString = new PVector[3];
  PVector[] cans = new PVector[18];
  PVector[] strip = new PVector[6];
  PVector[] controller = new PVector[4];
  PVector uv; 
  PVector booth, dig;
  Rig rig;

  int pd, ld, dist, controllerGridStep, rows, columns;
  float mirrorAndGap, seedLength, _seedLength, seed2Length, _seed2Length, cansLength, _cansLength, _mirrorWidth, mirrorWidth, controllerWidth;

  OPCGrid () {
    pd = 6;             // distance between pixels
    ld = 16;            // number of leds per strip
    dist = 16*3;          // distance between mirrors;
    _mirrorWidth = ld*pd;
    mirrorAndGap = (pd*ld)+dist;

    switch (size.orientation) {
    case PORTRAIT:
      float yTop = size.rig.y - mirrorAndGap;                              // height Valuve for top line of mirrors
      float yBottom = size.rig.y + mirrorAndGap;  
      float yMid = size.rig.y;   
      rows = 3;
      columns = 4;
      for (int i = 0; i < mirrorX.length; i++) mirrorX[i][0] = new PVector (size.rig.x-(mirrorAndGap*columns/2)+((mirrorAndGap)*i), size.rig.y-(mirrorAndGap*rows/2));
      for (int i = 0; i < mirrorX.length; i++) mirrorX[i][1] = new PVector (size.rig.x-(mirrorAndGap*columns/2)+((mirrorAndGap)*i), size.rig.y-(mirrorAndGap/2));                   /// PVECTORS for MIDDLE GAPS 0-6
      for (int i = 0; i < mirrorX.length; i++) mirrorX[i][2] = new PVector (size.rig.x-(mirrorAndGap*columns/2)+((mirrorAndGap)*i), size.rig.y+(mirrorAndGap/2));  /// PVECTORS for BOTTOM GAPS 0-6
      for (int i = 0; i < mirrorX.length; i++) mirrorX[i][3] = new PVector (size.rig.x-(mirrorAndGap*columns/2)+((mirrorAndGap)*i), size.rig.y+(mirrorAndGap*rows/2));    /// PVECTORS for TOP GAPS 0-6
      // panel 1
      _mirror[0] = new PVector (size.rig.x-(mirrorAndGap/2)-mirrorAndGap, yTop);                  /// PVECTORS for CENTER of MIRRORS 0-2
      _mirror[1] = new PVector (size.rig.x-(mirrorAndGap/2), yTop);                  /// PVECTORS for CENTER of MIRRORS 0-2
      _mirror[2] = new PVector (size.rig.x-(mirrorAndGap/2)-mirrorAndGap, yMid);                  /// PVECTORS for CENTER of MIRRORS 0-2
      _mirror[3] = new PVector (size.rig.x-(mirrorAndGap/2), yMid);                  /// PVECTORS for CENTER of MIRRORS 0-2
      _mirror[4] = new PVector (size.rig.x-(mirrorAndGap/2), yBottom);                 /// PVECTORS for CENTER of MIRRORS 0-2
      _mirror[5] = new PVector (size.rig.x-(mirrorAndGap/2)-mirrorAndGap, yBottom);                       /// PVECTORS for CENTER of MIRRORS 0-2
      // panel 2
      _mirror[6] =  new PVector (size.rig.x+(mirrorAndGap/2)+mirrorAndGap, yBottom);                 /// PVECTORS for CENTER of MIRRORS 0-2
      _mirror[7] =  new PVector (size.rig.x+(mirrorAndGap/2), yBottom);                    /// PVECTORS for CENTER of MIRRORS 0-2
      _mirror[8] =  new PVector (size.rig.x+(mirrorAndGap/2)+mirrorAndGap, yMid);                   /// PVECTORS for CENTER of MIRRORS 0-2
      _mirror[9] =  new PVector (size.rig.x+(mirrorAndGap/2), yMid);                       /// PVECTORS for CENTER of MIRRORS 0-2
      _mirror[10] = new PVector (size.rig.x+(mirrorAndGap/2), yTop);                     /// PVECTORS for CENTER of MIRRORS 0-2
      _mirror[11] = new PVector (size.rig.x+(mirrorAndGap/2)+mirrorAndGap, yTop);                   /// PVECTORS for CENTER of MIRRORS 0-2
      //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      /////////////////////////// PVECTORS FOR CENTER OF MIRRORS FOR USE IN CODE /////////////////////////////////////////////////////
      mirror[0] = new PVector (size.rig.x-(mirrorAndGap/2)-mirrorAndGap, yTop);                  
      mirror[1] = new PVector (size.rig.x-(mirrorAndGap/2), yTop);                  
      mirror[2] = new PVector (size.rig.x+(mirrorAndGap/2), yTop);                  
      mirror[3] = new PVector (size.rig.x+(mirrorAndGap/2)+mirrorAndGap, yTop);                 
      mirror[4] = new PVector (size.rig.x-(mirrorAndGap/2)-mirrorAndGap, yMid);                   
      mirror[5] = new PVector (size.rig.x-(mirrorAndGap/2), yMid);                
      mirror[6] = new PVector (size.rig.x+(mirrorAndGap/2), yMid);                  
      mirror[7] = new PVector (size.rig.x+(mirrorAndGap/2)+mirrorAndGap, yMid);                    
      mirror[8] = new PVector (size.rig.x-(mirrorAndGap/2)-mirrorAndGap, yBottom);                  
      mirror[9] = new PVector (size.rig.x-(mirrorAndGap/2), yBottom);                 
      mirror[10]= new PVector (size.rig.x+(mirrorAndGap/2), yBottom);                  
      mirror[11]= new PVector (size.rig.x+(mirrorAndGap/2)+mirrorAndGap, yBottom); 
      break;
    case LANDSCAPE: 
      yTop = size.rig.y - (mirrorAndGap/2);                              // height Valuve for top line of mirrors
      yBottom = size.rig.y + (mirrorAndGap/2);  
      rows = 2;
      columns = 6;
      for (int i = 0; i < mirrorX.length; i++) mirrorX[i][0] = new PVector (size.rig.x-(mirrorAndGap*columns/2)+((mirrorAndGap)*i), size.rig.y-mirrorAndGap);    /// PVECTORS for TOP GAPS 0-6
      for (int i = 0; i < mirrorX.length; i++) mirrorX[i][1] = new PVector (size.rig.x-(mirrorAndGap*columns/2)+((mirrorAndGap)*i), size.rig.y);                   /// PVECTORS for MIDDLE GAPS 0-6
      for (int i = 0; i < mirrorX.length; i++) mirrorX[i][2] = new PVector (size.rig.x-(mirrorAndGap*columns/2)+((mirrorAndGap)*i), size.rig.y+mirrorAndGap);    /// PVECTORS for BOTTOM GAPS 0-6
      for (int i = 0; i < mirrorX.length; i++) mirrorX[i][3] = new PVector (size.rig.x-(mirrorAndGap*columns/2)+((mirrorAndGap)*i), size.rig.y);    /// PVECTORS for TOP GAPS 0-6
      // panel 1
      _mirror[0] = new PVector (size.rig.x-(mirrorAndGap*2.5), yBottom);                  /// PVECTORS for CENTER of MIRRORS 0-2
      _mirror[1] = new PVector (size.rig.x-(mirrorAndGap*2.5), yTop);                  /// PVECTORS for CENTER of MIRRORS 0-2
      _mirror[2] = new PVector (size.rig.x-(mirrorAndGap*1.5), yBottom);                  /// PVECTORS for CENTER of MIRRORS 0-2
      _mirror[3] = new PVector (size.rig.x-(mirrorAndGap*1.5), yTop);                  /// PVECTORS for CENTER of MIRRORS 0-2
      _mirror[4] = new PVector (size.rig.x-(mirrorAndGap*0.5), yTop);                  /// PVECTORS for CENTER of MIRRORS 0-2
      _mirror[5] = new PVector (size.rig.x-(mirrorAndGap*0.5), yBottom);                  /// PVECTORS for CENTER of MIRRORS 0-2
      // panel 2
      _mirror[6] = new PVector (size.rig.x+(mirrorAndGap*0.5), yBottom);                  /// PVECTORS for CENTER of MIRRORS 0-2
      _mirror[7] = new PVector (size.rig.x+(mirrorAndGap*0.5), yTop);                  /// PVECTORS for CENTER of MIRRORS 0-2
      _mirror[8] = new PVector (size.rig.x+(mirrorAndGap*1.5), yBottom);                  /// PVECTORS for CENTER of MIRRORS 0-2
      _mirror[9] = new PVector (size.rig.x+(mirrorAndGap*1.5), yTop);                  /// PVECTORS for CENTER of MIRRORS 0-2
      _mirror[10] = new PVector (size.rig.x+(mirrorAndGap*2.5), yTop);                  /// PVECTORS for CENTER of MIRRORS 0-2
      _mirror[11] = new PVector (size.rig.x+(mirrorAndGap*2.5), yBottom);                  /// PVECTORS for CENTER of MIRRORS 0-2
      //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      /////////////////////////// PVECTORS FOR CENTER OF MIRRORS FOR USE IN CODE /////////////////////////////////////////////////////
      mirror[0] = new PVector (size.rig.x-(mirrorAndGap*2.5), yTop);                  
      mirror[1] = new PVector (size.rig.x-(mirrorAndGap*1.5), yTop);                  
      mirror[2] = new PVector (size.rig.x-(mirrorAndGap*0.5), yTop);                  
      mirror[3] = new PVector (size.rig.x+(mirrorAndGap*0.5), yTop);                
      mirror[4] = new PVector (size.rig.x+(mirrorAndGap*1.5), yTop);                   
      mirror[5] = new PVector (size.rig.x+(mirrorAndGap*2.5), yTop);                
      mirror[6] = new PVector (size.rig.x-(mirrorAndGap*2.5), yBottom);                   
      mirror[7] = new PVector (size.rig.x-(mirrorAndGap*1.5), yBottom);                   
      mirror[8] = new PVector (size.rig.x-(mirrorAndGap*0.5), yBottom);                  
      mirror[9] = new PVector (size.rig.x+(mirrorAndGap*0.5), yBottom);                 
      mirror[10]= new PVector (size.rig.x+(mirrorAndGap*1.5), yBottom);                  
      mirror[11]= new PVector (size.rig.x+(mirrorAndGap*2.5), yBottom);
      break;
    }
    mirrorWidth = _mirrorWidth+16;
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    booth = new PVector (width - 30, 110);
    dig = new PVector (width - 30, 125);
  }
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////// MIRRORS //////////////////////////////////////////////
  void mirrorsOPC(OPC opc, OPC opc1, int gridStep) {
    switch (size.orientation) {  
    case PORTRAIT:
      switch(gridStep) {
      case 0:
        for (int i = 0; i < 6; i++) {       /////////////// LEFT HAND PANNEL OF MIRRORS /////////////////////////////////
          opc.ledStrip((64*(5-i))+(ld*0), ld, _mirror[i].x+(ld/2*pd), _mirror[i].y, pd, (PI/2), true);               // RIGHT vertical strip
          opc.ledStrip((64*(5-i))+(ld*1), ld, _mirror[i].x, _mirror[i].y-(ld/2*pd), pd, 0, true);
          opc.ledStrip((64*(5-i))+(ld*2), ld, _mirror[i].x-(ld/2*pd), _mirror[i].y, pd, (PI/2), false);             // LEFT vertical strip
          opc.ledStrip((64*(5-i))+(ld*3), ld, _mirror[i].x, _mirror[i].y+(ld/2*pd), pd, 0, false);          // BOTTOM horizontal strip
        }
        for (int i = 6; i < 12; i++) {       /////////////// RIGHT HAND PANNEL OF MIRRORS /////////////////////////////////
          opc1.ledStrip(512+(64*(i-6))+(ld*0), ld, _mirror[i].x+(ld/2*pd), _mirror[i].y, pd, (PI/2), true);       // Right Vertical strip 
          opc1.ledStrip(512+(64*(i-6))+(ld*1), ld, _mirror[i].x, _mirror[i].y-(ld/2*pd), pd, 0, true);           // Top horizontal strip
          opc1.ledStrip(512+(64*(i-6))+(ld*2), ld, _mirror[i].x-(ld/2*pd), _mirror[i].y, pd, (PI/2), false);         // Left Vertical strip
          opc1.ledStrip(512+(64*(i-6))+(ld*3), ld, _mirror[i].x, _mirror[i].y+(ld/2*pd), pd, 0, false);           // Bottom horizontal strip
        }
        break;
      case 1:
        for (int i = 0; i < 6; i++) opc.ledStrip((64*(5-i))+(ld*0), ld*4, _mirror[i].x, _mirror[i].y, pd/3.8, 0, true);                 
        for (int i = 6; i < 12; i++) opc1.ledStrip(512+(64*(i-6))+(ld*0), ld*4, _mirror[i].x, _mirror[i].y, pd/3.8, 0, false);
        break;
      case 2:
        for (int i = 0; i < 6; i++) opc.ledStrip((64*(5-i))+(ld*0), ld*4, size.rig.x-(size.rigWidth/2)+(size.rigWidth/12*(i+0.6)), size.rig.y, size.rigHeight/64, PI/2, true);                 
        for (int i = 6; i < 12; i++) opc1.ledStrip(512+(64*(i-6))+(ld*0), ld*4, size.rig.x-(size.rigWidth/2)+(size.rigWidth/12*(i+0.6)), size.rig.y, size.rigHeight/64, PI/2, false);
        break;
      default:
        for (int i = 0; i < 6; i++) {       /////////////// LEFT HAND PANNEL OF MIRRORS /////////////////////////////////
          opc.ledStrip((64*(5-i))+(ld*0), ld, _mirror[i].x+(ld/2*pd), _mirror[i].y, pd, (PI/2), true);               // RIGHT vertical strip
          opc.ledStrip((64*(5-i))+(ld*1), ld, _mirror[i].x, _mirror[i].y-(ld/2*pd), pd, 0, true);
          opc.ledStrip((64*(5-i))+(ld*2), ld, _mirror[i].x-(ld/2*pd), _mirror[i].y, pd, (PI/2), false);             // LEFT vertical strip
          opc.ledStrip((64*(5-i))+(ld*3), ld, _mirror[i].x, _mirror[i].y+(ld/2*pd), pd, 0, false);          // BOTTOM horizontal strip
        }
        for (int i = 6; i < 12; i++) {       /////////////// RIGHT HAND PANNEL OF MIRRORS /////////////////////////////////
          opc1.ledStrip(512+(64*(i-6))+(ld*0), ld, _mirror[i].x+(ld/2*pd), _mirror[i].y, pd, (PI/2), true);       // Right Vertical strip 
          opc1.ledStrip(512+(64*(i-6))+(ld*1), ld, _mirror[i].x, _mirror[i].y-(ld/2*pd), pd, 0, true);           // Top horizontal strip
          opc1.ledStrip(512+(64*(i-6))+(ld*2), ld, _mirror[i].x-(ld/2*pd), _mirror[i].y, pd, (PI/2), false);         // Left Vertical strip
          opc1.ledStrip(512+(64*(i-6))+(ld*3), ld, _mirror[i].x, _mirror[i].y+(ld/2*pd), pd, 0, false);           // Bottom horizontal strip
        }
        break;
      }
      break;
    case LANDSCAPE:
      switch(gridStep) {
      case 0:    /////////////// LEFT HAND PANNEL OF MIRRORS /////////////////////////////////
        for (int i = 0; i < 6; i++) {
          opc.ledStrip((64*(5-i))+(ld*0), ld, _mirror[i].x, _mirror[i].y-(ld/2*pd), pd, 0, true);                 // TOP horizontal strip 
          opc.ledStrip((64*(5-i))+(ld*1), ld, _mirror[i].x-(ld/2*pd), _mirror[i].y, pd, (PI/2), false);             // LEFT vertical strip
          opc.ledStrip((64*(5-i))+(ld*2), ld, _mirror[i].x, _mirror[i].y+(ld/2*pd), pd, 0, false);          // BOTTOM horizontal strip
          opc.ledStrip((64*(5-i))+(ld*3), ld, _mirror[i].x+(ld/2*pd), _mirror[i].y, pd, (PI/2), true);               // RIGHT vertical strip
        }
        /////////////// RIGHT HAND PANNEL OF MIRRORS /////////////////////////////////
        for (int i = 6; i < 12; i++) {
          opc1.ledStrip(512+(64*(i-6))+(ld*0), ld, _mirror[i].x, _mirror[i].y+(ld/2*pd), pd, 0, false);           // Bottom horizontal strip 
          opc1.ledStrip(512+(64*(i-6))+(ld*1), ld, _mirror[i].x+(ld/2*pd), _mirror[i].y, pd, (PI/2), true);       // Right Vertical strip       
          opc1.ledStrip(512+(64*(i-6))+(ld*2), ld, _mirror[i].x, _mirror[i].y-(ld/2*pd), pd, 0, true);           // Top horizontal strip
          opc1.ledStrip(512+(64*(i-6))+(ld*3), ld, _mirror[i].x-(ld/2*pd), _mirror[i].y, pd, (PI/2), false);         // Left Vertical strip
        }
        break;
      case 1:
        for (int i = 0; i < 6; i++) opc.ledStrip((64*(5-i))+(ld*0), ld*4, _mirror[2].x, 50+((size.rigHeight-55)/6*i), pd/1.2, 0, true);                 // TOP horizontal strip
        for (int i = 6; i < 12; i++) opc1.ledStrip(512+(64*(i-6))+(ld*0), ld*4, _mirror[8].x, 50+((size.rigHeight-55)/6*(i-6)), pd/1.2, 0, true);                 // TOP horizontal strip
        break;
      case 2:
        for (int i = 0; i < 6; i++) opc.ledStrip((64*(5-i))+(ld*0), ld*4, _mirror[i].x, _mirror[i].y, pd/3.6, 0, true);                 // TOP horizontal strip
        for (int i = 6; i < 12; i++) opc1.ledStrip(512+(64*(i-6))+(ld*0), ld*4, _mirror[i].x, _mirror[i].y, pd/3.6, 0, true);
        break;
      case 3:
        for (int i = 0; i < 6; i++) opc.ledStrip((64*(5-i))+(ld*0), ld*4, size.rig.x, 48+((size.rigHeight-55)/12*i), pd*1.8, 0, true);                 // TOP horizontal strip
        for (int i = 6; i < 12; i++) opc1.ledStrip(512+(64*(i-6))+(ld*0), ld*4, size.rig.x, 52+((size.rigHeight-55)/12*(i)), pd*1.8, 0, true);                 // TOP horizontal strip
        break;
      }
      break;
    }
    rigg.position=opcGrid.mirror;
    rigg.positionX=opcGrid.mirrorX;
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////// SEEDS ///////////////////////////////////////////////

  /////////////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////// CANS //////////////////////////////////////////////////
  void individualCansOPC(Rig _rig, OPC opc) {
    rig = _rig;
    float xw = 6;
    for (int i=0; i<cans.length/xw; i++) cans[i] =     new PVector (rig.size.x-(rig.wide/2)+(rig.wide/(cans.length/xw+1)*(i+1)), rig.size.y-(rig.high/2)+rig.high/(xw+1)*1);
    for (int i=0; i<cans.length/xw; i++) cans[i+3] =   new PVector (rig.size.x-(rig.wide/2)+(rig.wide/(cans.length/xw+1)*(i+1)), rig.size.y-(rig.high/2)+rig.high/(xw+1)*2);
    for (int i=0; i<cans.length/xw; i++) cans[i+6] =   new PVector (rig.size.x-(rig.wide/2)+(rig.wide/(cans.length/xw+1)*(i+1)), rig.size.y-(rig.high/2)+rig.high/(xw+1)*3);
    for (int i=0; i<cans.length/xw; i++) cans[i+9] =   new PVector (rig.size.x-(rig.wide/2)+(rig.wide/(cans.length/xw+1)*(i+1)), rig.size.y-(rig.high/2)+rig.high/(xw+1)*4);
    for (int i=0; i<cans.length/xw; i++) cans[i+12] =  new PVector (rig.size.x-(rig.wide/2)+(rig.wide/(cans.length/xw+1)*(i+1)), rig.size.y-(rig.high/2)+rig.high/(xw+1)*5);
    for (int i=0; i<cans.length/xw; i++) cans[i+15] =  new PVector (rig.size.x-(rig.wide/2)+(rig.wide/(cans.length/xw+1)*(i+1)), rig.size.y-(rig.high/2)+rig.high/(xw+1)*6);


    int fc = 2 * 512;
    int channel = 64;
    for (int i = 0; i < cans.length/3; i++) opc.led(fc+(channel*0+i), int(cans[i].x), int(cans[i].y));                   /////  6 CANS PLUG INTO slot 0 on CANS BOX /////// 
    for (int i = 0; i < cans.length/3; i++) opc.led(fc+(channel*1+i), int(cans[i+6].x), int(cans[i+6].y));                   /////  6 CANS PLUG INTO slot 0 on CANS BOX /////// 
    for (int i = 0; i < cans.length/3; i++) opc.led(fc+(channel*2+i), int(cans[i+12].x), int(cans[i+12].y));                   /////  6 CANS PLUG INTO slot 0 on CANS BOX ///////

    ////  set roof position to individual cans positions
    for (int i = 0; i < rig.position.length/2; i++) {
      rig.position[i].x=opcGrid.cans[i].x-(rig.size.x-(rig.wide/2));
      rig.position[i].y=opcGrid.cans[i].y-(rig.size.y-(rig.high/2));
      //
      rig.position[i+6].x=opcGrid.cans[i+12].x-(rig.size.x-(rig.wide/2));
      rig.position[i+6].y=opcGrid.cans[i+12].y-(rig.size.y-(rig.high/2));
    }
    rig.position[4].x=cans[7].x-(rig.size.x-(rig.wide/2));
    rig.position[4].y=cans[7].y-(rig.size.y-(rig.high/2));

    rig.position[7].x=cans[10].x-(rig.size.x-(rig.wide/2));
    rig.position[7].y=cans[10].y-(rig.size.y-(rig.high/2));
  }
  void kallidaCansOPC(OPC opc) {
    int fc = 5 * 512;
    int channel = 64;
    int leds = 6;
    pd = int(_cansLength/6);
    opc.ledStrip(fc+(channel*0), leds, int(cansString[0].x), int(cansString[0].y), pd, 0, false);                   /////  6 CANS PLUG INTO slot 0 on CANS BOX /////// 
    opc.ledStrip(fc+(channel*1)+(64*channel), leds, int(cansString[1].x), int(cansString[1].y), pd, 0, false);      /////  6 CANS PLUG INTO slot 1 on CANS BOX ///////
    cansLength = _cansLength - (pd/2);
  } /////////////////////////////////////////////////////////////////////////////////////////////////////
  void pickleCansOPC(Rig _rig, OPC opc) {
    rig = _rig;
    _cansLength = size.cansWidth;
    cansString[0] = new PVector(rig.size.x, rig.size.y-(rig.high/4));
    cansString[1] = new PVector(rig.size.x, rig.size.y);
    cansString[2] = new PVector(rig.size.x, rig.size.y+(rig.high/4));

    int fc = 2 * 512;
    int channel = 64;
    int leds = 6;
    pd = int(_cansLength/6);
    opc.ledStrip(fc+(channel*5), leds, int(cansString[0].x), int(cansString[0].y), pd, 0, false);                   /////  6 CANS PLUG INTO slot 0 on CANS BOX /////// 
    opc.ledStrip(fc+(channel*6), leds, int(cansString[1].x), int(cansString[1].y), pd, 0, false);                   /////  6 CANS PLUG INTO slot 0 on CANS BOX /////// 
    opc.ledStrip(fc+(channel*7), leds, int(cansString[2].x), int(cansString[2].y), pd, 0, false);                   /////  6 CANS PLUG INTO slot 0 on CANS BOX /////// 

    cansLength = _cansLength - (pd/2);
  } /////////////////////////////////////////////////////////////////////////////////////////////////////
  void kingsHeadCansOPC(Rig _rig, OPC opc) {
    rig = _rig;
    _cansLength = size.cansWidth;
    cansString[0] = new PVector(rig.size.x, rig.size.y-(rig.high/4));
    cansString[1] = new PVector(rig.size.x, rig.size.y);
    cansString[2] = new PVector(rig.size.x, rig.size.y+(rig.high/4));

    int fc = 0 * 512;
    int channel = 64;
    int leds = 6;
    pd = int(_cansLength/6);
    opc.ledStrip(fc+(channel*0), leds, int(cansString[0].x), int(cansString[0].y), pd, 0, true);                   /////  6 CANS PLUG INTO slot 0 on CANS BOX /////// 
    opc.ledStrip(fc+(channel*1), leds, int(cansString[1].x), int(cansString[1].y), pd, 0, true);                   /////  6 CANS PLUG INTO slot 0 on CANS BOX /////// 
    opc.ledStrip(fc+(channel*2), leds, int(cansString[2].x), int(cansString[2].y), pd, 0, true);                   /////  6 CANS PLUG INTO slot 0 on CANS BOX /////// 
    cansLength = _cansLength - (pd/2);
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////// UV /////////////////////////////////////////////////////
  void kallidaUV(OPC opc) {
    int fc = 2 * 512;
    int channel = 64;                 
    opc.led(fc+(channel*7), int(uv.x), int(uv.y));
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////// STRIP ///////////////////////////////////////////////////////////////
  void kingsHeadStripOPC(Rig _rig, OPC opc) {
    rig = _rig;
    int fc = 3 * 512;
    int channel = 64;
    int leds = 64;
    int pd = rig.wide/2/leds;
    for (int i = 0; i < 3; i++) strip[i] = new PVector (rig.size.x-(pd*leds/2), rig.size.y-(rig.high/2)+rig.high/6*(i*2+1));
    for (int i = 0; i < 3; i++) strip[i+3] = new PVector (rig.size.x+(pd*leds/2), rig.size.y-(rig.high/2)+rig.high/6*(i*2+1));

    for (int i=0; i<6; i++)  opc.ledStrip(fc+(channel), leds, int(strip[i].x), int(strip[i].y), pd, 0, true);
  }

  void espTestOPC(Rig _rig, OPC opc) {
    rig = _rig;
    int fc = 0 * 512;
    int channel = 64;
    int leds = 120;
    int pd = rig.wide/2/leds;
    for (int i = 0; i < 3; i++) strip[i] = new PVector (rig.size.x-(pd*leds/2), rig.size.y-(rig.high/2)+rig.high/6*(i*2+1));
    for (int i = 0; i < 3; i++) strip[i+3] = new PVector (rig.size.x+(pd*leds/2), rig.size.y-(rig.high/2)+rig.high/6*(i*2+1));

    for (int i=0; i<1; i++) opc.ledStrip(fc+(channel*i), leds, int(strip[i].x), int(strip[i].y), 2, 0, true);
  }


  //////////// check which controllers are which here when setting up
  // left to right should be 0 - 3;

  void kallidaControllers(OPC opc, OPC opc2, int controllerGridStep) {
    int fc = 3 * 512;                 // fadecandy number (first one used is 0)
    int channel = 64;                 // pair of holes on fadecandy board
    int leds = 23;                    // leds in strip
    int pd = 3;                       // distance between pixels
    controllerWidth = pd*leds+8;
    switch(controllerGridStep) {
    case 0:
      controller[0] = new PVector(mirror[0].x, mirror[0].y);
      controller[1] = new PVector(mirror[5].x, mirror[5].y);
      controller[2] = new PVector(mirror[6].x, mirror[6].y);
      controller[3] = new PVector(mirror[3].x, mirror[3].y);
      break;
    case 1:
      controller[0] = new PVector(mirror[1].x, mirror[1].y);
      controller[1] = new PVector(mirror[2].x, mirror[2].y);
      controller[2] = new PVector(mirror[9].x, mirror[9].y);
      controller[3] = new PVector(mirror[10].x, mirror[10].y);
      break;
    case 2:
      controller[0] = new PVector(mirror[4].x, mirror[4].y);
      controller[1] = new PVector(mirror[5].x, mirror[5].y);
      controller[2] = new PVector(mirror[6].x, mirror[6].y);
      controller[3] = new PVector(mirror[7].x, mirror[7].y);
      break;
    case 3:
      controller[0] = new PVector(mirror[8].x, mirror[8].y+_mirrorWidth+(dist/3));
      controller[1] = new PVector(mirror[9].x, mirror[9].y+_mirrorWidth+(dist/3));
      controller[2] = new PVector(mirror[10].x, mirror[10].y+_mirrorWidth+(dist/3));
      controller[3] = new PVector(mirror[11].x, mirror[11].y+_mirrorWidth+(dist/3));
      break;
    case 4:
      controller[0] = new PVector(mirror[0].x, mirror[0].y);
      controller[1] = new PVector(mirror[8].x, mirror[8].y);
      controller[2] = new PVector(mirror[3].x, mirror[3].y);
      controller[3] = new PVector(mirror[11].x, mirror[11].y);
      break;
    default:
      controller[0] = new PVector(mirror[0].x, mirror[0].y);
      controller[1] = new PVector(mirror[5].x, mirror[5].y);
      controller[2] = new PVector(mirror[6].x, mirror[6].y);
      controller[3] = new PVector(mirror[3].x, mirror[3].y);
      break;
    }
    /////////////////////////////////// CONTROLLER A 1 ///////////////////////////////
    fc = 3 * 512;   
    opc.ledStrip(fc+(channel*0), 23, controller[0].x-(leds/2*pd+(pd/2)), controller[0].y, pd, PI/2, true);
    opc.ledStrip(fc+(channel*0)+leds, 23, controller[0].x, controller[0].y-+(leds/2*pd+(pd/2)), pd, 0, false);
    opc.ledStrip(fc+(channel*1), 23, controller[0].x+(leds/2*pd+(pd/2)), controller[0].y, pd, PI/2, false);
    opc.ledStrip(fc+(channel*1)+leds, 23, controller[0].x, controller[0].y+(leds/2*pd+(pd/2)), pd, 0, true);
    /////////////////////////////////// CONTROLLER A 2 ///////////////////////////////
    opc.ledStrip(fc+(channel*2), 23, controller[1].x-(leds/2*pd+(pd/2)), controller[1].y, pd, PI/2, true);
    opc.ledStrip(fc+(channel*2)+leds, 23, controller[1].x, controller[1].y-+(leds/2*pd+(pd/2)), pd, 0, false);
    opc.ledStrip(fc+(channel*3), 23, controller[1].x+(leds/2*pd+(pd/2)), controller[1].y, pd, PI/2, false);
    opc.ledStrip(fc+(channel*3)+leds, 23, controller[1].x, controller[1].y+(leds/2*pd+(pd/2)), pd, 0, true);
    /////////////////////////////////// CONTROLLER B 1 ///////////////////////////////
    //fc = 3 * 512;            
    opc2.ledStrip(fc+(channel*4), 23, controller[2].x-(leds/2*pd+(pd/2)), controller[2].y, pd, PI/2, true);
    opc2.ledStrip(fc+(channel*4)+leds, 23, controller[2].x, controller[2].y-(leds/2*pd+(pd/2)), pd, 0, false);
    opc2.ledStrip(fc+(channel*5), 23, controller[2].x+(leds/2*pd+(pd/2)), controller[2].y, pd, PI/2, false);
    opc2.ledStrip(fc+(channel*5)+leds, 23, controller[2].x, controller[2].y+(leds/2*pd+(pd/2)), pd, 0, true);
    /////////////////////////////////// CONTROLLER B 2 ///////////////////////////////
    opc2.ledStrip(fc+(channel*6), 23, controller[3].x+(leds/2*pd+(pd/2)), controller[3].y, pd, PI/2, false);
    opc2.ledStrip(fc+(channel*6)+leds, 23, controller[3].x, controller[3].y+(leds/2*pd+(pd/2)), pd, 0, true);
    opc2.ledStrip(fc+(channel*7), 23, controller[3].x-(leds/2*pd+(pd/2)), controller[3].y, pd, PI/2, true);
    opc2.ledStrip(fc+(channel*7)+leds, 23, controller[3].x, controller[3].y-(leds/2*pd+(pd/2)), pd, 0, false);
  }
  void mirrorTest(boolean toggle, int mirrorStep) {
    /////////////////////////// TESTING MIRROR ORENTATION //////////////////
    if (toggle) {
      fill(0);
      rect(mirror[mirrorStep].x+(mirrorWidth/2), mirror[mirrorStep].y+(mirrorWidth/4), 3, mirrorWidth/2);
      rect(mirror[mirrorStep].x-(mirrorWidth/2), mirror[mirrorStep].y-(mirrorWidth/4), 3, mirrorWidth/2);
      fill(200);
      rect(mirror[mirrorStep].x+(mirrorWidth/4), mirror[mirrorStep].y+(mirrorWidth/2), mirrorWidth/2, 3);
      rect(mirror[mirrorStep].x-(mirrorWidth/4), mirror[mirrorStep].y-(mirrorWidth/2), mirrorWidth/2, 3);
      println("TESTING: "+mirrorStep);
    }
  }
  ////////////////////////////////////// BOOTH LIGHTS ///////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  void pickleBoothOPC(OPC opc) {
    int fc = 2 * 512;
    int channel = 64;       

    opc.led(fc+(channel*0), int(dig.x-5), int(dig.y));
    opc.led(fc+(channel*1), int(dig.x+5), int(dig.y));

    opc.led(fc+(channel*2), int(booth.x-5), int(booth.y));
  }

  void kingsHeadBoothOPC(OPC opc) {
    int fc = 4 * 512;
    int channel = 64;       

    opc.led(fc+(channel*3), int(dig.x-5), int(dig.y));
    opc.led(fc+(channel*2), int(dig.x+5), int(dig.y));

    opc.led(fc+(channel*1), int(booth.x-5), int(booth.y));
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//possible helper class
//class GridCoords{
//int arg1
//int arg2
//float arg3
//int xpos
//int ypos
//int pd.
// etc....
//GridCoords(_arg1,_arg2...){
//init all of them
//}
//}
//then use it like a c struct sorry if that doesn't make it make mor sense
//gridargs=new GridCoords(foo,bar,baz);
//opc.ledStrip(gridargs);
//gridargs.arg1=foo2;
//opc.ledStrip(gridargs);

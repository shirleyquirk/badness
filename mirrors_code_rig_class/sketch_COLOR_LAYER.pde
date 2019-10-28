int rigBgr, roofBgr; 
int bgList = 6;
void colorLayer(PGraphics subwindow, int index) {
  /////////////////////////////////////////////// RIG COLOR LAYERS ///////////////////////////////////////
  if (subwindow == rigColourLayer) {
    color col1 = rig.c;
    color col2 = rig.flash;

    //col1 = rig.col[rig.colorA];
    //col2 = rig.col[rig.colorB];

    oneColourBG(0, col1);
    mirrorGradientBG(1, col1, col2, 0.5);  
    sideBySideBG(2, col2, col1);
    checkBG(3, col1, col2);
    oneColourBG(4, col2);
    mirrorGradient2BG(5, col1, col2, 1);

    subwindow.beginDraw();
    subwindow.image(bg[index], subwindow.width/2, subwindow.height/2, subwindow.width, subwindow.height);
    subwindow.endDraw();
  }
/*
  if (subwindow == roofColourLayer) {
    color col1 = roof.c;
    color col2 = roof.flash;

    mirrorGradientBG(0, col1, col2, 0.5);  
    //radialGradientBG(1, roofCol1, roofCol2, 0.1);
    horizontalMirrorGradBG(2, col1, col2, 0);
    horizontalMirrorGradBG(3, col2, col1, 0.5);
    //roofArrangement(4, roofCol2, roofCol1);
    //roofBigSeeds(5, roofCol1, roofCol2);
    horizontalMirrorGradBG(6, col1, col2, 0.5);

    subwindow.beginDraw();
    subwindow.image(bg[index], subwindow.width/2, subwindow.height/2, subwindow.width, subwindow.height);
    subwindow.endDraw();
  }
  */
}
///////////////////////////// END OF BACKGROUNDS ///////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////

/// MIRROR GRADIENT BACKGROUND ///
PGraphics mirrorGradientBG(int n, color col1, color col2, float func) {
  bg[n].beginDraw();
  bg[n].background(0, 0);

  //// LEFT SIDE OF GRADIENT
  bg[n].beginShape(POLYGON); 
  bg[n].fill(col1);
  bg[n].vertex(0, 0);
  bg[n].fill(col2);
  bg[n].vertex(bg[n].width*func, 0);
  bg[n].fill(col2);
  bg[n].vertex(bg[n].width*func, bg[n].height);
  bg[n].fill(col1);
  bg[n].vertex(0, bg[n].height);
  bg[n].endShape(CLOSE);
  //// RIGHT SIDE OF bg[n]IENT
  bg[n].beginShape(POLYGON); 
  bg[n].fill(col2);
  bg[n].vertex(bg[n].width*func, 0);
  bg[n].fill(col1);
  bg[n].vertex(bg[n].width, 0);
  bg[n].fill(col1);
  bg[n].vertex(bg[n].width, bg[n].height);
  bg[n].fill(col2);
  bg[n].vertex(bg[n].width*func, bg[n].height);
  bg[n].endShape(CLOSE);
  bg[n].endDraw();
  return bg[n];
}
/// MIRROR GRADIENT BACKGROUND ///
PGraphics mirrorGradient2BG(int n, color col1, color col2, float func) {
  bg[n].beginDraw();
  bg[n].background(0);
  //////// TOP

  //// LEFT SIDE OF GRADIENT
  bg[n].beginShape(POLYGON); 
  bg[n].fill(col1);
  bg[n].vertex(0, 0);
  bg[n].fill(col2);
  bg[n].vertex(bg[n].width*func, 0);
  bg[n].fill(col2);
  bg[n].vertex(bg[n].width*func, bg[n].height/2);
  bg[n].fill(col1);
  bg[n].vertex(0, bg[n].height/2);
  bg[n].endShape(CLOSE);
  //// RIGHT SIDE OF bg[n]IENT
  bg[n].beginShape(POLYGON); 
  bg[n].fill(col2);
  bg[n].vertex(bg[n].width*func, 0);
  bg[n].fill(col1);
  bg[n].vertex(bg[n].width, 0);
  bg[n].fill(col1);
  bg[n].vertex(bg[n].width, bg[n].height/2);
  bg[n].fill(col2);
  bg[n].vertex(bg[n].width*func, bg[n].height/2);
  bg[n].endShape(CLOSE);
  bg[n].endDraw();

  func = 1-func;
  bg[n].beginDraw();
  ///// BOTTOM
  //// LEFT SIDE OF GRADIENT
  bg[n].beginShape(POLYGON); 
  bg[n].fill(col1);
  bg[n].vertex(0, bg[n].height/2);
  bg[n].fill(col2);
  bg[n].vertex(bg[n].width*func, bg[n].height);
  bg[n].fill(col2);
  bg[n].vertex(bg[n].width*func, bg[n].height);
  bg[n].fill(col1);
  bg[n].vertex(0, bg[n].height/2);
  bg[n].endShape(CLOSE);
  //// RIGHT SIDE OF bg[n]IENT
  bg[n].beginShape(POLYGON); 
  bg[n].fill(col2);
  bg[n].vertex(bg[n].width*func, bg[n].height/2);
  bg[n].fill(col1);
  bg[n].vertex(bg[n].width, bg[n].height/2);
  bg[n].fill(col1);
  bg[n].vertex(bg[n].width, bg[n].height);
  bg[n].fill(col2);
  bg[n].vertex(bg[n].width*func, bg[n].height);
  bg[n].endShape(CLOSE);

  bg[n].endDraw();
  return bg[n];
}

PGraphics horizontalMirrorGradBG(int n, color col1, color col2, float func) {
  bg[n].beginDraw();
  bg[n].background(0);
  //// TOP HALF OF GRADIENT
  bg[n].beginShape(POLYGON); 
  bg[n].fill(col2);
  bg[n].vertex(0, 0);
  bg[n].vertex(bg[n].width, 0);
  bg[n].fill(col1);
  bg[n].vertex(bg[n].width, bg[n].height*func);
  bg[n].vertex(0, bg[n].height*func);
  bg[n].endShape(CLOSE);
  //// BOTTOM HALF OF GRADIENT 
  bg[n].beginShape(POLYGON); 
  bg[n].fill(col1);
  bg[n].vertex(0, bg[n].height*func);
  bg[n].vertex(bg[n].width, bg[n].height*func);
  bg[n].fill(col2);
  bg[n].vertex(bg[n].width, bg[n].height);
  bg[n].vertex(0, bg[n].height);
  bg[n].endShape(CLOSE);
  bg[n].endDraw();
  return bg[n];
}

/// ONE COLOUR BACKGOUND ///
PGraphics oneColourBG(int n, color col1) {
  bg[n].beginDraw();
  bg[n].background(col1);
  bg[n].endDraw();
  return bg[n];
}

/// SYMETRICAL BACKGOUND ///
PGraphics checkSymmetricalBG(int n, color col1, color col2) {
  bg[n].beginDraw();
  bg[n].background(0);
  /////////////// FILL COLOR ////////////////////
  bg[n].fill(col1);
  ///////////////  BACKGROUND /////////////
  bg[n].rect(bg[n].width/2, bg[n].height/2, bg[n].width, bg[n].height);     
  ////////////////// Fill OPPOSITE COLOR //////////////
  bg[n].fill(col2);    
  bg[n].rect(grid.mirror[0].x, grid.mirror[0].y, grid.mirrorWidth, grid.mirrorWidth);
  bg[n].rect(grid.mirror[3].x, grid.mirror[3].y, grid.mirrorWidth, grid.mirrorWidth);
  bg[n].rect(grid.mirror[5].x, grid.mirror[5].y, grid.mirrorWidth, grid.mirrorWidth);
  bg[n].rect(grid.mirror[6].x, grid.mirror[6].y, grid.mirrorWidth, grid.mirrorWidth);
  bg[n].rect(grid.mirror[8].x, grid.mirror[8].y, grid.mirrorWidth, grid.mirrorWidth);
  bg[n].rect(grid.mirror[11].x, grid.mirror[11].y, grid.mirrorWidth, grid.mirrorWidth);

  bg[n].endDraw();
  return bg[n];
}

/// CHECK BACKGROUND ///
PGraphics checkBG(int n, color col1, color col2) {
  bg[n].beginDraw();
  bg[n].background(col1);
  ////////////////// Fill OPPOSITE COLOR //////////////
  bg[n].fill(col2);     
  for (int i = 0; i < grid.mirror.length/grid.rows; i+=2)  bg[n].rect(grid.mirror[i].x, grid.mirror[i].y, grid.mirrorWidth, grid.mirrorWidth);
  //for (int i = grid.columns+1; i < grid.mirror.length/grid.rows+grid.columns; i++)  bg[n].rect(grid.mirror[i].x, grid.mirror[i].y, grid.mirrorWidth, grid.mirrorWidth);
  //if(grid.rows == 3) for (int i = grid.columns*grid.rows ; i < grid.mirror.length/grid.rows+(grid.columns*2); i+=2)  bg[n].rect(grid.mirror[i].x, grid.mirror[i].y, grid.mirrorWidth, grid.mirrorWidth);
  bg[n].endDraw();

  return bg[n];
}

PGraphics cornersBG(int n, color col1, color col2) {
  bg[n].beginDraw();
  bg[n].background(0);
  /////////////// TOP RECTANGLE ////////////////////
  bg[n].fill(col2);
  bg[n].rect(bg[n].width/2, bg[n].height/2, bg[n].width, bg[n].height);     
  /////////////// BOTTOM RECTANGLE ////////////////////
  bg[n].fill(col1);                                
  bg[n].rect(grid.mirror[0].x, grid.mirror[0].y, grid.mirrorWidth, grid.mirrorWidth);
  bg[n].rect(grid.mirror[1].x, grid.mirror[1].y, grid.mirrorWidth, grid.mirrorWidth);
  bg[n].rect(grid.mirror[4].x, grid.mirror[4].y, grid.mirrorWidth, grid.mirrorWidth);

  bg[n].rect(grid.mirror[7].x, grid.mirror[7].y, grid.mirrorWidth, grid.mirrorWidth);
  bg[n].rect(grid.mirror[10].x, grid.mirror[10].y, grid.mirrorWidth, grid.mirrorWidth);
  bg[n].rect(grid.mirror[11].x, grid.mirror[11].y, grid.mirrorWidth, grid.mirrorWidth);

  bg[n].endDraw();

  return bg[n];
}
/// TOP ROW ONE COLOUR BOTTOM ROW THE OTHER BACKGORUND///
PGraphics sideBySideBG(int n, color col1, color col2) {
  bg[n].beginDraw();
  bg[n].background(0);
  /////////////// TOP RECTANGLE ////////////////////
  bg[n].fill(col2);
  bg[n].rect(bg[n].width/4, bg[n].height/2, bg[n].width/2, bg[n].height);     
  /////////////// BOTTOM RECTANGLE ////////////////////
  bg[n].fill(col1);                                
  bg[n].rect(bg[n].width/4*3, bg[n].height/2, bg[n].width/2, bg[n].height);     
  bg[n].endDraw();
  return bg[n];
}

//// top left and bottom right 3 mirror opposite colours /////
PGraphics crossBG(int n, color col1, color col2) {
  bg[n].beginDraw();
  bg[n].background(col1);
  bg[n].fill(col2);
  bg[n].rect(grid.mirror[5].x, grid.mirror[5].y, grid.mirrorAndGap*3, grid.mirrorWidth);    
  bg[n].rect(grid.mirror[6].x, grid.mirror[6].y, grid.mirrorAndGap*3, grid.mirrorWidth);    

  bg[n].endDraw();
  return bg[n];
}
PGraphics gradMirrorBG(int n, color col1, color col2) {
  bg[n].beginDraw();
  bg[n].background(col1);

  //// TOP HALF OF GRADIENT
  //bg[n].beginShape(POLYGON); 
  //bg[n].fill(col2);
  //bg[n].vertex(grid.mirror[0].x-(grid.mirrorWidth/2),grid.mirror[0].y-(grid.mirrorWidth/2));
  //bg[n].vertex(grid.mirror[0].x+(grid.mirrorWidth/2),grid.mirror[0].y+(grid.mirrorWidth/2));
  //bg[n].fill(col1);
  //bg[n].vertex(grid.mirror[0].x-(grid.mirrorWidth/2),grid.mirror[0].y+(grid.mirrorWidth/2));
  for (int i = 0; i < 6; i++) {
    bg[n].beginShape(POLYGON); 
    bg[n].fill(col1);
    bg[n].vertex(grid.mirror[i].x+(grid.mirrorWidth/2), grid.mirror[i].y-(grid.mirrorWidth/2));
    bg[n].fill(col2);
    bg[n].vertex(grid.mirror[i].x-(grid.mirrorWidth/2), grid.mirror[i].y-(grid.mirrorWidth/2));
    bg[n].vertex(grid.mirror[i].x+(grid.mirrorWidth/2), grid.mirror[i].y+(grid.mirrorWidth/2));
    bg[n].fill(col1);
    bg[n].vertex(grid.mirror[i].x+(grid.mirrorWidth/2), grid.mirror[i].y-(grid.mirrorWidth/2));
    bg[n].endShape(CLOSE);

    bg[n].beginShape(POLYGON); 
    bg[n].fill(col1);
    bg[n].vertex(grid.mirror[i].x-(grid.mirrorWidth/2), grid.mirror[i].y+(grid.mirrorWidth/2));
    bg[n].fill(col2);
    bg[n].vertex(grid.mirror[i].x-(grid.mirrorWidth/2), grid.mirror[i].y-(grid.mirrorWidth/2));
    bg[n].vertex(grid.mirror[i].x+(grid.mirrorWidth/2), grid.mirror[i].y+(grid.mirrorWidth/2));
    bg[n].fill(col1);
    bg[n].vertex(grid.mirror[i].x-(grid.mirrorWidth/2), grid.mirror[i].y+(grid.mirrorWidth/2));
    bg[n].endShape(CLOSE);
  }

  for (int i = 6; i < 12; i++) {
    bg[n].beginShape(POLYGON); 
    bg[n].fill(col1);
    bg[n].vertex(grid.mirror[i].x-(grid.mirrorWidth/2), grid.mirror[i].y-(grid.mirrorWidth/2));
    bg[n].fill(col2);
    bg[n].vertex(grid.mirror[i].x+(grid.mirrorWidth/2), grid.mirror[i].y-(grid.mirrorWidth/2));
    bg[n].vertex(grid.mirror[i].x-(grid.mirrorWidth/2), grid.mirror[i].y+(grid.mirrorWidth/2));
    bg[n].fill(col1);
    bg[n].vertex(grid.mirror[i].x-(grid.mirrorWidth/2), grid.mirror[i].y-(grid.mirrorWidth/2));
    bg[n].endShape(CLOSE);

    bg[n].beginShape(POLYGON); 
    bg[n].fill(col1);
    bg[n].vertex(grid.mirror[i].x+(grid.mirrorWidth/2), grid.mirror[i].y+(grid.mirrorWidth/2));
    bg[n].fill(col2);
    bg[n].vertex(grid.mirror[i].x+(grid.mirrorWidth/2), grid.mirror[i].y-(grid.mirrorWidth/2));
    bg[n].vertex(grid.mirror[i].x-(grid.mirrorWidth/2), grid.mirror[i].y+(grid.mirrorWidth/2));
    bg[n].fill(col1);
    bg[n].vertex(grid.mirror[i].x+(grid.mirrorWidth/2), grid.mirror[i].y+(grid.mirrorWidth/2));
    bg[n].endShape(CLOSE);
  }
  bg[n].endDraw();

  return bg[n];
}

PGraphics cansBG(int n, color col1) {
  bg[n].beginDraw();
  bg[n].background(0);

  bg[n].fill(col1);
  bg[n].rect(grid.cans[0].x, grid.cans[0].y, grid.cansLength, 3);
  bg[n].rect(grid.cans[1].x, grid.cans[1].y, grid.cansLength, 3);
  bg[n].rect(grid.cans[2].x, grid.cans[2].y, grid.cansLength, 3);

  return bg[n];
}

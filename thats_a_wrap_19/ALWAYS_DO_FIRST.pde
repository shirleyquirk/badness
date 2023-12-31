void setupSpecifics() {

  rigg.availableAnims = new int[] {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11};      // setup which anims are used on which rig here
  roof.availableAnims = rigg.availableAnims;      // setup which anims are used on which rig here - defualt is 0,1,2,3...

  cans.availableAnims = new int[] {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11};      // setup which anims are used on which rig here

  rigg.avaliableAlphaEnvelopes = new int[] {0, 1, 2, 3, 4};  

  rigg.avaliableBkgrnds = new int[] {0, 1, 2, 3, 4, 5, 6};
  roof.avaliableBkgrnds =  rigg.avaliableBkgrnds;

  cans.avaliableBkgrnds = new int[] {0, 1, 2, 3, 4, 5};

  ///////////////////////////////// UPDATE THE DROPDOWN LISTS WITH AVLIABLE OPTIONS ///////////////////////////////////////////////////////
  for (Rig rig : rigs) {
    rig.ddVizList.clear();
    rig.ddBgList.clear();
    rig.ddAlphaList.clear();
    rig.ddAlphaListB.clear();
    for (int i=0; i<rig.avaliableBkgrnds.length; i++) rig.ddBgList.addItem("background "+i, i); //add all avaliable anims to VizLists - 
    for (int i=0; i<rig.availableAnims.length; i++) rig.ddVizList.addItem("viz "+i, i); //add all avaliable anims to VizLists -
    for (int i=0; i<rig.avaliableAlphaEnvelopes.length; i++) rig.ddAlphaList.addItem("alph "+i, i); //add all avaliable anims to VizLists -
    for (int i=0; i<rig.avaliableAlphaEnvelopes.length; i++) rig.ddAlphaListB.addItem("alph "+i, i); //add all avaliable anims to VizLists -

    //need to use the actal numbers from the above aray
  }

  rigg.dimmers.put(3, new Ref(cc, 34));

  rigg.vizIndex = 2;
  roof.vizIndex = 1;
  rigg.functionIndexA = 0;
  rigg.functionIndexB = 1;
  rigg.alphaIndexA = 0;
  rigg.alphaIndexB = 1;
  rigg.bgIndex = 0;
  roof.bgIndex = 4;

  rigg.colorIndexA = 2;
  rigg.colorIndexB = 1;
  roof.colorIndexA = 1;
  roof.colorIndexB = 0;
  cans.colorIndexA = 7;
  cans.colorIndexB = 11;
  //donut.colorIndexA = 
  //donut.colorIndexB = ;

  cans.infoX += 100;


  for (int i = 0; i < cc.length; i++) cc[i]=0;   // set all midi values to 0;
  for (int i = 0; i < 100; i++) cc[i] = 1;         // set all knobs to 1 ready for shit happen
  cc[1] = 0.75;
  cc[2] = 0.75;
  cc[5] = 0.3;
  cc[6] = 0.75;
  cc[4] = 1;
  cc[8] = 1;
  cc[MASTERFXON] = 0;


  for (int i= 36; i < 52; i++)cc[i] = 0;
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////// COLOR SETUP CHOSE COLOUR VALUES ///////////////////////////////////////////////
color red, pink, yell, grin, bloo, purple, teal, orange, aqua, white, black;
color red1, pink1, yell1, grin1, bloo1, purple1, teal1, aqua1, orange1;
color red2, pink2, yell2, grin2, bloo2, purple2, teal2, aqua2, orange2;
color c, flash;
color act = #07E0D3;
color act1 = #00FC84;
color bac = #370064;
color bac1 = #4D9315;
color slider = #E07F07;
color slider1 = #E0D607;
void colorSetup() {

  colorMode(HSB, 360, 100, 100);
  white = color(0, 0, 100);
  black = color(0, 0, 0);

  float alt = 0;
  float sat = 100;
  aqua = color(150+alt, sat, 100);
  pink = color(323+alt, sat, 90);
  bloo = color(239+alt, sat, 100);
  yell = color(50+alt, sat, 100);
  grin = color(115+alt, sat, 60);
  orange = color(30+alt, sat, 90);
  purple = color(290+alt, sat, 70);
  teal = color(170+alt, sat, 60);
  red = color(7+alt, sat, 100);
  // colors that aren't affected by color swap
  float sat1 = 100;
  aqua1 = color(190+alt, 80, 100);
  pink1 = color(323-alt, sat1, 90);
  bloo1 = color(239-alt, sat1, 100);
  yell1 = color(50-alt, sat1, 100);
  grin1 = color(160-alt, sat1, 60);
  orange1 = color(34.02-alt, sat1, 90);
  purple1 = color(290-alt, sat1, 70);
  teal1 = color(170-alt, sat1, 60);
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

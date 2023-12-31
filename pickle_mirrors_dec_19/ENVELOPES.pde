////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Envelope SimplePulse(Number attack_time, Number sustain_time, Number decay_time, float attack_curv, float decay_curv) {
  int t=millis();
  // the arguments after DURATION describe a curve - first one is STARTVALUE last one is ENDVALUE - anything inbetween creates the curve ALWAYS EQUALLY SPACED
  //Envelope upramp = new Ramp( STARTTIME , DURATION , STARTVALUE , ** vlaues here create curve ** , FINALVALUE );
  // in this case - during the attack_time and the sustain time the downramp = 1
  // attack curve: 0.5 = STRAIGHT, 0 = SWOOP-UP, 1 = ARC-UP
  Envelope upramp = new Ramp(t, t+attack_time.intValue(), 0.0, attack_curv, 1.0);
  Envelope dwnrmp = new Ramp(t+attack_time.intValue()+sustain_time.intValue(), t+attack_time.intValue()+sustain_time.intValue()+decay_time.intValue(), 1.0, decay_curv, 0.1);
  return upramp.mul(dwnrmp);
}
// THIS IS A FUNCTION NOT AN ENVELOPE - it RETURNS an ENVELOPE that starts sowly going from 0 TO 1 TO 0 and getting FASTER but still with the same AMPLITUDE
Envelope SlowFast(int start_time, int duration, int start_period, int end_period) {
  // this ramp is a stright line - starting at START_PERIOD and finishing at END_PERIOD over the DURATION variable
  Envelope period = new Ramp(start_time, start_time+duration, start_period, end_period);
  // passing envelope to SINE as PERIOD
  return new Sine(1.0, period); //Using an envelope as the parameter
}
// starts OSSCILIATING with the AMPLITUDE slowly RAMPING to 0.4, ADDITIONALLY ramping to 0.6 with the top 0.2 SQUIGGLING
Envelope Squiggle(Number attack_t, Number sustain_t, Number decay_t, Number total_time, float squiggle_spd, float squiggliness ) {
  Envelope base = CrushPulse(attack_t.floatValue(), sustain_t.floatValue(), decay_t.floatValue(), total_time, 0.02, 0.02);
  int sin_start=millis()+attack_t.intValue();
  int sin_duration=sustain_t.intValue()+decay_t.intValue();
  int start_period=sin_duration;
  int end_period = sin_duration/5;
  // squiggle is always 0.4, squigglieness starts after ATTACKTIME and gets squigglier till end of SUSTAINTIME remains SQUIGGLING FOREVER
  //Envelope squiggle = SlowFast(sin_start, sin_duration, start_period, end_period).mul(new Ramp(sin_start, sin_start+sin_duration, 0.0, sqiggle_curv, squiggliness));
  Envelope squiggle = new Sine(1, squiggle_spd*500).mul(new Ramp(sin_start, sin_start+sin_duration, 0.0, 0.02, squiggliness)).add(1-squiggliness);
  return base.mul(squiggle);
}
Envelope SineBySine(float amplitude, int period, float amplitude1, int period1) {
  Envelope firstSine = new Sine(amplitude, period);
  return firstSine.mul(new Sine(amplitude1, period1));
}


Envelope PullDown(int attack_time, int sustain_time, int decay_time, float attack_curv, float decay_curv, float effect_value) {
  int t=millis();
  //Envelope upramp = new Ramp( STARTTIME , DURATION , STARTVALUE , ** vlaues here create curve ** , FINALVALUE );
  // attack curve: 0.5 = STRAIGHT, 0 = SWOOP-UP, 1 = ARC-UP
  Envelope downramp = new Ramp(t, t+attack_time, 1.0, attack_curv, effect_value);
  Envelope upramp = new Ramp(t+attack_time+sustain_time, t+attack_time+sustain_time+decay_time, effect_value, attack_curv, 1.0);
  return downramp.mul(upramp);
}

Envelope BlackOut(int attack_time, float attack_curv) {
  int t=millis();
  return new Ramp(t, t+attack_time, 1.0, attack_curv, 0);
}
Envelope NoizeEnv() {
  Envelope perl = new Perlin(new Linear(0.1*0.0001), 0.01, new Linear(0.0001));
  return perl.add(-0.4).mul(10).sin01();
}

//Envelope Beats(Number total_time,float decay_curv){


// return  
//}
// WRITE FUNCTION THAT CRUSHES RATE OF ALL ENVELOPES

Envelope CrushPulse(float attack_proportion, float sustain_proportion, float decay_proportion, Number total_time, float attack_curv, float decay_curv) {
  if (attack_proportion<0) attack_proportion=0;
  if (sustain_proportion<0) sustain_proportion=0;
  if (decay_proportion<0) decay_proportion=0;
  float total_prop = attack_proportion+sustain_proportion+decay_proportion;
  float attack_time = attack_proportion/total_prop*total_time.floatValue();
  float sustain_time = sustain_proportion/total_prop*total_time.floatValue();
  float decay_time = decay_proportion/total_prop*total_time.floatValue();
  return SimplePulse(attack_time, sustain_time, decay_time, attack_curv, decay_curv);
}



/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Envelope envelopeFactory(int envelope_index, Rig rig) {
  switch (envelope_index) {
  case 0: 
    // BEATZ
    return CrushPulse(0.031, 0.040, 0.913, avgmillis*rig.alphaRate*15+0.5, 0.0, 0.0);
  case 1:
    // PULZ
    return CrushPulse(0.92, 0.055, 0.071, avgmillis*rig.alphaRate*10+0.5, 0.0, 0);
  case 2:
    // BEAT CONROLLED BY PAD
    return CrushPulse(cc[41], cc[42], cc[43], avgmillis*rig.alphaRate*15+0.5, 0.0, 0.0);
  case 3:
    // PULZ CONTROLLED BY PAD
    return CrushPulse(cc[49], cc[50], cc[51], avgmillis*rig.alphaRate*10+0.5, 0.0, 0.0);
  case 4:
    // SQUIGGLE (BEATS) CONTROLLED BY PAD 
    return Squiggle(cc[41], cc[42], cc[43], avgmillis*rig.alphaRate*15+0.5, 0.01+cc[44], cc[45]);
  case 5:
    // SQUIGGLE (PULZ) CONTROLLED BY PAD 
    return Squiggle(cc[49], cc[50], cc[51], avgmillis*rig.alphaRate*10+0.5, 0.01+cc[52], cc[53]);
  case 6:
    // STUTTER
    return CrushPulse(0.031, 0.040, 0.913, avgmillis*rig.alphaRate*15+0.5, 0.0, 0.0).mul(stutter);
  default: 
    return CrushPulse(0.031, 0.040, 0.913, avgmillis*rig.alphaRate*15+0.5, 0.02, 0.02);
  }
}

Envelope functionEnvelopeFactory(int envelope_index, Rig rig) {
  switch (envelope_index) {
  case 0: 
    //return SimplePulse(cc[41]*4000, cc[42]*4000, cc[43]*4000, cc[44], cc[45]);
    return CrushPulse(0.031, 0.040, 0.913, avgmillis*rig.funcRate*15+0.5, 0.02, 0.02);
  case 1:
    //return CrushPulse(cc[49], cc[50], cc[51], avgmillis*rig.beatSlider*15+0.5, cc[52], cc[53]);
    return CrushPulse(0.92, 0.055, 0.071, avgmillis*rig.funcRate*15+0.5, 0.118, 0);
  case 2:
    return CrushPulse(cc[41], cc[42], cc[43], avgmillis*rig.funcRate*15+0.5, 0.02, 0.02);
  case 3:
    return CrushPulse(cc[44], cc[45], cc[46], avgmillis*rig.funcRate*15+0.5, 0.02, 0.02);
  case 4:
    //Envelope Squiggle(Number attack_t, Number sustain_t, Number decay_t, float attack_curv, float decay_curv, float sqiggle_curv, float squiggliness, int squiggle_spd) {
    return Squiggle(cc[49], cc[50], cc[51], avgmillis*rig.funcRate*15+0.5, 0.01+cc[52], cc[53]);
  default: 
    return CrushPulse(0.031, 0.040, 0.913, avgmillis*rig.funcRate*15+0.5, 0.02, 0.02);
  }
}

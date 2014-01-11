import 'dart:typed_data';

class MersenneTwister {
  Uint32List mt = new Uint32List(624);
  int idx;
  
  MersenneTwister(int seed) {
    idx = 0;
    mt.fillRange(0, mt.length-1, 0);
    mt[0] = seed;
    for(int i = 1; i != mt.length; i++) {
      mt[i] = (1812433253 * (mt[i-1] ^ (mt[i-1] >> 30)) + i) 
          & 0xffffffff;
    }
  }
  
  int extractNumber() {
    if(idx == 0) { generateNumbers(); }
    int y = mt[idx];
    y ^= y >> 11;
    y ^= (y << 7) & 2636928640;
    y ^= (y << 15) & 4022730752;
    y ^= y >> 18;

    idx = (idx + 1) % mt.length;
    return y;
  }
 
  void generateNumbers() {
    for(int i = 0; i < mt.length; i++) {
      int y = (mt[i] & 0x80000000) + (mt[(i + 1 ) % 624] & 0x7fffffff);
      mt[i] = mt[(i + 397) % 624] ^ (y >> 1);
      if(y % 2 != 0) { mt[i] ^= 2567483615; }; 
    }
  }
}
library mersenne_twister;

import 'dart:typed_data';
import 'dart:math' as math;

import 'package:fixnum/fixnum.dart'; // quick and dirty fix for dart2js

/**
 * 32 bit Mersenne Twister implementation
 */
class MersenneTwister implements math.Random {
  Uint32List _mt = new Uint32List(624);
  int _idx;
  
  /**
   * Creates Mersenne Twistter PRNG with defined [seed]
   */
  MersenneTwister(int seed) {
    _idx = 0;
    _mt.fillRange(0, _mt.length-1, 0);
    _mt[0] = seed;
    
    for(int i = 1; i != _mt.length; i++) {
      int s = _mt[i-1] ^ (new Int32(_mt[i-1]) >> 30).toUnsigned(2).toInt();
      int ui = ((new Int32(1812433253) * new Int32(s)).toInt() & 0xffffffff);
      
      _mt[i] = (ui + i).toInt() & 0xffffffff;
    }
  }
  
  /**
   * Generates a random boolean value.
   */
  bool nextBool() => 
      extractNumber() % 2 == 1;
  
  /**
   * Generates a positive random integer uniformly distributed on the range
   * from 0, inclusive, to [max], exclusive.
   * 
   * Supports [max] values between 1 and ((1<<32) - 1) inclusive.
   */
  int nextInt(int max) => 
      (extractNumber() / ((1<<32) - 1) * max).truncate();
  
  /**
   * Not implemented yet
   */
  double nextDouble() => 
      throw('Not implemented yet');
  
  /**
   * Generates unsigned 32 bit integer
   */
  int extractNumber() {
    if(_idx == 0) { _generateNumbers(); }
    int y = _mt[_idx];
    y ^= y >> 11;
    y ^= (y << 7) & 2636928640;
    y ^= (y << 15) & 4022730752;
    y ^= y >> 18;

    _idx = (_idx + 1) % _mt.length;
    return y;
  }
 
  void _generateNumbers() {
    for(int i = 0; i < _mt.length; i++) {
      int y = (_mt[i] & 0x80000000) + (_mt[(i + 1 ) % 624] & 0x7fffffff);
      _mt[i] = _mt[(i + 397) % 624] ^ (y >> 1);
      if(y % 2 != 0) { _mt[i] ^= 2567483615; }; 
    }
  }
}
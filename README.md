Mersenne Twister
================

[![Build Status](https://drone.io/github.com/analogic/mersenne_twister/status.png)](https://drone.io/github.com/analogic/mersenne_twister/latest)

Dart implementation of 32 bit Mersenne twister PRNG (MT19937). It is tested against output from other implementation.

Usage
-----

```Dart
	import 'package:mersenne_twister/mersenne_twister.dart';
	
	int seed = 1;
	var mt = new MersenneTwister(seed);
	
	print(mt.extractNumber());
	
```

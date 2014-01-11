Mersenne Twister
================

Dart implementation of 32 bit Mersenne twister PRNG (MT19937). Its tested against output

Usage
-----

```Dart
	import 'package:mersenne_twister/mersenne_twister.dart';
	
	int seed = 1;
	var mt = new MersenneTwister(seed);
	
	print(mt.extractNumber());
	
```
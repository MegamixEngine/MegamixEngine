/// random_get_seed_safe

/*
For GMS (or at least, 1.4.1804 and 1.4.9999), random_get_seed and random_set_seed aren't properly implemented.
Setting a seed to a specific value *will* have randomization return consistent values.
However the value *provided* by random_get_seed will not be consistent with the values used when setting the seed to that same value.
Because of this, generally using random_get/set_seed cannot be depended on to "preserve" the current seed value on the fly.

This mainly causes a problem with replays, since then replays can get desynced if the seed is changed on-the-fly.

For Megamix 2.0 I *hope* to have a complete workaround for this (and if we haven't by release open up an issue for it).

For MaGMML3 though, the best I can do is get the next random value in the *current* seed as the new seed.

(Note: One exception to this is endless control objects, but recording isn't a good idea there given it can be, well, endless. It *might* work unsafe, but I'm not sure)


*/
return random_range(-3.402823 * 10^38,3.402823 * 10^38);

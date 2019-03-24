/// chronoGet()
/// returns time in seconds since the last call to chronoReset().
/// Time granularity is milliseconds or smaller.
/// Because the precision varies between computers, this should
/// only be used for profiling or debugging.

return external_call(global._chronoGet);

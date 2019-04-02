/// chronoReset()
/// restarts the timer. 
/// because GMS uses 32-bit floating point precision,
/// it's important to call this function for comparison
/// rather than taking the difference of two calls to chronoGet().

return external_call(global._chronoReset);

/// ceil_to(x, q)
// returns x rounded to the nearest multiple of q no lesser than x
// even works for floating point arithmetic

// limiting behaviour near zero:
if (argument1 == 0)
{
    return argument0;
}

// standard behaviour:
return ceil(argument0 / argument1) * argument1;

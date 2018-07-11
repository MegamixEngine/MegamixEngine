/// floor_to(x, q)
// returns x rounded to the nearest multiple of q no greater than x
// even works for floating point arithmetic

// limiting behaviour near zero:
if (argument1 == 0)
{
    return argument0;
}

// standard behaviour:
return floor(argument0 / argument1) * argument1;

/// roundTo(x, d)
// returns x rounded to the nearest multiple of d
// even works for floating point arithmetic

// limiting behaviour near 0:
if (argument1 == 0)
{
    return argument0;
}

// standard behaviour
return round(argument0 / argument1) * argument1;

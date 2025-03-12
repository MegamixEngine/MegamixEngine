/// calibrateDirection([object])
// if no argument provided, callibrates toward
// the "target" variable (set in enemies and gimmicks)

var _targ;
if (argument_count > 0)
{
    _targ = argument[0];
}
else
{
    _targ = target;
}

if (instance_exists(_targ))
{
    var aimDir = _targ.x-x;
    if(aimDir!=0 && (sign(aimDir)!= sign(image_xscale)))
    {
        image_xscale*=-1;
    }
}

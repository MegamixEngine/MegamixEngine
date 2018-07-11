/// xSpeedAim(originX, originY, targetX, targetY, [ySpeed], [accel], [speedLimit])
// This script returns a speed set to the appropriate amount to aim at the location specified with the given information
// argument0 - x coordinate of where to aim from
// argument1 - y coordinate of where to aim from
// argument2 - x coordinate of the point to aim at
// argument3 - y coordinate of the point to aim at
// argument4 - this object's initial yspeed (default: yspeed of the object that called this script)
// argument5 - gravitationalAcceleration (default: grav of the object that called this script)
// argument6 - cap for how fast a value this script can return (optional) (positive numbers only) (set it to -1 to have no speed limit)

var _originX = argument[0];
var _originY = argument[1];
var _targetX = argument[2];
var _targetY = argument[3];
var _ySpd = 0;
var _accel = 0;
var _speedLimit = 8; // <-- default speed limit here

if (argument_count > 4)
{
    _ySpd = argument[4];
}
else
{
    _ySpd = yspeed;
}

if (argument_count > 5)
{
    _accel = argument[5];
}
else
{
    _accel = grav;
}

if (argument_count > 6)
{
    _speedLimit = argument[6];
}

if (_ySpd != 0 && _accel != 0)
{
    // figure out how far up we can go
    var airTime = (0 - _ySpd) / _accel;
    
    if (airTime < 0)
    {
        airTime = 0;
    }
    
    var maxYDelta = _ySpd * airTime + 0.5 * _accel * power(airTime, 2);
    
    // figure out how high we need to go
    var yDelta = _targetY - _originY;
    
    // check to see if the object's y is too high to hit
    if ((maxYDelta < 0 && yDelta < maxYDelta)
        || (maxYDelta > 0 && yDelta > maxYDelta))
    {
        // pretend the object is just in our reach
        if (maxYDelta < 0)
        {
            yDelta = maxYDelta + 1;
        }
        else
        {
            yDelta = maxYDelta - 1;
        }
    }
    
    var radical = power(_ySpd, 2) - 4 * (_accel / 2) * (-yDelta);
    
    if (radical <= 0)
    {
        // if nonsense somehow, than quit
        show_debug_message("nonsense radical in xSpeedAim script");
        return 0;
    }
    
    // figure out time it'll take for the projetile's y to reach the same as the target
    airTime = (-_ySpd + sqrt(radical)) / _accel;
    
    // if the answer given is nonsense, then try subtracting the quadratic instead of adding
    if (airTime <= 0)
    {
        airTime = (-_ySpd - sqrt(radical)) / _accel;
        
        // if still nonsense somehow, then quit
        if (airTime <= 0)
        {
            show_debug_message("nonsense airtime in xSpeedAim script");
            return 0;
        }
    }
    
    // calculate speed needed to reach target in the given time with the given distance
    var xDelta = _targetX - _originX;
    var newXSpeed = xDelta / airTime;
    
    // enforce speed limit
    if (_speedLimit != -1 && (newXSpeed > _speedLimit || newXSpeed < -_speedLimit))
    {
        if (newXSpeed > 0)
        {
            newXSpeed = _speedLimit;
        }
        else
        {
            newXSpeed = -_speedLimit;
        }
    }
    
    return newXSpeed;
}
else
{
    return 0;
}

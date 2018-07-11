/// ySpeedAim(originY, targetY, gravity, [speedLimit])
/* This script does something different than xSpeedAim. It returns a speed set to the value needed to exactly reach a
certain height with the given values */

// argument0 - y position to aim from
// argument1 - y position to reach
// argument2 - gravitationalAcceleration
// argument3 - cap for how fast a value this script can return (optional) (set it to -1 to have no speed limit)

_originY = argument[0];
_targetY = argument[1];
_accel = argument[2];
_speedLimit = 10; // default speed limit

if (argument_count > 3)
{
    _speedLimit = argument[3];
}

// save direction we're going so it can be applied after square rooting
dir = 0;
if (_accel > 0)
{
    dir = -1;
}
else
{
    dir = 1;
}

// if what we're going is behind where we're jumping at, then jump a default height
if ((dir < 0 && _targetY > _originY) || (dir > 0 && _targetY < _originY))
{
    _targetY = _originY + 24 * dir;
}

// calculate
_accel = abs(_accel);

substitution = 2 * _accel * abs(_targetY - _originY);

if (substitution <= 0)
{
    // if nonsense, than quit
    return 0;
}

newYSpeed = sqrt(substitution) * dir;

// enforce speed limit
if (_speedLimit != -1 && (newYSpeed > _speedLimit || newYSpeed < -_speedLimit))
{
    if (newYSpeed > 0)
    {
        newYSpeed = _speedLimit;
    }
    else
    {
        newYSpeed = -_speedLimit;
    }
}

return newYSpeed;

/// correctDirection(targetAngle, turnSpeed)
var _dir, _speed, _cor;
_dir = argument0;
_speed = argument1;
_cor = 0;

if (_dir >= direction)
{
    if (abs(_dir - direction) >= abs((360 - _dir) + direction))
    {
        _cor = -1;
    }
    else
    {
        _cor = 1;
    }
}
else
{
    if (abs(direction - _dir) >= abs((360 - direction) + _dir))
    {
        _cor = 1;
    }
    else
    {
        _cor = -1;
    }
}

repeat (_speed)
{
    if (_dir != direction)
    {
        direction += _cor;
    }
    else
    {
        break;
    }
}

/// shiftObject(delta-x, delta-y, checkforcollision)
var _xsub, _ysub, _id;

_xsub = xspeed;
_ysub = yspeed;

xspeed = argument0;
yspeed = argument1;

xprevious = x;
yprevious = y;

if (argument2)
{
    sinkin -= 1;
    generalCollision();
    sinkin += 1;
}
else
{
    x += xspeed;
    y += yspeed;
}

entityPlatform();

xspeed = _xsub;
yspeed = _ysub;

/// moveTowardPoint(targetX, targetY, speed)
// sets xspeed, yspeed to bring this entity to the given target coordinates.
// returns true if already at those coordinates.

var targetX = argument0;
var targetY = argument1;
var moveSpeed = argument2;

// cap speed if near target
moveSpeed = min(moveSpeed, point_distance(x, y, targetX, targetY));

var deltaX = targetX - x;
var deltaY = targetY - y;
if (deltaX == 0 && deltaY == 0)
{
    xspeed = 0;
    yspeed = 0;
    return true;
}

var norm = sqrt(deltaX * deltaX + deltaY * deltaY);
xspeed = deltaX * moveSpeed / norm;
yspeed = deltaY * moveSpeed / norm;

return false;

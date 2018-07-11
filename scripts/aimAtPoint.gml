/// aimAtPoint(speed,x,y)
// argument0 - speed to use
// argument1 - x to aim at
// argument2 - y to aim at


var angle;
angle = point_direction(spriteGetXCenter(), spriteGetYCenter(),
    argument1,
    argument2);

xspeed = cos(degtorad(angle)) * argument0;
yspeed = -sin(degtorad(angle)) * argument0;

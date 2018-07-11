/// aimAtObject(speed,object id)
// argument0 - speed to use
// argument1 - id of object to aim at

if (instance_exists(argument1))
{
    var angle;
    angle = point_direction(spriteGetXCenter(), spriteGetYCenter(),
        spriteGetXCenterObject(argument1),
        spriteGetYCenterObject(argument1));
    
    xspeed = cos(degtorad(angle)) * argument0;
    yspeed = -sin(degtorad(angle)) * argument0;
}
else
{
    xspeed = argument0;
    yspeed = 0;
}

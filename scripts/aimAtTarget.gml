/// aimAtTarget(speed)
// argument0 - speed to use

if (instance_exists(target))
{
    var angle;
    angle = point_direction(spriteGetXCenter(), spriteGetYCenter(),
        spriteGetXCenterObject(target),
        spriteGetYCenterObject(target));
    
    xspeed = cos(degtorad(angle)) * argument0;
    yspeed = -sin(degtorad(angle)) * argument0;
}
else
{
    xspeed = argument0;
    yspeed = 0;
}

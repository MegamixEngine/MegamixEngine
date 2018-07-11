/// entityHandleIced()
/// part of normal update step,
/// handles special status effect physics for ice

if (iceTimer > 0)
{
    iceTimer -= 1;
    doesTransition = false;
    image_speed = 0;
    
    // special physics while iced:
    if (icePhysics)
    {
        // xspeed friction:
        var fric = 0.75;
        if (!ground)
            fric = 0.1;
        if (abs(xspeed) > fric)
            xspeed -= fric * sign(xspeed);
        else
            xspeed = 0;
    }
    else
    {
        // no ice physics
        xspeed = 0;
        yspeed = 0;
        grav = 0;
        blockCollision = false;
    }
    
    // become solid if required (except if in air or player intersecting)
    if (!isSolid && !place_meeting(x, y, objMegaman) && ground)
        isSolid = iceSolid;
    
    // ice effect ends -- reset variables
    if (iceTimer == 0)
    {
        yspeed = yspeedPreIce;
        xspeed = xspeedPreIce;
        grav = gravPreIce;
        blockCollision = blockCollisionPreIce;
        image_speed = imageSpeedPreIce;
        isSolid = solidPreIce;
        doesTransition = doesTransitionPreIce;
    }
}

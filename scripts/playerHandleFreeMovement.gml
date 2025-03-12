/// playerHandleFreeMovement();
// Free movement debug
if (!DEBUG_ENABLED)
{
    exit;
}
if (global.freeMovement)
{
    // flicker
    //visible = !visible;
    
    if (global.roomTimer % 4 == 0)
    {
        with (instance_create(x+irandom_range(-16,16),y+irandom_range(-16,16),objSlideDust))
        {
            sprite_index = sprFlashTwinkle;
            alarm[0] = ((1 / image_speed) * image_number) - 2;
        }
    }
    
    xspeed = 0;
    yspeed = 0;
    
    climbing = false;
    climbLock = lockPoolRelease(climbLock);
    isSlide = false;
    slideLock = lockPoolRelease(slideLock);
    
    iFrames = -1;
    blockCollision = 0;
    
    if (!inWater)
        y -= grav;
    else
        y -= (grav * waterAccelMod);
    
    // Movement
    var debugSpd = 2 + (2 * global.keyShoot[playerID]) + (6 * global.keySlide[playerID]);
    
    if (global.keyUp[playerID])
    {
        y -= debugSpd;
    }
    else if (global.keyDown[playerID])
    {
        y += debugSpd;
    }
    
    if (global.keyLeft[playerID])
    {
        x -= debugSpd / 2;
    }
    else if (global.keyRight[playerID])
    {
        x += debugSpd / 2;
    }
}

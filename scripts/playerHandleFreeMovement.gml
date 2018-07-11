/// playerHandleFreeMovement();
// Free movement debug
if (global.freeMovement)
{
    // flicker
    visible = !visible;
    
    xspeed = 0;
    yspeed = 0;
    
    climbing = false;
    climbLock = lockPoolRelease(climbLock);
    isSlide = false;
    slideLock = lockPoolRelease(slideLock);
    
    iFrames = -1;
    blockCollision = 0;
    y -= grav;
    
    // Movement
    if (global.keyUp[playerID])
    {
        y -= (2 + (2 * global.keyShoot[playerID]));
    }
    else if (global.keyDown[playerID])
    {
        y += (2 + (2 * global.keyShoot[playerID]));
    }
    
    if (global.keyLeft[playerID])
    {
        x -= (1 + (1 * global.keyShoot[playerID]));
    }
    else if (global.keyRight[playerID])
    {
        x += (1 + (1 * global.keyShoot[playerID]));
    }
    
    // Animation debug //
    
    // Horizontal
    if (keyboard_check_pressed(ord('A')))
    {
        playSFX(sfxWeaponSwitch);
        
        spriteX -= 1;
        
        if (spriteX < 0)
        {
            spriteX = 17;
        }
    }
    
    if (keyboard_check_pressed(ord('D')))
    {
        playSFX(sfxWeaponSwitch);
        
        spriteX += 1;
        
        if (spriteX > 17)
        {
            spriteX = 0;
        }
    }
    
    // Vertical
    if (keyboard_check_pressed(ord('W')))
    {
        playSFX(sfxWeaponSwitch);
        
        spriteY -= 1;
        
        if (spriteY < 0)
        {
            spriteY = 12;
        }
    }
    
    if (keyboard_check_pressed(ord('S')))
    {
        playSFX(sfxWeaponSwitch);
        
        spriteY += 1;
        
        if (spriteY > 12)
        {
            spriteY = 0;
        }
    }
}

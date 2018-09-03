/// playerHandleSliding();
// Sliding

if (global.enableSlide && !playerIsLocked(PL_LOCK_SLIDE))
{
    var statusSliding = true;
    if (instance_exists(statusObject))
    {
        statusSliding = statusObject.statusCanSlide;
    }
    
    var keyPressed = global.keySlidePressed[playerID] || (global.keyJumpPressed[playerID] && yDir == gravDir);
    
    // begin new slide
    if (ground && !isSlide && statusSliding && keyPressed)
    {
        shootStandStillLock = lockPoolRelease(shootStandStillLock);
        
        // check to see that the place is free for sliding
        premask = mask_index;
        mask_index = firstSlideMask;
        var goForth = !checkSolid(image_xscale, 0);
        mask_index = premask;
        
        if (goForth)
        {
            premask = mask_index;
            mask_index = firstSlideMask;
            
            isSlide = true;
            slideTimer = 0;
            
            slideLock = lockPoolLock(localPlayerLock[PL_LOCK_MOVE],
                localPlayerLock[PL_LOCK_TURN],
                localPlayerLock[PL_LOCK_JUMP],
                localPlayerLock[PL_LOCK_SHOOT]);
            
            // create slide dust particles
            with (instance_create(x + (abs(x - bbox_right) - 2) * sign(image_xscale), y + (abs(y - bbox_bottom) - 2) * sign(image_yscale), objSlideDust))
            {
                image_xscale = other.image_xscale;
            }
            
            xspeed = slideSpeed * image_xscale;
        }
    }
    
    if (isSlide) // While sliding
    {
        slideTimer += 1;
        
        // prevent charging while sliding
        if (chargeTimer == 0 && !slideChargeLock)
        {
            slideChargeLock = lockPoolLock(localPlayerLock[PL_LOCK_CHARGE]);
        }
        
        var canProceed = true;
        var isfree = true;
        var jump = global.keyJumpPressed[playerID] && yDir != gravDir /*&& !playerIsLocked(PL_LOCK_JUMP )*/ ;
        
        if (image_xscale == -xDir || slideTimer >= slideFrames || jump)
        {
            canProceed = false;
        }
        
        // Check if Mega Man would get stuck inside something if he would stop the slide now
        var prepremask = mask_index;
        
        // mask_index = premask;
        if (checkSolid(0, -gravDir * 8))
        {
            isfree = false;
        }
        
        // mask_index = prepremask;
        
        // Collided with a wall?
        if (xspeed == 0)
        {
            canProceed = false;
            if (!ground)
            {
                isfree = true;
            }
        }
        
        // Check if Mega Man would be grounded when having the extended sliding mask
        // ground = true;
        // checkGround();
        if (!ground)
        {
            if (yspeed * gravDir > 0)
            {
                shiftObject(0, -yspeed, 1);
                yspeed = 0;
            }
            
            mask_index = secondSlideMask;
            ground = true;
            checkGround();
            
            if (!ground)
            {
                canProceed = false;
                isfree = true;
            }
            
            mask_index = prepremask;
        }
        
        playLandSound = 0;
        
        if (!canProceed && isfree) // Stop sliding
        {
            isSlide = false;
            slideLock = lockPoolRelease(slideLock);
            slideChargeLock = lockPoolRelease(slideChargeLock);
            slideTimer = 0;
            
            ground = true;
            checkGround();
            
            mask_index = premask;
            if (!ground) // Pushing down until not inside a ceiling anymore
            {
                dieToSpikes = 0;
                shiftObject(0, -gravDir, 1);
                dieToSpikes = 1;
            }
            
            xspeed = (ground && ((instance_exists(statusObject) && statusObject.statusOnIce)
                || place_meeting(x, y + gravDir, objIce))) * slideSpeed * image_xscale * 0.5;
            
            if (jump)
            {
                playerJump();
                if dashSlide
                {
                    dashJumped = true;
                }
            }
        }
        else // forced to slide because not free
        {
            if (xDir != 0)
            {
                image_xscale = xDir;
            }
            
            xspeed = slideSpeed * image_xscale * (!isHit);
        }
    }
}

if (!isSlide)
{
    slideChargeLock = lockPoolRelease(slideChargeLock);
}

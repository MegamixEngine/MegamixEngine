/// playerHandleSliding();
// Sliding

var jumpMax = jumpCounterMax + (checkCheats(cheatEnums.doubleJump));

if (global.enableSlide && !playerIsLocked(PL_LOCK_SLIDE))
{
    var statusSliding = true;
    if (instance_exists(statusObject))
    {
        statusSliding = statusObject.statusCanSlide;
    }
    
    var keyPressed = global.keySlidePressed[playerID] || (global.keyJumpPressed[playerID] && yDir == gravDir && global.downJumpSlide);
    if (checkCheats(cheatEnums.holdSlide))
    {
        keyPressed = (global.keySlide[playerID] || (global.keyJump[playerID] && yDir == gravDir && global.downJumpSlide));
    }
    
    var sDir = 1;
    if (checkCheats(cheatEnums.moonwalk))
    {
        sDir = -1;
        //xDir *= -1;
    }
    // begin new slide
    if ((ground || (checkCheats(cheatEnums.airSliding) && jumpCounter <= 1 && !airDashed)) && !isSlide && statusSliding && keyPressed)
    {
        shootStandStillLock = lockPoolRelease(shootStandStillLock);
        
        // check to see that the place is free for sliding
        premask = mask_index;
        mask_index = firstSlideMask;
        var goForth = !checkSolid(image_xscale*sDir, 0);
        mask_index = premask;
        
        if (goForth)
        {
            premask = mask_index;
            mask_index = firstSlideMask;
            ground=true;
            checkGround();
            shiftObject(0,-gravDir,0);
            
            isSlide = true;
            
            if (getGenericSFX(SFX_SLIDE) >= 0)
            {
                playSFX(getGenericSFX(SFX_SLIDE));
            }
            if (global.characterSelected[playerID] == CHAR_BASS)
            {
                spriteLoopID = 0;
                dashJumped = true; //Failsafe but also needed for air slide mode.
            }
            if (checkCheats(cheatEnums.airSliding) && !ground)
            {
                airDashed = true;
                yspeed = 0;
            }
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
            
            xspeed = slideSpeed * image_xscale*sDir;
            
        }
    }
    
    if (isSlide) // While sliding
    {
        slideTimer ++;
        
        // prevent charging while sliding
        if (chargeTimer == 0 && !slideChargeLock)
        {
            slideChargeLock = lockPoolLock(localPlayerLock[PL_LOCK_CHARGE]);
        }
        
        var canProceed = true;
        var isfree = true;
        var jump = global.keyJumpPressed[playerID] && (yDir != gravDir || !global.downJumpSlide || (global.characterSelected[playerID] == CHAR_BASS && slideTimer != 1)) /*&& !playerIsLocked(PL_LOCK_JUMP )*/ ;
        var jumpCancel = global.keyJumpPressed[playerID] && (yDir != gravDir || !global.downJumpSlide || (global.characterSelected[playerID] == CHAR_BASS && jumpCounter <= 1))//Needed for Bass mode.
        if (checkCheats(cheatEnums.airSliding))
        {
            jump = jump && (!airDashed || jumpCounter < jumpMax);
            jumpCancel = jump && (!airDashed || jumpCounter < jumpMax);
        }
        if (image_xscale == -xDir || slideTimer >= slideFrames || jump)
        {
            canProceed = false;
        }
        
        // Check if Mega Man would get stuck inside something if he would stop the slide now
        var prepremask = mask_index;
        
        // mask_index = premask;
        var preDSpikes = dieToSpikes;
        dieToSpikes = false;
        
        var useCheck = checkSolid(0, -gravDir * 8);
        if (checkCheats(cheatEnums.airSliding))
        {
            useCheck = ((checkSolid(0, -gravDir * 8) && (ground || (!ground && checkSolid(0, gravDir * 8)))));
        }
        
        if (useCheck)
        {
            isfree = false;
        }
        dieToSpikes = preDSpikes;
        
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
        
        /*// Check if Mega Man would be grounded when having the extended sliding mask
        ground = true;
        checkGround();
        */
        
        if (checkCheats(cheatEnums.holdSlide) && !jumpCancel && (global.keySlide[playerID] || (global.keyJump[playerID] && yDir == gravDir)))
            canProceed = true;
        
        if (!ground)
        {
            if (yspeed * gravDir > 0)
            {
                shiftObject(0, -yspeed, 1);
                yspeed = 0;
            }
            
            mask_index = secondSlideMask;
            //shiftObject(0,-gravDir,1);
            ground = true;
            checkGround();
            
            if (!ground && (!checkCheats(cheatEnums.airSliding)))
            {
                canProceed = false;
                isfree = true;
                if (global.characterSelected[playerID] == CHAR_BASS)
                {
                    dashJumped = true;
                }
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
            mask_index = premask;
            shiftObject(0,-gravDir,1);

            checkGround();
            
            // blast wind bugfix
            if (global.blastWind && isHit)
            {
                isHit = false;
                hitTimer = 0;
                iFrames = 75;
                hitLock = lockPoolRelease(hitLock);
            }
            
            if (!ground) // Pushing down until not inside a ceiling anymore
            {
                dieToSpikes = 0;
                shiftObject(0, -gravDir, 1);
                dieToSpikes = preDSpikes;
            }

            xspeed = (ground && ((instance_exists(statusObject) && statusObject.statusOnIce)
                || place_meeting(x, y + gravDir, objIce) || checkCheats(cheatEnums.permaIcePhysics))) * slideSpeed * image_xscale * 0.5*sDir;
            
            if (jump && (global.characterSelected[playerID] != CHAR_BASS || (global.characterSelected[playerID] == CHAR_BASS && jumpCancel)))
            {
                var ogGround = ground;
                playerJump((checkCheats(cheatEnums.doubleJump)) && checkCheats(cheatEnums.airSliding) && !ground); //this gets incremented twice somehow so it cant increase jumpCounter
                if (checkCheats(cheatEnums.airSliding) && !ogGround)
                {
                    dashJumped = false;
                }
                else if dashSlide
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
            
            xspeed = slideSpeed * image_xscale * sDir * (!isHit || global.blastWind);
        }
    }
}

if (!isSlide)
{
    slideChargeLock = lockPoolRelease(slideChargeLock);
}

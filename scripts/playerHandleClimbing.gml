/// playerHandleClimbing();

var ladder = collision_line(bboxGetXCenter(), bbox_top + 2, bboxGetXCenter(), bbox_bottom, objLadder, false, false);

var ladderDown = instance_position(spriteGetXCenter(), ((bbox_top * (gravDir < 0)) + (bbox_bottom * (gravDir > 0))) + gravDir, objLadder);

if (!playerIsLocked(PL_LOCK_CLIMB))
{
    if (((instance_exists(ladder) && gravDir == -yDir)
        || (instance_exists(ladderDown) && gravDir == yDir && ground))
        && !climbing)
    {
        // begin climbing:
        xspeed = 0;
        
        if (isSlide)
        {
            slideLock = lockPoolRelease(slideLock);
            isSlide = false;
            mask_index = mskMegaman;
            slideTimer = 0;
            shiftObject(0, -gravDir, 1);
        }
        
        climbing = true;
        
        if (instance_exists(ladder))
        {
            shiftObject((ladder.x + 8) - x, 0, true);
            if (x != ladder.x + 8)
            {
                climbing = false;
            }
        }
        else
        {
            // this could potentially cause us to phase into a solid
            // if one overlapped the ladder. :/
            x = ladderDown.x + 8;
            y += climbSpeed * gravDir;
        }
        
        if (climbing)
        {
            climbLock = lockPoolLock(localPlayerLock[PL_LOCK_MOVE],
                localPlayerLock[PL_LOCK_SLIDE],
                localPlayerLock[PL_LOCK_GRAVITY],
                localPlayerLock[PL_LOCK_TURN]);
            ground = false;
            yspeed = 0;
            ladderXScale = image_xscale;
            climbShootXscale = ladderXScale;
        }
    }
    
    if (climbing) // While climbing
    {
        if (yDir != 0 && !isShoot) // Movement
        {
            yspeed = climbSpeed * yDir;
            climbSpriteTimer += 1;
            if (!(climbSpriteTimer mod 8))
            {
                image_xscale = -image_xscale;
            }
        }
        else
        {
            yspeed = 0;
        }
        
        if (xDir != 0) // Left/right
        {
            climbShootXscale = xDir;
        }
        
        climbing = 1;
        
        // Getup sprite
        if (!position_meeting(x, bbox_top * (gravDir == 1) + bbox_bottom * (gravDir == -1) + 11 * gravDir, objLadder)
        // The second check is to make sure the getup animation is not shown when on the BOTTOM of a ladder that's placed in the air
        && position_meeting(x, bbox_bottom * (gravDir == 1) + bbox_top * (gravDir == -1) + gravDir, objLadder))
        {
            climbing = 2;
            if (!isShoot)
            {
                image_xscale = 1;
            }
        }
        
        // Releasing the ladder
        var jump = global.keyJumpPressed[playerID] && yDir != -gravDir && !playerIsLocked(PL_LOCK_CLIMB);
        if ((ground && yDir == gravDir) || !place_meeting(x, y, objLadder) || jump)
        {
            if (!place_meeting(x, y, objLadder))
            {
                if (place_meeting(x, y + (gravDir * climbSpeed), objLadder))
                {
                    shiftObject(0, climbSpeed * gravDir, 1);
                }
            }
            climbing = false;
            yspeed = 0;
            isSlide = false;
            climbLock = lockPoolRelease(climbLock);
            shootStandStillLock = lockPoolRelease(shootStandStillLock);
            image_xscale = ladderXScale;
        }
    }
}

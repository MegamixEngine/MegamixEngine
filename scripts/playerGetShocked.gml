/// playerGetShocked(ignore ground, additional time, mm1stun, shock time)
// Call it like this: with objMegaman playerGetShocked();
// Makes the player get shocked

var _IgnoreGround = argument0;

if (!isHit && (_IgnoreGround || ground))
{
    shootTimer = -argument1;
    
    // playerGetHit(0); // obsoleted. damage 0 doesn't do anything on playerGetHit
    mm1Stun = argument2; // boolean, if mm1 stun is applied or not.
    shockedTime = argument3;
    
    if (mm1Stun && !isHit && !isShocked)
    {
        if (instance_exists(vehicle))
        {
            // Rush Cycle absorbs hits
            if (vehicle.object_index == objRushCycle)
            {
                exit; // Rush Cycle SHOCK ABSORBANT! Review needed.
            }
        }
        else
        {
            shootTimer = 0;
            isShocked = true;
            isShoot = 0;
            shootStandStillLock = lockPoolRelease(shootStandStillLock);
            
            // When sliding and there's a solid above us, we should not experience knockback
            // If we did, we would clip inside the ceiling above us
            if (!(isSlide && checkSolid(0, -3 * gravDir)))
            {
                // stop performing all current actions:
                isSlide = false;
                mask_index = mskMegaman;
                climbing = false;
                slideLock = lockPoolRelease(slideLock);
                slideChargeLock = lockPoolRelease(slideChargeLock);
                shootStandStillLock = lockPoolRelease(shootStandStillLock);
                climbLock = lockPoolRelease(climbLock);
                
                // knockback speed:
                if (!playerIsLocked(PL_LOCK_MOVE))
                {
                    xspeed = image_xscale * -0.5;
                    yspeed = (-1.5 * gravDir) * (yspeed * gravDir <= 0);
                }
                
                // lock controls during knockback:
                shockLock = lockPoolLock(localPlayerLock[PL_LOCK_MOVE],
                    localPlayerLock[PL_LOCK_JUMP],
                    localPlayerLock[PL_LOCK_CLIMB],
                    localPlayerLock[PL_LOCK_SLIDE],
                    localPlayerLock[PL_LOCK_SHOOT],
                    localPlayerLock[PL_LOCK_TURN]);
            }
        }
    }
    
    // error-checking for recording
    // recordInputFidelityMessage("Hit (" + string(playerID) + ")")
}

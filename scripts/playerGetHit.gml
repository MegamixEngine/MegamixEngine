/// playerGetHit(health)
// Call it like this: with objMegaman playerGetHit();
// Makes the player get hit

var dmg = argument0;

if (!isHit)
{
    if (dmg > 0)
    {
        if (global.skullAmulet)
        {
            if (!(global.playerHealth[playerID] - dmg) && global.playerHealth[playerID] > 1)
            {
                dmg = global.playerHealth[playerID] - 1;
                playSFX(sfxMenuSelect);
            }
        }
        
        if (instance_exists(vehicle))
        {
            // Rush Cycle absorbs hits
            if (vehicle.object_index == objRushCycle && !global.infiniteEnergy[global.weaponID[? objRushCycle]])
            {
                var ndmg = dmg;
                dmg -= min(dmg, global.ammo[playerID, global.weapon[playerID]]);
                global.ammo[playerID, global.weapon[playerID]] = max(0, global.ammo[playerID, global.weapon[playerID]] - ((ndmg) / (global.energySaver + 1)));
            }
        }
        
        global.playerHealth[playerID] -= dmg;
        
        iFrames = -1;
        shootTimer = 0;
        
        if (global.playerHealth[playerID] > 0)
        {
            playSFX(sfxHit);
        }
    }
    
    isHit = true;
    hitTimer = 0;
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
        hitLock = lockPoolLock(localPlayerLock[PL_LOCK_MOVE],
            localPlayerLock[PL_LOCK_JUMP],
            localPlayerLock[PL_LOCK_CLIMB],
            localPlayerLock[PL_LOCK_SLIDE],
            localPlayerLock[PL_LOCK_SHOOT],
            localPlayerLock[PL_LOCK_TURN]);
        
        // Create sweat effects
        if (global.playerHealth[playerID] > 0 && dmg > 0)
        {
            instance_create(spriteGetXCenter() - 11, spriteGetYCenter() - 17, objMegamanSweat);
            instance_create(spriteGetXCenter(), spriteGetYCenter() - 17, objMegamanSweat);
            instance_create(spriteGetXCenter() + 11, spriteGetYCenter() - 17, objMegamanSweat);
        }
    }
    
    // error-checking for recording
    recordInputFidelityMessage("Hit (" + string(playerID) + ")");
}

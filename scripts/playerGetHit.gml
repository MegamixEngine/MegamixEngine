/// playerGetHit(dmg, ...)
// Call it like this: with objMegaman playerGetHit();
// Makes the player get hit

var dmg = argument[0];

if !(checkCheats(cheatEnums.invincible) && !checkCheats(cheatEnums.buddha))
{
    if (!isHit)
    {
        if (dmg > 0)
        {
            if (dmg > 0.01)
            {
                if (global.characterSelected[playerID] == CHAR_PROTOMAN && dmg >= 1) // +2 damage for Proto Man
                {
                    dmg += 2;
                    global.damage += 2;
                }
            
                var doSkullAmulet = true;
        
                if (instance_exists(vehicle))
                {
                    // Rush Cycle absorbs hits
                    if (vehicle.object_index == objRushCycle 
                    && !global.infiniteEnergy[global.weaponID[? objRushCycle]] && global.ammo[playerID, global.weapon[playerID]] > 0 && !(checkCheats(cheatEnums.infiniteWeapons)))
                    {
                        var ndmg = dmg;
                        dmg -= min(dmg, global.ammo[playerID, global.weapon[playerID]]);
                        global.ammo[playerID, global.weapon[playerID]] = max(0, global.ammo[playerID, global.weapon[playerID]] - ((ndmg) / ((global.energySaver > 0) + 1)));
                    
                        doSkullAmulet = false;
                    }
                }
                
                if (global.skullAmulet && doSkullAmulet)
                {
                    if ((global.playerHealth[playerID] - dmg) < 1 && global.playerHealth[playerID] > 1)
                    {
                        dmg = global.playerHealth[playerID] - 1;
                        playSFX(sfxSkullAmulet);
                    }
                }
                
                global.playerHealth[playerID] -= dmg;
            }
            
            if (!checkCheats(cheatEnums.noIFrames))
            {
                iFrames = -1;
            }
            shootTimer = 0;
            
            if (global.playerHealth[playerID] > 0 || (checkCheats(cheatEnums.buddha)))
            {
                playSFX(getGenericSFX(SFX_HURT));
                applyRumble(playerID,0,.5,.075*(.5/.7),15);//Note: This formula is slightly off, 11 has a slightly different feel. Maybe it's better though since knockback is inherently weirder there??
            }
        }
        
        isHit = true;
        hitTimer = 0;
        isShoot = 0;
        shootStandStillLock = lockPoolRelease(shootStandStillLock);
        hitRecover = 1;
     
        // When sliding and there's a solid above us, we should not experience knockback
        // If we did, we would clip inside the ceiling above us
        if (!(isSlide && (checkSolid(0, (-3 * gravDir)) || global.blastWind)))
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
                var factor = 1;
                var factorX = factor;
                
                if (checkCheats(cheatEnums.hyperKnockback))
                    factor *= 8;
                if (global.characterSelected[playerID] == CHAR_PROTOMAN)
                    factorX *= 2;
                
                var xs = image_xscale;
                if (instance_exists(hitterID) && object_is_ancestor(hitterID.object_index,objSpike))
                {
                    xs = gCollXScale;
                }
                
                xspeed = ((xs * -0.5) * factor * factorX);
                if !(checkCheats(cheatEnums.wiiPhysics))
                {
                    yspeed = ((-1.5 * gravDir) * (yspeed * gravDir <= 0)) * factor;
                }
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
                var sweatx = 11;
                var sweaty = 17;
                
                for (var i = -1; i <= 1; i ++;)
                {
                    instance_create(spriteGetXCenter() - (sweatx * i), spriteGetYCenter() - sweaty, objMegamanSweat);
                }
            }
        }
    
        // error-checking for recording
        recordInputFidelityMessage("Hit (" + string(playerID) + ")");
    }
}

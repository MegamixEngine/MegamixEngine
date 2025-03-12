/// playerHandleFrozen();

// Being frozen
if (isFrozen)
{
    freezeTimer -= 1;
    xspeed = 0;
    
    if (isFrozen != 2)
        yspeed = 0;
    
    // Mash out of paralysis
    if (isFrozen == 2)
    {
        if (global.keyLeftPressed[playerID] || global.keyRightPressed[playerID] || global.keyUpPressed[playerID] || global.keyDownPressed[playerID]
        || global.keyJumpPressed[playerID] || global.keyShootPressed[playerID] || global.keySlidePressed[playerID])
        {
            freezeTimer --;
        }
    }
    
    if (!icedLock)
    {
        if (isFrozen == 1)
        {
            icedLock = lockPoolLock(localPlayerLock[PL_LOCK_MOVE],
                localPlayerLock[PL_LOCK_TURN],
                localPlayerLock[PL_LOCK_SLIDE],
                localPlayerLock[PL_LOCK_SHOOT],
                localPlayerLock[PL_LOCK_CLIMB],
                localPlayerLock[PL_LOCK_SPRITECHANGE],
                localPlayerLock[PL_LOCK_GRAVITY],
                localPlayerLock[PL_LOCK_JUMP],
                localPlayerLock[PL_LOCK_CHARGE]);
        }
        else if (isFrozen == 2)
        {
            icedLock = lockPoolLock(localPlayerLock[PL_LOCK_MOVE],
                localPlayerLock[PL_LOCK_TURN],
                localPlayerLock[PL_LOCK_SLIDE],
                localPlayerLock[PL_LOCK_SHOOT],
                localPlayerLock[PL_LOCK_CLIMB],
                localPlayerLock[PL_LOCK_SPRITECHANGE],
                localPlayerLock[PL_LOCK_JUMP],
                localPlayerLock[PL_LOCK_CHARGE]);
        }
    }
    
    if (!freezeTimer || (isHit && !freezeHitOverride))
    {
        isFrozen = 0;
        freezeHitOverride = false;
        icedLock = lockPoolRelease(icedLock);
        playerPalette();
        shootStandStillLock = lockPoolRelease(
            shootStandStillLock);
        isShoot = 0;
        shootTimer = 0;
    }
}

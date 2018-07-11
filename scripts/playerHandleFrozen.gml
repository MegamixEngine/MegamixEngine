/// playerHandleFrozen();

// Being frozen
if (isFrozen)
{
    freezeTimer -= 1;
    xspeed = 0;
    yspeed = 0;
    
    if (!icedLock)
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
    
    if (!freezeTimer || isHit)
    {
        isFrozen = 0;
        icedLock = lockPoolRelease(icedLock);
        playerPalette();
        shootStandStillLock = lockPoolRelease(
            shootStandStillLock);
        isShoot = 0;
        shootTimer = 0;
    }
}

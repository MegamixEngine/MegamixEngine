/// playerLockMovement()
// Locks the player's control input, returning a lock ID which must
// be used in the subsequent call to playerFreeMovement(lock ID)

with (objMegaman)
{
    climbing = false;
    isSlide = false;
    climbLock = lockPoolRelease(climbLock);
    slideLock = lockPoolRelease(slideLock);
    slideChargeLock = lockPoolRelease(slideChargeLock);
    mask_index = mskMegaman;
    xspeed = 0;
}

return lockPoolLock(global.playerLock[PL_LOCK_MOVE],
    global.playerLock[PL_LOCK_TURN],
    global.playerLock[PL_LOCK_JUMP],
    global.playerLock[PL_LOCK_SLIDE],
    global.playerLock[PL_LOCK_PAUSE],
    global.playerLock[PL_LOCK_SHOOT],
    global.playerLock[PL_LOCK_CLIMB],
    global.playerLock[PL_LOCK_JUMP],
    global.playerLock[PL_LOCK_CHARGE],
    global.playerFrozen);

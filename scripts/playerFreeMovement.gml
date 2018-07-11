/// playerFreeMovement(lock ID)
// Frees the player's movement after being locked
// must provide the lock ID given by playerLockMovement

return lockPoolRelease(global.playerLock[PL_LOCK_MOVE],
    global.playerLock[PL_LOCK_TURN],
    global.playerLock[PL_LOCK_SLIDE],
    global.playerLock[PL_LOCK_PAUSE],
    global.playerLock[PL_LOCK_SHOOT],
    global.playerLock[PL_LOCK_CLIMB],
    global.playerLock[PL_LOCK_JUMP],
    global.playerLock[PL_LOCK_CHARGE],
    global.playerFrozen, argument0);

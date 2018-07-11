/// playerTimeRestored(lock id)
// Frees the player's movement (e.g. after being locked)

return lockPoolRelease(global.playerLock[PL_LOCK_MOVE],
    global.playerLock[PL_LOCK_TURN],
    global.playerLock[PL_LOCK_SLIDE],
    global.playerLock[PL_LOCK_SHOOT],
    global.playerLock[PL_LOCK_CLIMB],
    global.playerLock[PL_LOCK_SPRITECHANGE],
    global.playerLock[PL_LOCK_GRAVITY],
    global.playerLock[PL_LOCK_JUMP],
    global.playerLock[PL_LOCK_CHARGE],
    global.playerFrozen,
    argument0);

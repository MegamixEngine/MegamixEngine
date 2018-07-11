/// playerTimeStopped()
/// playerTimeStopped()
// Locks the player's movement
// returns lock ID which should be used for playerTimeRestored()

with (objMegaman)
{
    xspeed = 0;
    yspeed = 0;
}

return lockPoolLock(global.playerLock[PL_LOCK_MOVE],
    global.playerLock[PL_LOCK_TURN],
    global.playerLock[PL_LOCK_SLIDE],
    global.playerLock[PL_LOCK_SHOOT],
    global.playerLock[PL_LOCK_CLIMB],
    global.playerLock[PL_LOCK_SPRITECHANGE],
    global.playerLock[PL_LOCK_GRAVITY],
    global.playerLock[PL_LOCK_JUMP],
    global.playerLock[PL_LOCK_CHARGE],
    global.playerFrozen);

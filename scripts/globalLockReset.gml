/// playerLockGlobalInit()
// initializes global player control lock pools

// TODO: add global.frozen
// TODO: add global.lockTransition
lockPoolReleaseAll(global.timeStopped);
lockPoolReleaseAll(global.playerFrozen);

for (var i = 0; i < PL_LOCK_MAX; i++)
{
    lockPoolReleaseAll(global.playerLock[i]);
}

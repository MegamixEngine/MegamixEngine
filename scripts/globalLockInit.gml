/// playerLockGlobalInit()
// initializes global player control lock pools

// TODO: add global.frozen
// TODO: add global.lockTransition
global.timeStopped = lockPoolNew();
global.playerFrozen = lockPoolNew();

for (var i = 0; i < PL_LOCK_MAX; i++)
{
    global.playerLock[i] = lockPoolNew();
}

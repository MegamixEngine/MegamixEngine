/// playerLockGlobalInit()
// initializes global player control lock pools

// TODO: add global.frozen
// TODO: add global.lockTransition

/*
show_message("STARTING LOCK POOL TEST");
for (var i = 0; i < 2; i++)
{
    var myLockPool = lockPoolNew();
    show_message("LOCK POOL: " + string(myLockPool));
    var myLock = lockPoolLock(myLockPool);
    show_message("LOCK: " + string(myLock));
    myLock = lockPoolRelease(myLock);
    myLock = lockPoolLock(myLockPool);
    var myLock2 = lockPoolLock(myLockPool);
    show_message("LOCK: " + string(myLock));
    myLock = lockPoolRelease(myLock);
    myLock = lockPoolLock(myLockPool);
    show_message("LOCK: " + string(myLock));
    lockPoolReleaseAll(myLockPool);
    show_message("DESTROY");
    lockPoolDestroy(myLockPool,true);
}
show_message("TEST COMPLETE");*/

global.timeStopped = false;//lockPoolNew(); This is only ever used as a boolean, it may very well have been the cause of EZ/48H shenanigans.
global.playerFrozen = lockPoolNew();

for (var i = 0; i < PL_LOCK_MAX; i++)
{
    global.playerLock[i] = lockPoolNew();
}


/// lockPoolReleaseAll(lock pool IDs)
// releases all locks on the given lock pool.
// This is very dangerous because returning a checked-out lock after this
// operation could cause an error. This function should only be called if
// it can be guaranteed that no currently-checked-out locks will be
// returned.

for (var lp = 0; lp < argument_count; lp++)
{
    lockPoolID = argument[lp];
    if (!lockPoolExists(lockPoolID))
    {
        printErr("Invoked lockPoolReleaseAll on a non-existent lock pool.");
        continue;
    }
    
    // remove all locks on this lock pool
    for (var i = 0; i < global.lockPoolLockCount[lockPoolID]; i++)
    {
        global.lockPoolLockTable[lockPoolID, i] = false;
    }
    
    global.lockPoolLockCount[lockPoolID] = 0;
    if (global.lockPoolTombstone[lockPoolID])
    {
        global.lockPoolTombstone[lockPoolID] = false;
        global.lockPoolAvailable[lockPoolID] = true;
    }
}

return 0;

/// isLocked(ids[...])
/// returns true if any of the given lock pools are locked:

for (var lp = 0; lp < argument_count; lp++)
{
    var lockPoolID = argument[lp];
    
    // error-checking
    if (!lockPoolExists(lp))
    {
        printErr("Attempted to check value of lock on non-existent lock pool, id: " + string(lockPoolID));
        assert(false);
        return -1;
    }
    
    // check if lock pool is locked
    if (global.lockPoolLockCount[lockPoolID] > 0)
        return true;
}

return false;

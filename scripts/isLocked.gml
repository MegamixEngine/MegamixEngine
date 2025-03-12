/// isLocked(ids[...])
/// returns true if any of the given lock pools are locked:

for (var lp = 0; lp < argument_count; lp++)
{
    if (lockPoolExists(argument[lp]))
    {
        var lockPoolID = getLockMap(argument[lp]);


        // check if lock pool is locked
        if (ds_map_size(lockPoolID) > 0)//global.lockPoolLockCount[lockPoolID] > 0)
            return true;
    }
}

return false;

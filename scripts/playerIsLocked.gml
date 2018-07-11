/// playerIsLocked(playerLockValueType[...])
// shortcut to check player global and local lock pool for the given objMegaman.
// values are PL_LOCK_MOVE, etc.

assert(object_index == objMegaman, "playerIsLocked can only be called from an instance of objMegaman");

for (var i = 0; i < argument_count; i++)
{
    var lock = argument[i];
    switch (lock)
    {
        case PL_LOCK_GROUND:
            if ((isLocked(global.playerLock[PL_LOCK_GROUND]))
                || (isLocked(global.playerLock[PL_LOCK_MOVE])))
                return true;
            break;
        case PL_LOCK_AERIAL:
            if ((isLocked(global.playerLock[PL_LOCK_AERIAL]))
                || (isLocked(global.playerLock[PL_LOCK_MOVE])))
                return true;
            break;
        default: // most locks check if either the local or global version of the pool is locked. 
            if (isLocked(localPlayerLock[lock], global.playerLock[lock]))
                return true;
    }
}

return false;

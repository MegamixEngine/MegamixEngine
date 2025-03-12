/// lockPoolDestroy(lockPoolID, ...)
// destroys the given lock pool ID
// if suppress is set to true, no error will occur even if lock pool already destroyed

var lockPoolID = argument[0];
//printErr("LOCKDESTROY");
if ((argument_count > 1 && !argument[1]) || ds_map_exists(global.lockPoolMap,lockPoolID))
{//Ignore if there is no map, unless suppress is off, then crash. Not an assert crash like before but doesn't matter.
    lockPoolReleaseAll(lockPoolID);//Any IDMaps inside, clear them out.
    mm_ds_map_destroy(getLockMap(lockPoolID));//Then destroy the map itself
    ds_map_delete(global.lockPoolMap,lockPoolID);//Then its entry.
}
/*
assert(lockPoolExists(lockPoolID) || argument[1], "Attempted to destroy non-existent lock pool id " + string(lockPoolID));

// destroy list:
if (global.lockPoolLockCount[lockPoolID] == 0)
{//Why is this necessary? Theoretically should be doable without, but entries seem to make this wonky? Zatsu's SoN in particuarly in 2 memtests.
    global.lockPoolAvailable[lockPoolID] = true;
}
else
{
    global.lockPoolTombstone[lockPoolID] = true;
}
*/

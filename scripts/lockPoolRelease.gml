/// lockPoolRelease(lock IDs, [strict])
// releases the given lock on all lock pools.
// If a list of lock IDs is provided, the lookup is strict
// and will throw an error if the lock set provided doesn't match what pools are actually locked.
// otherwise, error checking still occurs but only is caught if releasing the lock changes no values.

if (argument_count == 0)
    return false;
var IDKey = argument[argument_count - 1] - 1;
var strict = argument_count > 1;
if (IDKey < 0)
    return false;
var anyRelease = false;
var poolKey = ds_map_find_first(global.lockPoolMap);
while (!is_undefined(poolKey))//for (var lockPoolID = 0; lockPoolID < global.lockPoolN; lockPoolID++)
{//For every map in the global pool map, delete the entry.
    //if (!lockPoolExists(lockPoolID))
    //    continue;
    
    // determine whether this lock pool has the given lock checked out
    var poolMap = getLockMap(poolKey);
    var poolHasLock = ds_map_exists(poolMap,IDKey);
    
    // strict error-checking
    if (strict)
    {
        var strictPoolCheck = false;
        for (var i = 0; i < argument_count - 1; i++)
            if (argument[i] == poolKey)//Is the pool we're searching in part of any of the arguments?
                strictPoolCheck = true;
        if (poolHasLock && !strictPoolCheck)
        {
            printErr("Given lock index is locked in a lock pool which was not listed in the strict check, pool key: " + string(poolKey) + ", lock ID: " + string(IDKey));
            assert(false);
            return -1;
        }
        if (!poolHasLock && strictPoolCheck)
        {
            printErr("Given lock index is already released (or never obtained) in a lock pool which was listed in the strict check, pool key: " + string(poolKey) + ", lock ID: " + string(IDKey));
            assert(false);
            return -1;
        }
    }
    
    // release lock
    if (poolHasLock)
    {
        //global.lockPoolLockTable[lockPoolID, IDKey] = false;
        anyRelease = true;
        //var IDMap = ds_map_find_value(poolMap,IDKey);
        //show_message("DELETING ID" + string(IDMap));
        ds_map_delete(poolMap,IDKey);
        //mm_ds_map_destroy(IDMap);
        
    }
    //Because there are no tombstones, you cannot release a lock on a tombstone and have anyRelease cleared.
    //But there shouldn't be any tombstones in what I tested so far???
    poolKey = ds_map_find_next(global.lockPoolMap,poolKey);
}
if (VERSION_INT < 100)
{
    if (!global.lockPool_IgnoreAssertions && !anyRelease)
    {
        printErr("Poor lockpool usage! Report please.");//assert(anyRelease, "Released lock, but no lock pools had lock ID " + string(IDKey + 1) + " checked out!");
        defer(ev_step,ev_step_normal,0,printErr,makeArray("Also report sus movement."),60);
        
    }
}
return 0;

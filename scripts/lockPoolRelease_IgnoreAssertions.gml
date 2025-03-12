/// lockPoolRelease_IgnoreAssertions(lock IDs, [strict])
// releases the given lock on all lock pools.
// If a list of lock IDs is provided, the lookup is strict
// and will throw an error if the lock set provided doesn't match what pools are actually locked.
// otherwise, error checking still occurs but only is caught if releasing the lock changes no values.
global.lockPool_IgnoreAssertions = true;
var arr = array_create(0);
for (var i = 0; i < argument_count; i++)
{
    arr[i] = argument[i];
}
var ret = scriptExecuteNargs(lockPoolRelease,arr,argument_count);
global.lockPool_IgnoreAssertions = false;
return ret;

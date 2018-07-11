/// lockPoolDestroy(id, [suppress])
// destroys the given lock pool ID
// if suppress is set to true, no error will occur even if lock pool already destroyed

var lockPoolID = argument[0];

assert(lockPoolExists(lockPoolID) || argument[1], "Attempted to destroy non-existent lock pool id " + string(lockPoolID));

// destroy list:
if (global.lockPoolLockCount[lockPoolID] == 0)
{
    global.lockPoolAvailable[lockPoolID] = true;
}
else
{
    global.lockPoolTombstone[lockPoolID] = true;
}

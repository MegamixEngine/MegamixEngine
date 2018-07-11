/// lockPoolNew()
// creates a new lock pool, returning its ID

for (var i = 0; i < global.lockPoolN; i++)
{
    if (global.lockPoolAvailable[i])
    {
        global.lockPoolAvailable[i] = false;
        global.lockPoolLockCount[i] = 0;
        global.lockPoolTombstone[i] = false;
        return i;
    }
}

// add a new pool to the list:
global.lockPoolAvailable[global.lockPoolN] = false;
global.lockPoolLockCount[global.lockPoolN] = 0;
global.lockPoolTombstone[global.lockPoolN] = false;

return global.lockPoolN++;

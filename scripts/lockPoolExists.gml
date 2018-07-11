/// lockPoolExists(id)
// returns true if the given lock pool exists

if (argument0 >= global.lockPoolN)
    return false;

return !global.lockPoolAvailable[argument0];

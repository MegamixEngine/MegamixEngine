/// lockPoolExists(id)
// returns true if the given lock pool exists

return ds_map_exists(global.lockPoolMap,argument[0]);
/*
if (argument0 >= global.lockPoolN)
    return false;

return !global.lockPoolAvailable[argument0];*/

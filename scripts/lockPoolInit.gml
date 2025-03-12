/// lockPoolInit()
// initializes lock pool system
global.lockPoolN = 0;

global.lockPool_IgnoreAssertions = false;

global.lockPoolMap = mm_ds_map_create(true);

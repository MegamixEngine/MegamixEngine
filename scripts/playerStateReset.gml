/// playerStateReset(_pid)
// resets health and ammo when a new level begins
// invoked by levelStart()

var _pid = argument0;

// Reset health
global.playerHealth[_pid] = 28;

resetAllWeaponLocks();

global.weapon[_pid] = 0;
global.respawnTimer[_pid] = -1;

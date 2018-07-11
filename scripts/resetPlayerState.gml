/// resetPlayerState(playerID)
// resets health and ammo when a new level begins
// invoked by levelStart()

var pid = argument0;

global.playerHealth[pid] = 28;
for (var j = 0; j <= global.totalWeapons; j++)
{
    global.ammo[pid, j] = 28;
    if (!instance_exists(objWeaponSettings))
    {
        global.infiniteEnergy[j] = false;
    }
}
global.weapon[pid] = 0;
global.respawnTimer[pid] = -1;

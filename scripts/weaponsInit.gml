/// weaponsInit()
/// initializes modular weapon system.
/// see weaponSetup for more documentation on the modular weapon system.

// Initial Setup for weapons
lr = 4000; // there's no object_last or object_total or anything, so uh. hmph

global.totalWeapons = -1; // Set this to -1 for now. Mega Buster auto-becomes ID 0

// You can override the weapon order if you want, but this can all just be set to go automatically.
// See any event user 0 of the default weapons for more info.

global.weaponID = ds_map_create();

// Get weapon objects
for (obj = 0; obj < lr; obj += 1)
{
    if (object_exists(obj))
    {
        event_perform_object(obj, ev_other, ev_user12); // EV_WEAPON_SETUP
    }
}

for (var j = 0; j <= global.totalWeapons; j++)
{
    global.infiniteEnergy[j] = false;
    global.weaponLocked[j] = false;
}

global.lockBuster = false;
global.playerProjectileCreator = objMegaman;

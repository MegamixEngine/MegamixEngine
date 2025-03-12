///factionInit()

// FACTIONS
var i = 0;

// 0 - Neutral
var fNeutral = (i ++);

// 1 - Player
var fPlayer = (i ++);

// 2 - Player Projectiles
var fProjectiles = (i ++);

// 3 - Enemies
var fEnemies = (i ++);

// 4 - Misc
var fMisc = (i ++);

// 5 - Vs Everyone Else, immune to other enemy factions
var fHostile = (i ++);

// 6 - Passive only towards the player
var fPassive = (i ++);

// 7 - Passive towards players, but vulnerable to player projectiles
var fVulnerable = (i ++);

// - - - - - - - - -

//Set faction defaults (0 = neutral)
var ii, iii;

for (     ii = 0;  ii < i;  ii ++;)
{
    for (iii = 0; iii < i; iii ++;)
    {
        global.factionStance[ii, iii] = 0; 
    }
}

// - - - - - - - - -

//Set hostility flags

//How to set up
//global.factionStance[(own faction), (other faction)] = (hostility?)

// Player Projectiles
global.factionStance[fProjectiles, fEnemies] = 1;
global.factionStance[fProjectiles, fMisc] = 1;
global.factionStance[fProjectiles, fHostile] = 1;
global.factionStance[fProjectiles, fVulnerable] = 1;

// Enemies
global.factionStance[fEnemies, fPlayer] = 1;

// Misc
global.factionStance[fMisc, fPlayer] = 1;
global.factionStance[fMisc, fEnemies] = 1;

// Vs Everyone Else, immune to other enemy factions
global.factionStance[fHostile, fPlayer] = 1;
global.factionStance[fHostile, fEnemies] = 1;
global.factionStance[fHostile, fMisc] = 1;
global.factionStance[fHostile, fHostile] = 1;
global.factionStance[fHostile, fVulnerable] = 1;

// Passive only towards the player
global.factionStance[fPassive, fNeutral] = 1;
global.factionStance[fPassive, fProjectiles] = 1;
global.factionStance[fPassive, fEnemies] = 1;
global.factionStance[fPassive, fMisc] = 1;
global.factionStance[fPassive, fHostile] = 1;

// Passive towards players, but vulnerable to player projectiles
global.factionStance[fVulnerable, fProjectiles] = 1;

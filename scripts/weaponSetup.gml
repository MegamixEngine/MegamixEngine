////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////// MAGMML ENGINE WEAPON SETUP //////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/*

For the MaGMML engine, we decided to make putting in new special weapons an incredibly easy
affair. We sorta refer to this as the 'plug and go' system - you can just download a weapon
from somewhere, import one or two objects and two or three sprites for each weapon, and it's
automatically ready to go, even put in the pause menu.

The system basically works off user defined events. Objects like objGlobalControl - the object that
this script specifically is being called from - run their relevant user events and get everything
set up. If you're confused, don't worry - you don't need to know this to make a special weapon.
Here's a basic rundown on what does what in a weapon's user defined events:

* User Defined 7 - Script for what happens if the weapon ricochets off. Optional - if there is no code
in this event, it'll go with the default reflecting code defined in prtPlayerProjectile.
* User Defined 8 - Script for what happens if the weapon makes contact and successfully deals damage.
Used for stuff like Grab Buster syphoning health. This can be left blank as well.
* User Defined 15 - Script for what the object does on spawn. For example, Slash Claw attaching itself
to the player. Optional - you don't have to define this, you can just leave it as nothing happening.

* User Defined 12 - The initial setup for the weapon. You set the name, palette and 'can charge' flag
here. The weapon ID is also automatically set, but you can also just override the autoincrementing
if you want a weapon to have a specifc ID.
* User Defined 13 - The defining for damage tables involving this weapon. You can set its base power,
and then use the script 'specialDamageValue' to define what enemies or categories of enemies take other
than the base damage from the weapon. See that script for more info.
* User Defined 14 - Code that's run every single frame here for the player. This is used for actually, you
know, shooting the weapon. Charging is also done here. Check objBusterShot for an example of how
exactly this works. Stuff like looking up for Wire Adaptor is also done here.

Only events 12-14 are used by only player projectiles, but 7, 8 and 15 are all relevant to making weapons 
despite them being global to all entities.

User Defined Events 0-6 are all left for the users to use with their own weapons.
*/

/// weaponSetup(name, primary color, secondary color, icon)
// name - name of the weapon
// primary color - replacement for Mega Man's darker blue
// secondary color - replacement for Mega Man's brighter blue
// icon - the icon that will be displayed in the pause menu or when switching weapons

// Setup this weapon.
global.totalWeapons += 1;

// Name
global.weaponName[global.totalWeapons] = argument0;

// Color / -1 will make it use default colors.
global.weaponPrimaryColor[global.totalWeapons] = argument1;
global.weaponSecondaryColor[global.totalWeapons] = argument2;

global.weaponIcon[global.totalWeapons] = argument3;

global.weaponID[? obj] = global.totalWeapons;
global.weaponObject[global.totalWeapons] = obj;
global.weaponHotbar[global.totalWeapons] = global.totalWeapons;

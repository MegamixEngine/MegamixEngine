/// mm_init
/*
Data structures are certain types of function in GMS that utilize what's called
unmanaged memory. This is something that must be freed up when it's no longer
used, otherwise it results in a memory leak that can build up over time and
crash your game, usually without warning.

GMS1.4 is... bad at making it easy to manage this memory on a scale at the size 
of your average MaGMML game, as there are multiple checks and circumstances that
need to be accounted for. As a result, for MaGMML3 and Megamix 1.9, I created
the Memory Manager. This effectively replaces the normal call of these functions
project-wide, outside the the internal calls used in these functions.

How these differ from their normal counterparts depends where they are called:

If they are called by an object that is persistent, 
or a parent of prtAlwaysActive, then the data *will* still remain in memory
until the game is reset!

Otherwise, the memory will only be retained until the end of the current room,
at which point objGlobalControl will call the cleanup routine in a roundabout
way, designed to ensure it occurs at the end of *everything* else in the current
room.

On game reset, *all* data structures are cleaned up by ScorchedEarth.

Some, but not *all* datastructures, currently have a manual override for global
scope, placed at the end of their normal parameters. This should only be used
for data structures that need to be called by a non-persistent/prtAlwaysActive
child object, but need to remain in memory until game reset.

As Megamix 2.0 will be in GMS2, which has a cleanup event for each object, the
use of the memory manager there will (hopefully) be removed, though there may
be a compatibility passthrough script left in. Not sure yet. -Gannio

*/

    
global.memoryManager = ds_map_create();

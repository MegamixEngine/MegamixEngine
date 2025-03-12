/// lockPoolNew()
// creates a new lock pool, returning its ID

if (global.lockPoolN > 16000000)
{/*Absurdity check: If the player somehow exhausts 16 *million* locks in a 
playthrough, then at least one *somewhere* below us should be available.

We stop at 16 million because 16777216 is the max value we can get adding up by 1.
*/
    global.lockPoolN = 0;
}
while (ds_map_exists(global.lockPoolMap,global.lockPoolN))
{//Existance check in the event we wrap around in absuridity check above.
    global.lockPoolN++;
}
ds_map_add(global.lockPoolMap,global.lockPoolN,mm_ds_map_create(true));//global.lockPoolMapArray[global.lockPoolN] = mm_ds_map_create(true);
/*
Is the map available?
lock count
tombstone. (Removed).

*/
var ret = global.lockPoolN;
global.lockPoolN++;
return ret;

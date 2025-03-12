/// lockPoolLock(ids[...])
// checks out a lock on each of the provided lock pools, returning the
// checkedOutLock id (always greater than 0 if at least one lock ID provided).
// This value should later be used in lockPoolRelease.
// at least one lock pool id must be provided.
// This is potentially inefficient if more than one lock pool ID
// is provided, as a common unused entry must be found in each
// lock pool.

if (argument_count <= 0)
    return 0;

for (var IDKey = 1; true; IDKey++)
{
    var poolKey = ds_map_find_first(global.lockPoolMap);
    var isUniqueID = true;
    while (!is_undefined(poolKey))//for (//var i = 0; i < argument_count; i++)
    {
        //Check every pool map until we find a unique value.
        if (ds_map_exists(getLockMap(poolKey),IDKey))
        {
            isUniqueID = false;
            //show_message("NOT UNIQUE");
            break;
            //var submapRef = ds_map_find_value(global.lockPoolMap,argument[i]);
            //if (ds_map_exists(submapRef,))
            
            //ds_map_add(submapRef,);//ds_map_replace(global.lockPoolMap,argument[i],val+1);
            //return 1;
            
            //var current = ds_map_find_value(global.lockPoolMap,argument[i]);
            
        }//var array = global.lockPoolMap[argument[i]];
        poolKey = ds_map_find_next(global.lockPoolMap,poolKey);
    }
    if (isUniqueID)
    {
        for (var i = 0; i < argument_count; i++)
        {//Now go and apply that unique value to every pool map in the arguments!
            var poolMap = getLockMap(argument[i]);
            ds_map_add(poolMap,IDKey,true)
            //poolKey = ds_map_find_next(global.lockPoolMap,poolKey);
            
        }
        //printErr(IDKey);
        return IDKey + 1;//This plus 1 is to keep compatibility with MaGMML3, but might also be required?
    }
}

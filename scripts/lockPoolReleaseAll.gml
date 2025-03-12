/// lockPoolReleaseAll(lock pool IDs)
// releases all locks on the given lock pool.
// This is very dangerous because returning a checked-out lock after this
// operation could cause an error. This function should only be called if
// it can be guaranteed that no currently-checked-out locks will be
// returned.

for (var lp = 0; lp < argument_count; lp++)
{
    var map = getLockMap(argument[lp]);
    if (ds_exists(map,ds_type_map))
    {//COMPATIBILTY: Ideally, this check is not required due to specifying the map above.
    //But MaGMML3 had some poorly coded setups that needed this to not crash and burn.
    //I.e. global.timeStopped trying to use it.
        /*if (!lockPoolExists(lockPoolID))
        {
            printErr("Invoked lockPoolReleaseAll on a non-existent lock pool.");
            continue;
        }*/
        //The actual unique IDs
        var IDKey = ds_map_find_first(map);
        while (!is_undefined(IDKey))
        {
            var nxt = ds_map_find_next(map,IDKey);//Order of execution.
            //mm_ds_map_destroy(IDKey);
            ds_map_delete(map,IDKey);
            IDKey = nxt;
        }
    }
}

return 0;

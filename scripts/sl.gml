/// sl(globalAsString, defaultValue = 0, optionalKey = "", arrayIndex = -1, arrayIndex2D = -1)
// saves value to file (set in slBegin) and returns value input,
// or if loading, returns value loaded from file (or value input if error, unless default specified)
// key is optional argument to attach variable to a name, this prevents
// the variable from being corrupted if save file format is reordered.
// otherwise, a key will be generated according to the order of the sl calls.
// isArray: must be true if loading an array.
// default: return this value if loading fails (by default, return value)
var globalAsString = argument[0];
var defaultValue; if (argument_count > 1) defaultValue = argument[1]; else defaultValue = 0;
var optionalKey; if (argument_count > 2) optionalKey = argument[2]; else optionalKey = "";
var arrayIndex; if (argument_count > 3) arrayIndex = argument[3]; else arrayIndex = -1;
var arrayIndex2D; if (argument_count > 4) arrayIndex2D = argument[4]; else arrayIndex2D = -1;
//OLD: [value], [key], [isArray], [default]

var defaultIsArray = is_array(defaultValue);

var value = 0;




if (global.sl_save != SL_INIT)
{
    if (!global.sl_hotbarMode)
    {
        value = variable_global_get(argument[0]);
    }
    else//This is not actually a string in this case, rather the direct value (Which has been pre-established even for SL_INIT).
    {
        value = globalAsString;
    }
    /*if (global.sl_save == SL_SAVE)
    {
        isArray = isArray || is_array(value);
    }
    if (isArray)//If < 0, it will return the *full* array. Otherwise returns an index.
    {*/
    if (arrayIndex >= 0)
    {
        if (arrayIndex2D >= 0)
        {
            value = value[arrayIndex,arrayIndex2D];
        }
        else
        {
            value = value[arrayIndex];
        }
    }
    else if (global.sl_save == SL_LOAD && defaultIsArray)
    {//Expand the loaded array if it's below the default array size and said default array has some value.
        //NOTE: This functionality only works for 1D arrays!
        while (array_length_1d(value) < array_length_1d(defaultValue) && array_length_1d(defaultValue) > 0)
        {
            if (is_real(defaultValue[0]))
            {
                value[array_length_1d(value)] = 0;
            }
            else if (is_string(defaultValue[0]))
            {
                value[array_length_1d(value)] = "";
            }
            
        }
        
    }
    //}
    
    if (global.sl_save == SL_SAVE)//Return the value we came in with if saving.
    {
        defaultValue = value;
    }
    
}
else
{//If initializing, just stop and return the default value. 
    return defaultValue;
}
var key = "";
if (optionalKey != "")
{
    key = optionalKey;
}
else
{
    // autogenerate key based on global variable name.
    key = globalAsString;
}

if (global.sl_error)
{
    return value;
}

if (global.sl_save == SL_SAVE)
{
    global.sl_map[? key] = value;
    return value;
}
else if (global.sl_save == SL_LOAD)
{
    var lookup = global.sl_map[? key];
    if (!is_undefined(lookup))
    {
        // handle arrays specially
        if (defaultIsArray)
        {
            if (is_real(lookup))
            {
                var list = lookup;
                if (ds_exists(list, ds_type_list))
                {
                    if (ds_list_size(list) > 0)
                    {
                        var returnArray;
                        for (var i = 0; i < ds_list_size(list); i++)
                        {
                            returnArray[i] = ds_list_find_value(list, i);
                        }
                        return returnArray;
                    }
                    else
                    {
                        return array_create(0);
                    }
                }
            }
            
            printErr("Unexpected value when searching for array in " + global.sl_filename + ": " + string(key) + " (using default.)");
            return defaultValue;
        }
        else
        {
            // return saved value
            return lookup;
        }
    }
    
    // not found in file -- return default, throw no error (!)
    print("Key not found in " + global.sl_filename + ": " + string(key) + " (using default.)", WL_VERBOSE);
    return defaultValue;
}

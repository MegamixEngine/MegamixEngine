/// gigVariableGet(variable name, global, [self,] [array index 1, array index 2])
// gets variable of the given name.

var vname = argument[0];
var _global = argument[1];
var _self;
var _array_arg_index = 2;
if (!_global)
{
    _self = argument[2];
    _array_arg_index = 3;
}
var arrayAccess = argument_count > _array_arg_index;
var i, j;
if (arrayAccess)
{
    i = argument[_array_arg_index];
    j = argument[_array_arg_index + 1];
}

// remove `global.` from start of name.
if (string_length(vname) > 7)
{
    if (string_copy(vname, 1, 7) == "global.")
    {
        _global = true;
        vname = string_copy(vname, 8, string_length(vname) - 8);
    }
}

if (!arrayAccess)
{
    if (_global)
    {
        assert(variable_global_exists(vname), "getting nonexistent global: " + vname);
        return variable_global_get(vname);
    }
    
    // check built-in variables first
    if (vname == "background_colour")
        return background_colour;
    else if (vname == "view_xview")
        return view_xview;
    else if (vname == "view_yview")
        return view_yview;
    else if (vname == "view_wview")
        return view_wview;
    else if (vname == "view_hview")
        return view_hview;
    else if (vname == "DIFF_EASY")
        return DIFF_EASY;
    else if (vname == "DIFF_NORMAL")
        return DIFF_NORMAL;
    else if (vname == "DIFF_HARD")
        return DIFF_HARD;
    else if (vname == "DEBUG_SPAWN")
        return DEBUG_SPAWN;
    else if (vname == "x")
        return _self.x;
    else if (vname == "y")
        return _self.y;
    else if (vname == "bbox_left")
        return _self.bbox_left;
    else if (vname == "bbox_right")
        return _self.bbox_right;
    else if (vname == "bbox_top")
        return _self.bbox_top;
    else if (vname == "bbox_bottom")
        return _self.bbox_bottom;
    else if (vname == "xstart")
        return _self.xstart;
    else if (vname == "ystart")
        return _self.ystart;
    else if (vname == "xprevious")
        return _self.xprevious;
    else if (vname == "yprevious")
        return _self.yprevious;
    else if (vname == "false")
        return false;
    else if (vname == "true")
        return true;
    else if (vname == "other")
        return other;
    else if (vname == "self")
        return self;
    else if (vname == "all")
        return all;
    else if (vname == "noone")
        return noone;
    // TODO: add more built-in variables
    else  if (asset_get_index(vname) != -1)
    {
        return asset_get_index(vname);
    }
    assert(variable_instance_exists(_self, vname), "getting nonexistant instance variable: " + vname);
    return variable_instance_get(_self, vname);
}
else
{
    // array access
    if (vname == "view_xview")
        return view_xview[i, j];
    else if (vname == "view_yview")
        return view_yview[i, j];
    else if (vname == "view_wview")
        return view_wview[i, j];
    else if (vname == "view_hview")
        return view_hview[i, j];
    // TODO: add more built-in variables
    else
    {
        var arr;
        if (_global)
        {
            assert(variable_global_exists(vname), "getting nonexistent global: " + vname);
            arr = variable_global_get(vname);
        }
        else
        {
            assert(variable_instance_exists(_self, vname), "getting nonexistant instance variable: " + vname);
            arr = variable_instance_get(_self, vname);
        }
        
        return arr[@ i, j];
    }
}

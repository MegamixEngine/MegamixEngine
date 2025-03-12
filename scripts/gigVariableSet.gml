/// gigVariableSet(variable name, value, global, [self,] [array index 1, array index 2])
// sets variable of the given name.

var vname = argument[0];
var val = argument[1];
var _global = argument[2];
var _self;
var _array_arg_index = 3;
if (!_global)
{
    _self = argument[3];
    _array_arg_index = 4;
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
    // check built-in variables first
    if (vname == "background_colour")
        background_colour = val;
    else if (vname == "view_xview")
        view_xview = val;
    else if (vname == "view_yview")
        view_yview = val;
    else if (vname == "depth")
        _self.depth = val;
    else if (vname == "persistent")
        _self.persistent = val;
    else if (vname == "visible")
        _self.visible = val;
    else if (vname == "solid")
        _self.solid = val;
    else if (vname == "x")
        _self.x = val;
    else if (vname == "y")
        _self.y = val;
    else if (vname == "xprevious")
        _self.xprevious = val;
    else if (vname == "yprevious")
        _self.yprevious = val;
    else if (vname == "xstart")
        _self.xstart = val;
    else if (vname == "ystart")
        _self.ystart = val;
    else if (vname == "sprite_index")
        _self.sprite_index = val;
    else if (vname == "image_angle")
        _self.image_angle = val;
    else if (vname == "image_blend")
        _self.image_blend = val;
    else if (vname == "image_index")
        _self.image_index = val;
    else if (vname == "image_alpha")
        _self.image_alpha = val;
    else if (vname == "image_speed")
        _self.image_speed = val;
    else if (vname == "image_xscale")
        _self.image_xscale = val;
    else if (vname == "image_yscale")
        _self.image_yscale = val;
    else if (vname == "mask_index")
        _self.mask_index = val;
    else if (vname == "friction")
        _self.friction = val;
    else if (vname == "gravity")
        _self.gravity = val;
    else if (vname == "gravity_direction")
        _self.gravity_direction = val;
    else if (vname == "hspeed")
        _self.hspeed = val;
    else if (vname == "vspeed")
        _self.vspeed = val;
    else if (vname == "speed")
        _self.speed = val;
    else if (vname == "direction")
        _self.direction = val;
    else if (vname == "path_position")
        _self.path_position = val;
    else if (vname == "path_positionprevious")
        _self.path_positionprevious = val;
    else if (vname == "path_speed")
        _self.path_speed = val;
    else if (vname == "path_scale")
        _self.path_scale = val;
    else if (vname == "path_orientation")
        _self.path_orientation = val;
    else if (vname == "path_endaction")
        _self.path_endaction = val;
    else if (vname == "timeline_index")
        _self.timeline_index = val;
    else if (vname == "timeline_running")
        _self.timeline_running = val;
    else if (vname == "timeline_speed")
        _self.timeline_speed = val;
    else if (vname == "timeline_position")
        _self.timeline_position = val;
    else if (vname == "timeline_loop")
        _self.timeline_loop = val;
    // TODO: add more built-in variables
    else
    {
        if (_global)
        {
            variable_global_set(vname, val);
        }
        else
        {
            variable_instance_set(_self, vname, val);
        }
    }
}
else
{
    // array access
    if (vname == "view_xview")
        view_xview[i, j] = val;
    else if (vname == "view_yview")
        view_yview[i, j] = val;
    else if (vname == "alarm")
        _self.alarm[j] = val;
    // TODO: add more built-in variables
    else
    {
        var v;
        v[0] = 0;
        var arr;
        if (_global)
        {
            if (!variable_global_exists(vname))
            {
                variable_global_set(vname, v);
                assert(is_array(variable_global_get(vname)));
            }
            arr = variable_global_get(vname);
        }
        else
        {
            if (!variable_instance_exists(_self, vname))
            {
                variable_instance_set(_self, vname, v);
                assert(is_array(variable_instance_get(_self, vname)));
            }
            arr = variable_instance_get(_self, vname);
        }

        if (is_array(arr))
        {
            arr[@ i, j] = val;
        }
        else
        {
            arr[i, j] = val;
            variable_instance_set(_self, vname, arr);
        }
    }
}

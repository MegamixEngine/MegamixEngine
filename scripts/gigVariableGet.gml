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
    else if (vname == "id")
        return _self.id;
    else if (vname == "object_index")
        return _self.object_index;
    else if (vname == "depth")
        return _self.depth;
    else if (vname == "persistent")
        return _self.persistent;
    else if (vname == "visible")
        return _self.visible;
    else if (vname == "solid")
        return _self.solid;
    else if (vname == "x")
        return _self.x;
    else if (vname == "y")
        return _self.y;
    else if (vname == "xprevious")
        return _self.xprevious;
    else if (vname == "yprevious")
        return _self.yprevious;
    else if (vname == "xstart")
        return _self.xstart;
    else if (vname == "ystart")
        return _self.ystart;
    else if (vname == "sprite_index")
        return _self.sprite_index;
    else if (vname == "image_angle")
        return _self.image_angle;
    else if (vname == "image_blend")
        return _self.image_blend;
    else if (vname == "image_index")
        return _self.image_index;
    else if (vname == "image_alpha")
        return _self.image_alpha;
    else if (vname == "image_number")
        return _self.image_number;
    else if (vname == "image_speed")
        return _self.image_speed;
    else if (vname == "image_xscale")
        return _self.image_xscale;
    else if (vname == "image_yscale")
        return _self.image_yscale;
    else if (vname == "mask_index")
        return _self.mask_index;
    else if (vname == "friction")
        return _self.friction;
    else if (vname == "gravity")
        return _self.gravity;
    else if (vname == "gravity_direction")
        return _self.gravity_direction;
    else if (vname == "hspeed")
        return _self.hspeed;
    else if (vname == "vspeed")
        return _self.vspeed;
    else if (vname == "speed")
        return _self.speed;
    else if (vname == "direction")
        return _self.direction;
    else if (vname == "path_position")
        return _self.path_position;
    else if (vname == "path_positionprevious")
        return _self.path_positionprevious;
    else if (vname == "path_speed")
        return _self.path_speed;
    else if (vname == "path_scale")
        return _self.path_scale;
    else if (vname == "path_orientation")
        return _self.path_orientation;
    else if (vname == "path_endaction")
        return _self.path_endaction;
    else if (vname == "timeline_index")
        return _self.timeline_index;
    else if (vname == "timeline_running")
        return _self.timeline_running;
    else if (vname == "timeline_speed")
        return _self.timeline_speed;
    else if (vname == "timeline_position")
        return _self.timeline_position;
    else if (vname == "timeline_loop")
        return _self.timeline_loop;
    else if (vname == "bbox_left")
        return _self.bbox_left;
    else if (vname == "bbox_top")
        return _self.bbox_top;
    else if (vname == "bbox_right")
        return _self.bbox_right;
    else if (vname == "bbox_bottom")
        return _self.bbox_bottom;
    else if (vname == "sprite_width")
        return _self.sprite_width;
    else if (vname == "sprite_height")
        return _self.sprite_height;
    else if (vname == "sprite_xoffset")
        return _self.sprite_xoffset;
    else if (vname == "sprite_yoffset")
        return _self.sprite_yoffset;
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
    else if (vname == "pi")
        return pi;
    if (vname == "c_white")
        return c_white;
    if (vname == "c_black")
        return c_black;
    if (vname == "c_dkgrey")
        return c_dkgrey;
    if (vname == "c_dkgray")
        return c_dkgray;
    if (vname == "c_grey")
        return c_grey;
    if (vname == "c_gray")
        return c_gray;
    if (vname == "c_ltgrey")
        return c_ltgrey;
    if (vname == "c_ltgray")
        return c_ltgray;
    if (vname == "c_silver")
        return c_silver;
    if (vname == "c_blue")
        return c_blue;
    if (vname == "c_lime")
        return c_lime;
    if (vname == "c_red")
        return c_red;
    if (vname == "c_navy")
        return c_navy;
    if (vname == "c_green")
        return c_green;
    if (vname == "c_maroon")
        return c_maroon;
    if (vname == "c_aqua")
        return c_aqua;
    if (vname == "c_fuchsia")
        return c_fuchsia;
    if (vname == "c_yellow")
        return c_yellow;
    if (vname == "c_olive")
        return c_olive;
    if (vname == "c_purple")
        return c_purple;
    if (vname == "c_teal")
        return c_teal;
    if (vname == "c_orange")
        return c_orange;
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
    else if (vname == "alarm")
        return _self.alarm[j];
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

/// gigFunction(function_name, argc, argv)
/// this script is not generated automatically, unfortunately.
/// It is currently far from complete.
/// feel free to add to it!

var argc = argument1;
var argv = argument2;

var a0, a1, a2, a3, a4, a5, a6, a7, a8, a9;
if (argc >= 1)
    a0 = argv[0];
if (argc >= 2)
    a1 = argv[1];
if (argc >= 3)
    a2 = argv[2];
if (argc >= 4)
    a3 = argv[3];
if (argc >= 5)
    a4 = argv[4];
if (argc >= 6)
    a5 = argv[5];
if (argc >= 7)
    a6 = argv[6];
if (argc >= 8)
    a7 = argv[7];
if (argc >= 9)
    a8 = argv[8];

var fname = argument0;

var script_index = asset_get_index(fname);

if (script_index >= 0 && script_exists(script_index))
{
    var scriptIndex = asset_get_index(fname);
    switch(argc)
    {
    case 0:
        return script_execute(scriptIndex);
    case 1:
        return script_execute(scriptIndex, a0);
    case 2:
        return script_execute(scriptIndex, a0, a1);
    case 3:
        return script_execute(scriptIndex, a0, a1, a2);
    case 4:
        return script_execute(scriptIndex, a0, a1, a2, a3);
    case 5:
        return script_execute(scriptIndex, a0, a1, a2, a3, a4);
    case 6:
        return script_execute(scriptIndex, a0, a1, a2, a3, a4, a5);
    case 7:
        return script_execute(scriptIndex, a0, a1, a2, a3, a4, a5, a6);
    case 8:
        return script_execute(scriptIndex, a0, a1, a2, a3, a4, a5, a6, a7);
    case 9:
        return script_execute(scriptIndex, a0, a1, a2, a3, a4, a5, a6, a7, a8);
    default:
        global.dll_gigExecutionError = 2;
        return false;
    }
}

if (fname == "make_color_rgb" || fname == "make_colour_rgb")
    return make_colour_rgb(a0, a1, a2);
else if (fname == "make_color_hsv" || fname == "make_colour_hsv")
    return make_colour_hsv(a0, a1, a2);
else if (fname == "abs")
    return abs(a0);  
else if (fname == "show_debug_message")
    return show_debug_message(a0);
else if (fname == "sign")
    return sign(a0);
else if (fname == "point_distance")
    return point_distance(a0, a1, a2, a3);
else if (fname == "point_direction")
    return point_direction(a0, a1, a2, a3);
else if (fname == "floor")
    return floor(a0);
else if (fname == "round")
    return round(a0);
else if (fname == "ceil")
    return ceil(a0);
else if (fname == "degtorad")
    return degtorad(a0);
else if (fname == "radtodeg")
    return radtodeg(a0);
else if (fname == "cos")
    return cos(a0);
else if (fname == "sin")
    return sin(a0);
else if (fname == "tan")
    return tan(a0);
else if (fname == "arctan")
    return arctan(a0);
else if (fname == "arctan2")
    return arctan2(a0, a1);
else if (fname == "arcsin")
    return arcsin(a0);
else if (fname == "arccos")
    return arccos(a0);
else if (fname == "lengthdir_x")
    return lengthdir_x(a0, a1);
else if (fname == "lengthdir_y")
    return lengthdir_y(a0, a1);
else if (fname == "random")
    return random(a0);
else if (fname == "random_range")
    return random_range(a0, a1);
else if (fname == "irandom")
    return irandom(a0);
else if (fname == "irandom_range")
    return irandom_range(a0, a1);
else if (fname == "place_meeting")
    return place_meeting(a0, a1, a2);
else if (fname == "position_meeting")
    return position_meeting(a0, a1, a2);
else if (fname == "instance_destroy")
    {
        if (argc == 1)
        {
            return instance_destroy(a0);
        }
        else
        {
            return instance_destroy();
        }
    }
else if (fname == "instance_create")
    return instance_create(a0, a1, a2);
else if (fname == "instance_change")
    return instance_change(a0, a1);
else if (fname == "instance_nearest")
    return instance_nearest(a0, a1, a2);
else if (fname == "instance_number")
    return instance_number(a0);
else if (fname == "instance_position")
    return instance_position(a0, a1, a2);
else if (fname == "instance_find")
    return instance_find(a0, a1);
else if (fname == "instance_furthest")
    return instance_furthest(a0, a1, a2);
else if (fname == "instance_copy")
    return instance_copy(a0);
else if(fname == "ds_map_find_value")
    return ds_map_find_value(a0,a1);
else if(fname == "ds_map_replace")
    return ds_map_replace(a0, a1, a2);
else if (fname ==  "ds_list_find_index")
    return ds_list_find_index(a0,a1);
else if (fname == "ds_list_set")
    return ds_list_set(a0,a1,a2);
else if (fname == "ds_grid_add")
    return ds_grid_add(a0,a1,a2, a3);
else if (fname == "tile_layer_delete")
    return tile_layer_delete(a0);
else if (fname == "tile_layer_show")
    return tile_layer_show(a0);
else if (fname == "tile_layer_hide")
    return tile_layer_hide(a0);
else if (fname == "tile_layer_depth")
    return tile_layer_depth(a0, a1);
else if (fname == "tile_get_id")
    return tile_get_id(a0);
else if (fname == "tile_get_ids")
    return tile_get_ids();
else if (fname == "tile_get_ids_at_depth")
    return tile_get_ids_at_depth(a0);
else if (fname == "instance_exists")
    return instance_exists(a0);
else if (fname == "string")
    return string(a0);
else if (fname == "string_lower")
    return string_lower(a0);
else if (fname == "string_insert")
    return string_insert(a0, a1, a2);
else if (fname == "sprite_get_number")
    return sprite_get_number(a0);
else if (fname == "tile_add")
    return tile_add(a0,a1,a2,a3,a4,a5,a6,a7);
else if (fname == "collision_rectangle")
    return collision_rectangle(a0, a1, a2, a3, a4, a5, a6);
else if (fname == "collision_point")
        return collision_point(a0,a1,a2,a3,a4);
else if (fname == "event_perform")
    return event_perform(a0, a1);
else if (fname == "event_perform_object")
    return event_perform_object(a0, a1, a2);
else if(fname == "event_user")
    return event_user(a0);
else if (fname == "sprite_set_offset") //DONT USE!!!!!
    return sprite_set_offset(a0, a1, a2);
else if (fname == "choose") //need to do this so it accepts varying argument counts
{
    if (argc == 2)
    {
        return choose(a0);
    }
    else if (argc == 3)
    {
        return choose(a0, a1);
    }
    else if (argc == 4)
    {
        return choose(a0, a1, a2);
    }
    else if (argc == 5)
    {
        return choose(a0, a1, a2, a3);
    }  
    else if (argc == 6)
    {
        return choose(a0, a1, a2, a3, a4);
    }
    else if (argc == 7)
    {
        return choose(a0, a1, a2, a3, a4, a5);
    } 
    else if (argc == 8)
    {
        return choose(a0, a1, a2, a3, a4, a5, a6);
    }
    else if (argc == 9)
    {
        return choose(a0, a1, a2, a3, a4, a5, a6, a7);
    }
}  
else if (fname == "action_another_room")
    return action_another_room(a0);
else if (fname == "action_bounce")
    return action_bounce(a0, a1);
else if (fname == "action_change_object")
    return action_change_object(a0, a1);
else if (fname == "action_color")
    return action_color(a0);
else if (fname == "action_create_object")
    return action_create_object(a0, a1, a2);
else if (fname == "action_create_object_motion")
    return action_create_object_motion(a0, a1, a2, a3, a4);
else if (fname == "action_create_object_random")
    return action_create_object_random(a0, a1, a2, a3 ,a4 , a5);
else if (fname == "action_current_room")
    return action_current_room();
else if (fname == "action_draw_arrow")
    return action_draw_arrow(a0, a1, a2, a3, a4);
else if (fname == "action_draw_background")
    return action_draw_background(a0, a1, a2, a3);
else if (fname == "action_draw_ellipse")
    return action_draw_ellipse(a0, a1, a2, a3, a4);
else if (fname == "action_draw_ellipse_gradient")
    return action_draw_ellipse_gradient(a0, a1, a2, a3, a4, a5);   
else if (fname == "action_draw_gradient_hor")
    return action_draw_gradient_hor(a0, a1, a2, a3, a4, a5);
else if (fname == "action_draw_gradient_vert")
    return action_draw_gradient_vert(a0, a1, a2, a3, a4, a5);
else if (fname == "action_draw_health")
    return action_draw_health(a0, a1, a2, a3, a4, a5);
else if (fname == "action_draw_life")
    return action_draw_life(a0, a1, a2);   
else if (fname == "action_draw_life_images")
    return action_draw_life_images(a0, a1, a2);
else if (fname == "action_draw_line")
    return action_draw_line(a0, a1, a2, a3);
else if (fname == "action_draw_rectangle")
    return action_draw_rectangle(a0, a1, a2, a3, a4);
else if (fname == "action_draw_score")
    return action_draw_score(a0, a1, a2);
else if (fname == "action_draw_sprite")
    return action_draw_sprite(a0, a1, a2, a3)
else if (fname == "action_draw_text")
    return action_draw_text(a0, a1, a2);
else if (fname == "action_draw_text_transformed")
    return action_draw_text_transformed(a0, a1, a2, a3, a4, a5);
else if (fname == "action_draw_variable")
    return action_draw_variable(a0, a1, a2);
else if (fname == "action_effect")
    return action_effect(a0, a1, a2, a3, a4, a5)
else if (fname == "action_end_game")
    action_end_game();
else if (fname == "action_execute_script")
    return action_execute_script(a0, a1, a2, a3, a4, a5);
else if (fname == "action_font")
    return action_font(a0, a1);
else if (fname == "action_fullscreen")
    return action_fullscreen(a0);
else if (fname == "action_highscore_clear")
    action_highscore_clear();
else if (fname == "action_if")
    return action_if(a0);
else if (fname == "action_if_aligned")
    return action_if_aligned(a0, a1);  
else if (fname == "action_if_collision")
    return action_if_collision(a0, a1, a2);
else if (fname == "action_if_dice")
    return action_if_dice(a0);
else if (fname == "action_if_empty")
    return action_if_empty(a0, a1, a2);  
else if (fname == "action_if_health")
    return action_if_health(a0, a1);    
else if (fname == "action_if_life")
    return action_if_life(a0, a1);
else if (fname == "action_if_mouse")
    return action_if_mouse(a0);  
else if (fname == "action_if_next_room")
    action_if_next_room();
else if (fname == "array_length_1d")
    array_length_1d(a0);
else if (fname == "array_length_2d")
    array_length_2d(a0, a1);
else if (fname == "is_undefined")
    return is_undefined(a0);
else if (fname == "event_inherited")
    event_inherited();
else if (fname == "instance_place")
    return instance_place(a0, a1, a2);
else if (fname == "variable_global_exists")
    return variable_global_exists(a0);
else if (fname == "variable_instance_get")
    return variable_instance_get(a0, a1);
else if (fname == "ds_list_add")
    return ds_list_add(a0, a1);
else if (fname == "ds_list_clear")
    return ds_list_clear(a0);
else if (fname == "room_get_name")
    return room_get_name(a0);
else if (fname == "object_is_ancestor")
        return object_is_ancestor(a0,a1);
else if (fname == "shader_reset")
        return shader_reset();
else if(false)
{
    if (fname == "sprite_exists")
        return sprite_exists(a0);
    else if (fname == "sprite_add")
        return sprite_assign(a0,a1);
    else if (fname == "sprite_replace")
        return sprite_replace(a0,a1,a2,a3,a4,a5,a6);
    else if (fname == "sprite_duplicate")
        return sprite_duplicate(a0);
    else if (fname == "sprite_assign")
        return sprite_assign(a0,a1);
    else if (fname == "sprite_merge")
        return sprite_merge(a0,a1);
    else if (fname == "sprite_collision_mask")
        return sprite_collision_mask(a0,a1,a2,a3,a4,a5,a6,a7,a8);
    else if (fname == "sprite_set_offset")
        return sprite_set_offset(a0,a1,a2);
    else if (fname == "sprite_delete")
        return sprite_delete(a0);
    else if (fname == "background_exists")
        return background_exists(a0);
    else if (fname == "background_add")
        return background_add(a0,a1,a2);
    else if (fname == "background_replace")
        return background_replace(a0,a1,a2,a3);
    else if (fname == "background_duplicate")
        return background_duplicate(a0);
    else if (fname == "background_assign")
        return background_assign(a0,a1);
    else if (fname == "background_delete")
        return background_delete(a0);
    else if (fname == "audio_create_stream")
        return audio_create_stream(a0);
    else if (fname == "audio_destroy_stream")
        return audio_destroy_stream(a0);
    else if (fname == "room_instance_add")
        return room_instance_add(a0,a1,a2,a3);
    else if (fname == "room_instance_clear")
        return room_instance_clear(a0);
    else if (fname == "room_tile_add")
        return room_tile_add(a0,a1,a2,a3,a4,a5,a6,a7,a8);
    else if (fname == "room_tile_clear")
        return room_tile_clear(a0);
    else if (!DEBUG_ENABLED)//Bail here when no debug.
    {
        global.dll_gigExecutionError = 1;
    }
}
else if (DEBUG_ENABLED)//Debug exclusive functions.
{
    if (fname == "get_string")
    {
        printErr("Debug ACE Only");
        return get_string(a0,a1);
    }
    else if (fname == "get_timer")//Need for leaderboard testing.
    {
        printErr("Debug ACE Only");
        return get_timer();
    }
    else if (fname == "real")
    {
        printErr("Debug ACE Only");
        return real(a0);
    }
    else if (fname == "asset_get_index")
    {
        printErr("Debug ACE Only");
        return asset_get_index(a0);
    }
    else if (fname == "sprite_save")
    {
        printErr("Debug ACE Only");
        return sprite_save(a0,a1,a2);
    }
    else if (fname == "window_set_caption")
    {
        printErr("Debug ACE Only");
        return window_set_caption(a0);
    }
    else if (fname == "get_open_filename")
    {
        printErr("Debug ACE Only");
        return get_open_filename(a0,a1);
    }
    else if (fname == "get_open_filename_ext")
    {
        printErr("Debug ACE Only");
        return get_open_filename_ext(a0,a1,a2,a3);
    }
    else
    {
        global.dll_gigExecutionError = 1;
    }
}
else
    global.dll_gigExecutionError = 1;
return 0;

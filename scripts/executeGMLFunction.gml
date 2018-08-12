/// executeGMLFunction(function_name, args...)
/// this script is not generated automatically, unfortunately.
/// feel free to add to it!

global.execute_gml_function_ERR = false;

var a0, a1, a2, a3, a4, a5, a6, a7, a8;
if (argument_count > 1)
    a0 = argument[1];
if (argument_count > 2)
    a1 = argument[2];
if (argument_count > 3)
    a2 = argument[3];
if (argument_count > 4)
    a3 = argument[4];
if (argument_count > 5)
    a4 = argument[5];
if (argument_count > 6)
    a5 = argument[6];
if (argument_count > 7)
    a6 = argument[7];
if (argument_count > 8)
    a7 = argument[8];

var fname = argument[0];

global.gml_fn_retval = 0;

if (fname == "make_color_rgb" || fname == "make_colour_rgb")
    global.gml_fn_retval = make_colour_rgb(a0, a1, a2);
else if (fname == "make_color_hsv" || fname == "make_colour_hsv")
    global.gml_fn_retval = make_colour_hsv(a0, a1, a2);
else if (fname == "abs")
    global.gml_fn_retval = abs(a0);
else if (fname == "action_another_room")
    global.gml_fn_retval = action_another_room(a0);
else if (fname == "action_bounce")
    global.gml_fn_retval = action_bounce(a0, a1);
else if (fname == "action_change_object")
    global.gml_fn_retval = action_change_object(a0, a1);
else if (fname == "action_color")
    global.gml_fn_retval = action_color(a0);
else if (fname == "action_create_object")
    global.gml_fn_retval = action_create_object(a0, a1, a2);
else if (fname == "action_create_object_motion")
    global.gml_fn_retval = action_create_object_motion(a0, a1, a2, a3, a4);
else if (fname == "action_create_object_random")
    global.gml_fn_retval = action_create_object_random(a0, a1, a2, a3 ,a4 ,a5);
else if (fname == "action_current_room")
    action_current_room();
else if (fname == "action_draw_arrow")
    global.gml_fn_retval = action_draw_arrow(a0, a1, a2, a3, a4);
else if (fname == "action_draw_background")
    global.gml_fn_retval = action_draw_background(a0, a1, a2, a3);
else if (fname == "action_draw_ellipse")
    global.gml_fn_retval = action_draw_ellipse(a0, a1, a2, a3, a4);
else if (fname == "action_draw_ellipse_gradient")
    global.gml_fn_retval = action_draw_ellipse_gradient(a0, a1, a2, a3, a4, a5);   
else if (fname == "action_draw_gradient_hor")
    global.gml_fn_retval = action_draw_gradient_hor(a0, a1, a2, a3, a4, a5);
else if (fname == "action_draw_gradient_vert")
    global.gml_fn_retval = action_draw_gradient_vert(a0, a1, a2, a3, a4, a5);
else if (fname == "action_draw_health")
    global.gml_fn_retval = action_draw_health(a0, a1, a2, a3, a4, a5);
else if (fname == "action_draw_life")
    global.gml_fn_retval = action_draw_life(a0, a1, a2);   
else if (fname == "action_draw_life_images")
    global.gml_fn_retval = action_draw_life_images(a0, a1, a2);
else if (fname == "action_draw_line")
    global.gml_fn_retval = action_draw_line(a0, a1, a2, a3)      
else if (fname == "sign")
    global.gml_fn_retval = sign(a0);
else if (fname == "point_distance")
    global.gml_fn_retval = point_distance(a0, a1, a2, a3);
else if (fname == "point_direction")
    global.gml_fn_retval = point_direction(a0, a1, a2, a3);
else if (fname == "degtorad")
    global.gml_fn_retval = degtorad(a0);
else if (fname == "radtodeg")
    global.gml_fn_retval = radtodeg(a0);
else if (fname == "cos")
    global.gml_fn_retval = cos(a0);
else if (fname == "sin")
    global.gml_fn_retval = sin(a0);
else if (fname == "tan")
    global.gml_fn_retval = tan(a0);
else if (fname == "arctan")
    global.gml_fn_retval = arctan(a0);
else if (fname == "arctan2")
    global.gml_fn_retval = arctan2(a0, a1);
else if (fname == "arcsin")
    global.gml_fn_retval = arcsin(a0);
else if (fname == "arccos")
    global.gml_fn_retval = arccos(a0);
else if (fname == "random")
    global.gml_fn_retval = random(a0);
else if (fname == "random_range")
    global.gml_fn_retval = random_range(a0, a1);
else if (fname == "irandom")
    global.gml_fn_retval = irandom(a0);
else if (fname == "irandom_range")
    global.gml_fn_retval = irandom_range(a0, a1);
else if (fname == "place_meeting")
    global.gml_fn_retval = place_meeting(a0, a1, a2);
else if (fname == "position_meeting")
    global.gml_fn_retval = position_meeting(a0, a1, a2);
else if (fname == "instance_destroy")
    instance_destroy();
else if (fname == "instance_create")
    instance_create(a0, a1, a2);
else if (fname == "tile_layer_delete")
    tile_layer_delete(a0);
else if (fname == "tile_layer_show")
    tile_layer_show(a0);
else if (fname == "tile_layer_hide")
    tile_layer_hide(a0);
else if (fname == "instance_exists")
    global.gml_fn_retval = instance_exists(a0);
else if (fname == "string")
    global.gml_fn_retval = string(a0);
else if (fname == "floor")
    global.gml_fn_retval = floor(a0);
else if (fname == "round")
    global.gml_fn_retval = round(a0);
else if (fname == "ceil")
    global.gml_fn_retval = ceil(a0);
else if (fname == "tile_add")
    global.gml_fn_retval = tile_add(a0,a1,a2,a3,a4,a5,a6,a7);
else if (fname == "collision_rectangle")
    global.gml_fn_retval = collision_rectangle(a0, a1, a2, a3, a4, a5, a6);
else if (fname == "event_perform")
    global.gml_fn_retval = event_perform(a0, a1);
else if (fname == "event_perform_object")
    global.gml_fn_retval = event_perform_object(a0, a1, a2);
else
    global.execute_gml_function_ERR = true;
return 0;

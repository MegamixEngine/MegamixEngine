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

var fname = argument[0];

global.gml_fn_retval = 0;

if (fname == "make_color_rgb" || fname == "make_colour_rgb")
    global.gml_fn_retval = make_colour_rgb(a0, a1, a2);
else if (fname == "make_color_hsv" || fname == "make_colour_hsv")
    global.gml_fn_retval = make_colour_hsv(a0, a1, a2);
else if (fname == "abs")
    global.gml_fn_retval = abs(a0);
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
else
    global.execute_gml_function_ERR = true;
return 0;

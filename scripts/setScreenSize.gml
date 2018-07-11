// setScreenSize(screenSize, [shift])
// argument0: screen size
// argument1: shift screen to centre? default: true

var ns = argument[0];
var shift = true;
if (argument_count > 1)
{
    shift = argument[1];
}
var xsize = global.screenWidth;
var ysize = global.screenHeight;
var full = 0;

var s = max(1, min(ns, display_get_height() / ysize, display_get_width() / xsize));

full = ns > s;
    
window_set_fullscreen(full);

if (!full)
{
    s = ceil(s);
    
    xsize *= s;
    ysize *= s;
    
    window_set_size(xsize, ysize);
    
    if (shift)
    {
        window_set_position(
            floor((display_get_width() - xsize) / 2),
            floor((display_get_height() - ysize) / 2));
    }
}

global.screensize = s;

surface_resize(application_surface, view_wview[0] * global.screensize, view_hview[0] * global.screensize + (global.screensize == 1));

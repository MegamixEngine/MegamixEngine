// setScreenSize(screenSize, [shift])
// argument0: screen size
// argument1: shift screen to centre? default: true

var ns = argument[0];
var shift = true;
if (argument_count > 1)
{
    shift = argument[1];
}

var xsize, ysize, s, full;

xsize = global.screenWidth;
ysize = global.screenHeight;

s = max(1, min(ns, display_get_height() / ysize, display_get_width() / xsize));

full = ns > s;
    
window_set_fullscreen(full);

if (!full)
{
    s = ceil(s);
    
    xsize *= s;
    ysize *= s;

    global.screensize = s; // not set when going to fullscreen so that you can go back to the previous screensize when exiting fullscreen with f4
    
    window_set_size(xsize, ysize);
    window_set_cursor(cr_default);
    
    if (shift)
    {
        window_set_position(
            floor((display_get_width() - xsize) / 2),
            floor((display_get_height() - ysize) / 2));
    }
}
else
{
    window_set_cursor(cr_none);
}

surface_resize(application_surface, view_wview[0] * s, view_hview[0] * s);

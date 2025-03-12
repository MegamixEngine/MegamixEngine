/// setScreenSize(scale, ...)
// setScreenSize(screenSize, [shift])
// argument0: screen size
// argument1: shift screen to centre? default: true

//----------------------------------------------------
// - Get our arguments -

var scale = ceil(argument[0]);

var shift = true;
if (argument_count > 1)
{
    shift = argument[1];
}

//----------------------------------------------------
// - Determine size, ratio and scale -

var xsize = global.screenWidth;
var ysize = global.screenHeight;

if (global.screenRatio) // Radical 3:4 :)
{
    xsize *= 1.17; //28/24; Because gms hates more than two decimal points, manually round up here.
}

//Additional space for UI-Border
var border = 0;

if (global.borderVisibility || global.fullscreen) //Visibility check
{
    border = global.fullscreenBorder;
}

//Maximum possible scale
var maxScale = min(display_get_height() / ysize, display_get_width() / xsize);

//Cap the scale
var scale = clamp(scale, 1, maxScale);
    //scale = floorTo(scale, 0.1); //Let's only have 1 decimal at most

//----------------------------------------------------
// - Decide if fullscreen - (0: NO | 1: YES | 2: ABSOLUTE)

var isfull = window_get_fullscreen(); //Is fullscreen?
var setfull = (global.fullscreen >= 2); //Should be fullscreen?

if (isfull != setfull) //If 'is' and 'set' are not the same - Toggle
{
    window_set_fullscreen(setfull);
    isfull = setfull;
}
var forcePosition = false;
if (global.fullscreen != global.fullscreenprevious)
{
    if (!global.fullscreen)
    {
        forcePosition = true;
    }
    global.fullscreenprevious = global.fullscreen;
}
//----------------------------------------------------

if (!setfull) //Not in borderless fullscreen
{
    var oldwidth  = window_get_width();
    var oldheight = window_get_height();
    
    var displayWidth  = display_get_width();
    var displayHeight = display_get_height();
    
    if (global.fullscreen) //Quasi-fullscreen
    {
        //Set new size
        window_set_size(displayWidth, displayHeight);
        
        //Position will be set in the step-event of objGlobalControl
        with(objGlobalControl)
        {
            adjustScreen = 5;
            if (room == rmInit)
            {
                adjustScreen = 15;
            }
        }
        
        if (global.initfullscreen)
        {
            window_set_fullscreen(1);
        }
    }
    else //No fullscreen
    {
        if (border) //Add extra space for decorative borders
        {
            xsize = min(480 * scale, displayWidth);
            ysize = min(270 * scale, displayHeight);
        }
        else
        {
            xsize *= scale;
            ysize *= scale;
        }
        
        //Set new size
        window_set_size(xsize, ysize);
        
        //If the window bar is above the screen (we transitioned from pseudo-borderless fullscreen), bring it back down. So the user can actually move it.
        if (window_get_y() < 30 && forcePosition)
        {
            window_set_position(window_get_x(),30);
        }
        
        //Adjust position towards center - If size has changed
        if (oldwidth != xsize) || (oldheight != ysize)
        {
            var xpos = floor((displayWidth  - xsize) / 2);
            var ypos = floor((displayHeight - ysize) / 2);
            
            window_set_position(xpos, ypos);
        }
    }
}

//----------------------------------------------------
// - Set cursor -

if (global.fullscreen && global.mouseType != 1) //Any fullscreen
{
    window_set_cursor(cr_none);
}
else //Not in fullscreen
{
    window_set_cursor(cr_default);
}

//----------------------------------------------------
// - Resize that application_surface and GUI

var surfaceWidth  = view_wview[0];
var surfaceHeight = view_hview[0];

if (global.screenShader < SHADERS_1XSTART)
{
    surfaceWidth  *= scale;
    surfaceHeight *= scale;
}

surface_resize(application_surface, surfaceWidth, surfaceHeight);

global.screensize = scale;

//This is required in order to keep GUI consistent between 1.4.1804 and 1.4.9999.
display_set_gui_maximise();

//----------------------------------------------------

// We gotta do this or else the shader-object is gonna have a stroke
with (objShaderControl)
{
    instance_destroy();
}

instance_create(0, 0, objShaderControl);



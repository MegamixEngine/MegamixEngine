/// playerCamera(instantaneous)
// argument0: 1 = focus on Mega Man instantaneously
// Handles the camera

var playerx = 0;
var playery = 0;
var playerNumber = 0;

var instantx = argument0;
var instanty = argument0;
var xsp = 0;

global.prevXView = view_xview[0];
global.prevYView = view_yview[0];
view_xview[0] = global.cachedXView;
view_yview[0] = global.cachedYView;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// Average location of players
with (objMegaman)
{
    if (viewPlayer && (!teleporting || teleporting && global.hasTeleported))
    {
        // Nothing special for x-coordinate
        playerx += x;
        xsp += abs(xspeed);
        
        // Special stuff for y-coordinate
        
        // Focus instantaneously
        if (argument0)
        {
            playery += y;
        }
        else // Otherwise do this
        {
            if (ground)
            {
                playery += y;
            }
            else
            {
                var ydiv = y - (view_yview + view_hview * 0.5);
                
                var threshold = (view_hview * 0.2);
                
                if (abs(ydiv) >= threshold)
                {
                    playery += y - (threshold * sign(ydiv));
                    instanty = 1;
                }
            }
        }
        
        playerNumber ++;
    }
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// Follow the players
if (playerNumber > 0)
{
    if (playerx != 0) // X-coordinates
    {
        playerx = (playerx / playerNumber) - (view_wview[0] * 0.5);
        
        if (instantx)
        {
            view_xview[0] = playerx;
        }
        else if (!global.frozen)
        {
            var xdif = playerx - view_xview[0];
            
            var xshift = min(ceil(xsp / playerNumber), abs(xdif)); // Camera-shift can't exceed xspeed
                xshift = max(xshift, abs(xdif) / 4); // But can't be less than a 1/4 of the x-difference
            
            view_xview[0] += (xshift * sign(xdif));
        }
    }
    
    if (playery != 0) // Y-coordinates
    {
        playery = (playery / playerNumber) - (view_hview[0] * 0.5);
        
        if (instanty)
        {
            view_yview[0] = playery;
        }
        else if (!global.frozen)
        {
            view_yview[0] += ((playery - view_yview[0]) / 8);
        }
    }
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// Stop at section borders
var bound_left      = max(global.sectionLeft, global.borderLockLeft),
    bound_right     = min(global.sectionRight, global.borderLockRight) - view_wview[0],
    bound_top       = max(global.sectionTop + global.quadMarginTop, global.borderLockTop),
    bound_bottom    = min(global.sectionBottom - global.quadMarginBottom, global.borderLockBottom) - view_hview[0];

view_xview[0] = clamp(view_xview[0], bound_left, bound_right);
view_yview[0] = clamp(view_yview[0], bound_top , bound_bottom);

//view_xview[0] = roundTo(view_xview[0], 1 / global.screensize);
//view_yview[0] = roundTo(view_yview[0], 1 / global.screensize);

if (global.roundCamera)
{
    view_xview[0] = round(view_xview[0]);
    view_yview[0] = round(view_yview[0]);
}

//printErr(string(view_xview[0]));

// cached
global.cachedXView = view_xview[0];
global.cachedYView = view_yview[0];


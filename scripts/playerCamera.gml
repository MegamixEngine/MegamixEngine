/// playerCamera(instantaneous)
// argument0: 1 = focus on Mega Man instantaneously
// Handles the camera

var vx = 0;
var vy = 0;
var vn = 0;
var fc = 0;
var inx = argument0;
var iny = argument0;
var xsp = 0;

global.prevXView = view_xview[0];
global.prevYView = view_yview[0];
view_xview[0] = global.cachedXView;
view_yview[0] = global.cachedYView;

// average location of players
with (objMegaman)
{
    if (viewPlayer && (!teleporting || teleporting && global.hasTeleported))
    {
        vx += x;
        xsp += abs(xspeed);
        
        // Focus instantaneously
        if (argument0)
        {
            vy += y;
        } // otherwise do this
        else
        {
            if (ground)
            {
                vy += y;
            }
            else
            {
                var ydiv = y - (view_yview + view_hview * 0.5);
                if (abs(ydiv) >= (view_hview * 0.2))
                {
                    vy += y - ((view_hview * 0.2) * sign(ydiv));
                    iny = 1;
                }
            }
        }
        vn += 1;
    }
}

// Follow the players
if (vn != 0)
{
    if (vx != 0)
    {
        vx = (vx / vn) - view_wview * 0.5;
        
        if (inx)
        {
            view_xview = vx;
        }
        else if (!global.frozen)
        {
            view_xview += (max(min(ceil(xsp / vn), abs(vx - view_xview)), abs(vx - view_xview) / 4)) * sign(vx - view_xview);
        }
    }
    if (vy != 0)
    {
        vy = (vy / vn) - view_hview * 0.5;
        
        if (iny)
        {
            view_yview = vy;
        }
        else if (!global.frozen)
        {
            view_yview += ((vy - view_yview) / 8);
        }
    }
}

// Stop at section borders
var bound_left = max(global.sectionLeft, global.borderLockLeft),
    bound_right = min(global.sectionRight, global.borderLockRight) - view_wview,
    bound_top = max(global.sectionTop + global.quadMarginTop, global.borderLockTop),
    bound_bottom = min(global.sectionBottom - global.quadMarginBottom, global.borderLockBottom) - view_hview;

view_xview = clamp(view_xview, bound_left, bound_right);
view_yview = clamp(view_yview, bound_top, bound_bottom);

view_xview = round(view_xview);
view_yview = round(view_yview);

// cached
global.cachedXView = view_xview[0];
global.cachedYView = view_yview[0];

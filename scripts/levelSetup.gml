///levelSetup()

if (DEBUG_SPAWN && DEBUG_ENABLED)
{
    show_debug_message("Level Setup: " + global.roomName);
}

// - - - - - - - - - - - - - - - - - -

for (var i = 0; i < MAX_PLAYERS; i++)
{
    respawnTimer[i] = 0;
    respawnLocation[i] = -1;
}

global.sectionLeft = 0;
global.sectionRight = room_width;
global.sectionTop = 0;
global.sectionBottom = room_height;

global.borderLockLeft = 0;
global.borderLockRight = room_width;
global.borderLockTop = 0;
global.borderLockBottom = room_height;

global.aliveBosses       = 0;
global.lockTransition    = false;
global.switchingSections = false;

//Control key-collection variables
global.keyNumber = 0;

showhealth = 1;

// - - - - - - - - - - - - - - - - - -

// set room settings
view_enabled = true;
view_visible[0] = true;
room_speed = 60;

// quadrant size
for (i = 0; i <= 7; i ++;)
{
    if (string_pos("bgQuad", background_get_name(background_index[i])) == 1)
    {
        global.quadWidth = background_get_width(background_index[i]);
        global.quadHeight = background_get_height(background_index[i]);
        global.quadMarginTop = (global.quadHeight - view_hview[0]) / 2;
        global.quadMarginBottom = global.quadMarginTop;
        background_index[i] = -1;
    }
}

view_wview[0] = global.quadWidth;

// Destroy collected pickups
disableRespawnExecute();

// Place section borders
for (       var v = 0; v < room_height; v += global.quadHeight;)
{
    for (   var i = 0; i < room_width;  i += global.quadWidth;)
    {
        with (instance_create(i, v, objStopScrollingVertical))
        {
            image_xscale = global.quadWidth / sprite_get_width(sprite_index);
        }
    }
}

// Delete vertical border to make vertical scrolling possible
with (objStopScrollingVertical)
{
    if (place_meeting(x, y, objSectionFreeVerticalScrolling))
    {
        instance_destroy();
    }
}

var checkRange = 16;

// Connect Horizontal borders
with (objStopScrollingHorizontal)
{
    if (instance_exists(self))
    {
        while (place_meeting(       x, y + checkRange, objStopScrollingHorizontal))
        {
            var i = instance_place( x, y + checkRange, objStopScrollingHorizontal)
            
            if (i)
            {
                // cannot grow upward.
                if (i.y < y) break;
                image_yscale += max(0, (i.sprite_height + i.y - sprite_height - y) / sprite_get_height(sprite_index));

                with (i)
                {
                    instance_destroy();
                }
            }
        }
    }
}

// Connect Vertical borders
with (objStopScrollingVertical)
{
    if (instance_exists(self))
    {
        while (place_meeting(       x + checkRange, y, objStopScrollingVertical))
        {
            var i = instance_place( x + checkRange, y, objStopScrollingVertical)
            
            if (i)
            {
                // cannot grow leftward.
                if (i.x < x) break;
                image_xscale += max(0, (i.x + i.sprite_width - x - sprite_width) / sprite_get_width(sprite_index));

                with (i)
                {
                    instance_destroy();
                }
            }
        }
    }
}

ds_list_clear(global.borderlist);

with (objStopScrollingHorizontal)
{
    if (instance_exists(self))
    {
        ds_list_add(global.borderlist, "h" + string(round(x)) + "s" + string(round(y)) + "e" + string(round(y + sprite_height)));
        
        instance_destroy();
    }
}

with (objStopScrollingVertical)
{
    if (instance_exists(self))
    {
        ds_list_add(global.borderlist, "v" + string(round(y)) + "s" + string(round(x)) + "e" + string(round(x + sprite_width)));
        
        instance_destroy();
    }
}

// combine objects to save on CPU
combineObjects(objSolid);
combineObjects(objSpike);
combineObjects(objDamageSpike);
combineObjects(objIce);
combineObjects(objWater);
combineObjects(objStandSolid);
combineObjects(objTopSolid, true, false);
combineObjects(objLadder, false, true);

with (prtBossDoor)
{
    event_user(3);
}

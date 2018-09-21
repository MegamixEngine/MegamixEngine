/// playerHandleWater();

if (inWater != -1) // If inWater is set to -1 then there can be no interaction with water
{
    var xw = xspeed + hspeed;
    var yw = yspeed + vspeed;
    var _yc = bboxGetYCenter();
    var preWater = inWater;
    var overlapping = instance_place(x, y - 2 * sign(grav), objWater);
    
    if (xw != 0)
    {
        xw = 0;
        if (!collision_rectangle(bbox_left, bbox_top, bbox_left + 8, bbox_bottom, objWater, true, false))
        {
            xw = (bbox_right - bbox_left);
        }
        else if (!collision_rectangle(bbox_right + 8, bbox_top, bbox_right, bbox_bottom, objWater, true, false))
        {
            xw = -(bbox_right - bbox_left);
        }
    }
    if (yw != 0)
    {
        yw = 0;
        if (!collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top + 8, objWater, true, false))
        {
            yw = (bbox_bottom - bbox_top);
        }
        else if (!collision_rectangle(bbox_left, bbox_bottom - 8, bbox_right, bbox_bottom, objWater, true, false))
        {
            yw = -(bbox_bottom - bbox_top);
        }
    }
    
    if (_yc - 4 >= view_yview && _yc + 4 <= view_yview + view_hview) // Don't change state if offscreen
    {
        if (inWater)
        {
            if (!overlapping)
            {
                inWater = 0;
                bubbleTimer = 0;
            }
            else if (preWater == inWater)
            {
                if (faction != 0 && bubbleTimer >= 0)
                {
                    bubbleTimer += 1;
                    if (bubbleTimer >= 64) // F***ING BUBBLES
                    {
                        bubbleTimer = 0;
                        instance_create(bboxGetXCenter(), bboxGetYCenter(), objAirBubble);
                    }
                }
                
                /* if (xw != 0)
                {
                    xw = 0;
                    if (!collision_rectangle(bbox_left, bbox_top, bbox_left + 8, bbox_bottom, objWater, true, false))
                    {
                        xw = (bbox_right - bbox_left);
                        preWater = 0;
                    }
                    else if (!collision_rectangle(bbox_right + 8, bbox_top, bbox_right, bbox_bottom, objWater, true, false))
                    {
                        xw = -(bbox_right - bbox_left);
                        preWater = 0;
                    }
                }
                if (yw != 0)
                {
                    yw = 0;
                    if (!collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_top + 8, objWater, true, false))
                    {
                        yw = (bbox_bottom - bbox_top);
                        preWater = 0;
                    }
                    else if (!collision_rectangle(bbox_left, bbox_bottom - 8, bbox_right, bbox_bottom, objWater, true, false))
                    {
                        yw = -(bbox_bottom - bbox_top);
                        preWater = 0;
                    }
                }*/
            }
        }
        else
        {
            if (overlapping)
            {
                inWater = 1;
            }
        }
    }
    
    if (!overlapping)
    {
        overlapping = instance_place(xprevious - xspeed - hspeed, yprevious - yspeed - vspeed, objWater);
    }
    
    if (preWater != inWater && overlapping != noone) // Has water state changed?
    {
        with (overlapping) // Make splashes
        {
            if (yw != 0)
            {
                if (place_meeting(x, y + yw, other) == preWater)
                {
                    var splash = instance_create(min(max(bboxGetXCenterObject(other.id), bbox_left + 16), bbox_right - 16), bbox_top, objSplash);
                    if (yw * (preWater - other.inWater) > 0)
                    {
                        splash.image_angle += 180;
                        splash.y = bbox_bottom + 1;
                    }
                    with (splash)
                    {
                        event_user(0);
                    }
                }
            }
            if (xw != 0)
            {
                if (place_meeting(x + xw, y, other) == preWater)
                {
                    var splash = instance_create(bbox_left, min(max(bboxGetYCenterObject(other.id), bbox_top + 16), bbox_bottom - 16), objSplash);
                    splash.image_angle = 90;
                    if (xw * (preWater - other.inWater) > 0)
                    {
                        splash.image_angle += 180;
                        splash.x = bbox_right + 1;
                    }
                    with (splash)
                    {
                        event_user(0);
                    }
                }
            }
        }
    }
}

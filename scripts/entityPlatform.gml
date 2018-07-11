/// entityPlatform()

if (isSolid)
{
    if (x != xprevious || y != yprevious)
    {
        var resolid = isSolid;
        isSolid = 0;
        var xypre;
        
        var myyspeed = y - yprevious;
        var myxspeed = x - xprevious;
        y = yprevious;
        x = xprevious;
        
        with (objMegaman)
        {
            savedgrav = grav;
            grav = gravDir;
        }
        
        if (myyspeed != 0) // Vertical
        {
            var flr, cel;
            
            with (prtEntity)
            {
                if (blockCollision && !dead)
                {
                    if (other.fnsolid)
                    {
                        if (global.factionStance[other.faction, faction])
                        {
                            continue;
                        }
                    }
                    
                    var dir = sign(bboxGetYCenterObject(other.id) - bboxGetYCenter());
                    if (dir >= 0)
                    {
                        flr = floor(y);
                        cel = ceil(y);
                    }
                    else
                    {
                        flr = ceil(y);
                        cel = floor(y);
                    }
                    
                    if (place_meeting(x, flr, other.id))
                    {
                        continue;
                    }
                    
                    if (place_meeting(x, flr + sign(grav), other.id)
                        || place_meeting(x, cel - myyspeed, other.id))
                    {
                        other.y += myyspeed;
                        
                        xypre = y;
                        y += myyspeed + (2 * sign(dir));
                        
                        repeat (32)
                        {
                            if (place_meeting(x, y, other.id))
                            {
                                y += dir * -0.5;
                            }
                            else
                            {
                                break;
                            }
                        }
                        
                        xypre = xypre - y;
                        y += xypre;
                        
                        shiftObject(0, -xypre, 1);
                        
                        if (resolid == 1) // Crushing
                        {
                            if (place_meeting(x, y, other.id) && !global.freeMovement)
                            {
                                if (global.factionStance[other.faction, faction])
                                {
                                    event_user(EV_DEATH);
                                }
                            }
                        }
                        
                        if (yspeed == 0 && dir == sign(grav))
                        {
                            ground = true;
                        }
                        
                        other.y -= myyspeed;
                    }
                }
            }
        }
        
        y += myyspeed;
        
        if (myxspeed != 0) // Horizontal
        {
            with (prtEntity)
            {
                if (blockCollision && !dead)
                {
                    if (other.fnsolid)
                    {
                        if (global.factionStance[other.faction, faction])
                        {
                            continue;
                        }
                    }
                    
                    if (place_meeting(x, y, other.id))
                    {
                        continue;
                    }
                    
                    if (object_index == objMegaman)
                    {
                        grav = gravDir;
                    }
                    
                    var dir = sign(bboxGetXCenterObject(other.id) - bboxGetXCenter());
                    
                    if (place_meeting(x, y + sign(grav), other.id))
                    {
                        shiftObject(myxspeed, 0, 1);
                    }
                    
                    if (resolid == 1)
                    {
                        other.x += myxspeed;
                        
                        if (place_meeting(x, y, other.id))
                        {
                            xypre = x;
                            x += myxspeed + (2 * sign(dir));
                            
                            repeat (32)
                            {
                                if (place_meeting(x, y, other.id))
                                {
                                    x += dir * -0.5;
                                }
                                else
                                {
                                    break;
                                }
                            }
                            
                            xypre = xypre - x;
                            x += xypre;
                            
                            shiftObject(-xypre, 0, 1);
                            
                            if (place_meeting(x, y, other.id) && !global.freeMovement) // Crushing
                            {
                                if (global.factionStance[other.faction, faction])
                                {
                                    event_user(EV_DEATH);
                                }
                            }
                        }
                        
                        other.x -= myxspeed;
                    }
                }
            }
        }
        
        x += myxspeed;
        
        isSolid = resolid;
        
        yprevious = y;
        xprevious = x;
        
        with (objMegaman)
        {
            grav = savedgrav;
        }
    }
}

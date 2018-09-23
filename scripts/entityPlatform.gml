/// entityPlatform()

if (isSolid)
{
    if (x != xprevious || y != yprevious)
    {
        var resolid = isSolid;
        isSolid = 0;
        var xypre;
        
        var epCanCrush = object_index!=objMegaman || (object_index==objMegaman && !global.freeMovement);
        
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
                    
                    var epDir = sign(bboxGetYCenterObject(other.id) - bboxGetYCenter());

                    if(place_meeting(x, y, other.id))
                    {
                        continue;
                    }
                    epIsOnPlat=false;
                    
                    var epIsPassenger;
                    var epWillCollide;
                    with(other)
                    {
                        epWillCollide = place_meeting(x, y + myyspeed, other.id); 
                       
                    }
                    epIsPassenger = place_meeting(x, y + sign(grav) + grav + (0.5*sign(grav)*ground), other.id);

                    if (epIsPassenger || epWillCollide)
                    {
                        other.y += myyspeed;
                        
                        xypre = y;
                        if(epIsPassenger)
                        {
                            y += myyspeed;
                        }
                        
                        if( resolid==1 || (resolid==2 && (epDir*sign(grav))>0))
                        {
                            if (place_meeting(x, y, other.id))
                            {
                                y=round(y);
                                y+=epDir*-0.5;
                            }
                            var rpts = max(32,abs(other.bbox_top-other.bbox_bottom)*2);
                            repeat (rpts)
                            {
                                if (place_meeting(x, y, other.id))
                                {
                                    y += epDir * -0.5;
                                }
                                else
                                {
                                    break;
                                }
                            }
                        }
                        xypre = xypre - y;
                        y += xypre;
                        
                        shiftObject(0, -xypre, 1);
                        
                        
                        if (resolid == 1 ) // Crushing
                        {
                            if (epCanCrush&&place_meeting(x, y, other.id))
                            {
                                if (global.factionStance[other.faction, faction])
                                {
                                    event_user(EV_DEATH);
                                }
                            }
                        }
                        
                        if (yspeed == 0 && epDir == sign(grav))
                        {
                            ground = true;
                            epIsOnPlat=true;
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
                if(myyspeed==0)
                {
                    epIsOnPlat=false;
                }
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
                    
                    var epDir = sign(bboxGetXCenterObject(other.id) - bboxGetXCenter());
                    var epImmprecition;
                    if(ground)
                        epImmprecition=0.5*ground;
                    else
                        epImmprecition=max(abs(abs(y)-floor(abs(y))),abs(abs(myyspeed)-floor(abs(myyspeed))));
                    if (epIsOnPlat||place_meeting(x, y + sign(grav)+epImmprecition*sign(grav), other.id))
                    {
                        shiftObject(myxspeed, 0, 1);
                        epIsOnPlat=true;
                    }
                    
                    if (resolid == 1)
                    {
                        other.x += myxspeed;
                        
                        if (!epIsOnPlat&&place_meeting(x, y, other.id))
                        {
                            xypre = x;
                            x += myxspeed + (2 * sign(epDir));
                            var rpts = max(32,abs(other.bbox_right-other.bbox_left)*2);
                            repeat (rpts)
                            {
                                if (place_meeting(x, y, other.id))
                                {
                                    x += epDir * -0.5;
                                }
                                else
                                {
                                    break;
                                }
                            }
                            
                            xypre = xypre - x;
                            x += xypre;
                            
                            shiftObject(-xypre, 0, 1);
                            
                            if (epCanCrush&&place_meeting(x, y, other.id))
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

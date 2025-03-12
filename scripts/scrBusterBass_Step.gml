if (canDamage && (speed == 0))
{
    xspeed = cos(degtorad(dir)) * 5;
    yspeed = -sin(degtorad(dir)) * 5 * sign(image_yscale); // The vertical speed was, for some reason, inverted, which is why I used a minus. Don't ask me what actually caused this behaviour
}

if (graphicsOverride) // Do not use collision when in vehicles
    exit;

var sigX = sign(xspeed)*8;
var sigY = sign(yspeed)*8;
var tXS = image_xscale;
var tYS = image_yscale;

image_xscale = sign(image_xscale);
image_yscale = sign(image_yscale);

var bbLeft = bbox_left-sigX+3;
var bbTop = bbox_top-sigY;
var bbRight = bbox_right-sigX-3;
var bbBottom = bbox_bottom-sigY;

image_xscale = tXS;
image_yscale = tYS;

var topColl = collision_rectangle(bbLeft,bbTop,bbRight,bbBottom,objTopSolid,true,false);
/*var test = collision_rectangle(bbLeft,bbTop,bbRight,bbBottom,prtEntity,false,true);// || collision_rectangle(bbLeft,bbTop,bbRight,bbBottom,objSolidEntity,false,true)
if (instance_exists(test) && test.isSolid)
{
    topColl = test;//true;
}*/
var collList = collisionRectangleList(bbLeft,bbTop,bbRight,bbBottom,prtEntity,true,true);

if ((checkSolid(0, 0) || topColl || collList >= 0) && !isBoost)
{
    
    var doKill = false;
    var coll = collision_rectangle(bbLeft,bbTop,bbRight,bbBottom,objSolid,true,false);
    if (coll)
    {
        switch (coll.object_index)
        {//Never apply with these weirdo objects.
            case objSolidOffscreen:
            case objPitOffscreenSolid:
            
                exit;
            break;
        }
        doKill = true;
    }
    
    if (!doKill)
    {
        with (topColl)
        {
            if (other.yspeed > 0 && object_index != objLadder)
            {
                doKill = true;
            }
        }
    }
    if (!doKill)
    {
        
        if (collList >= 0)
        {
            for (var i = 0; i < ds_list_size(collList); i++)
            {
                with (ds_list_find_value(collList,i))
                {
                    switch (object_index)
                    {
                        case objAirTiki:
                        case objBossBarrier:
                        case objCompactor:
                        //case objGundrillCover:
                        case objJewelPlatform:
                        case objMagmaBeamSource:
                        //case objNitroTruck:
                        case objOctobulbYokuBlock:
                        case objPicoBrick:
                        case objSolidOffscreen:
                        case objSolidEntity:
                        case objTackleFireDispenser:
                        case objXBlock:
                        case objSuperArmBlock:
                        case objSuperArmBlock2x2:
                            if (isSolid && (!object_is_ancestor(object_index,prtEntity) || !dead))
                            {
                                if (rectangle_in_rectangle(bbLeft,bbTop,bbRight,bbBottom,bbox_left,bbox_top,bbox_right,bbox_bottom) == 1)
                                {
                                    doKill = true;
                                    continue;
                                }
                            }
                        break;
                        default://Nothing.
                        
                        break;
                    }
                }
            }
            mm_ds_list_destroy(collList);
            
        }
    }

    if (collList >= 0)
    {
        mm_ds_list_destroy(collList);
    }
    //with (instance_place())
    if (doKill && !instance_place(x, y + sign(grav), objLadder))
    {
        instance_destroy();
    }
    
}

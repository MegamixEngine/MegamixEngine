///snapToGround(speed,[groundTolerancy)
//Alternative version of snapToGround, its faster to execute and works better at low speeds
//This script will keep the entity that calls it on the ground, but without much care, so it may bork at high speeds
//Make sure the variables listed bellow exist.

//Arguments
//speed: self explainatory
//groundTolerancy: some toleracy when detecting ground, change it if for whatever reason the script doesn't work correctly

///List of variables needed
//_groundDir: angle in which the ground is located, initiallize to -1 to set it automatically the first time the script is called
//_dir: direction in which it moves(-1,1)
//_velX: just initialize to 0
//_velY: just initialize to 0
//_prevCollision: initialize to true, this is used to keep track of succesful movements, and if for whatever reason it fails too much, the script will return 0

var _speed=argument[0];
var gt=4;
var debug=0;

if(argument_count>1&&argument[1]>0)
{
    gt=argument[1];
}
if(argument_count>2)
    debug=argument[2];

if(_groundDir==-1)//Push out of solids and set the direction in which the ground is located
{
    if(positionCollision(bbox_left-1, bbox_get_ycenter()))
    {
        _groundDir=180;
        shiftObject(-1,0,1);
    }
    else if(positionCollision(bbox_right+1,bbox_get_ycenter()))
    {
        _groundDir=0;
        shiftObject(1,0,1);
    }
    else if(positionCollision(bbox_get_xcenter(),bbox_bottom+1))
    {
        _groundDir=270;
        grav=0;
        shiftObject(0,1,1);
    }
    else if(positionCollision(bbox_get_xcenter(),bbox_top-1))
    {
        _groundDir=90;
        shiftObject(0,-1,1);
        grav=0;
    }
    checkGround();
}
var groundXDir=cos(degtorad(_groundDir));
var groundYDir=-sin(degtorad(_groundDir));
if(debug)
{
    print(string(groundXDir)+","+string(groundYDir));
}
var _xdir=groundYDir*_dir;
var _ydir=-groundXDir*_dir;
if(abs(_velX)!=_speed&&abs(_velY)!=_speed)//update speed if its not set
{
        _velX=_speed*_xdir
        _velY=_speed*_ydir;
        checkGround();
        xspeed=_velX;
        yspeed=_velY;
        _prevCollision=1;
}
if(_prevCollision<=0)
{
    _prevCollision-=1;
}
    if(_groundDir==90)
        grav=-0.25;
    else if (_groundDir==270)
        grav=0.25;   
    else
    {
        grav=0;
    }
    
//checkSolid didn't work so we do it manually(this took me HOURS to figure out)
var onGround = ground;
if(!onGround)
    onGround=place_meeting(x+groundXDir*gt,y+groundYDir*gt,objSolid);
if(!onGround)
{
    with(prtEntity)
    {
        if(!dead&&isSolid==1)
        {
            if(place_meeting(x-groundXDir*gt,y-groundYDir*gt,other))
            {
                onGround=true;
                break;
            }
        }
    }
}

if (_prevCollision==1&&!onGround)//if not on the ground rotate and snap to the previous solid
{
    var _X=x;
    var _Y=y;
    var colXPoint=0;
    var colYPoint=0;
    x=xprevious;//restore position to check for the last solid we were on
    y=yprevious;
    if(debug)
        print("Snap to solid");
        
    switch(_groundDir)//figure out which corner of the bbox is closest to the previous solid
    {
            case 0:
                if(_velY>0)
                {
                    colYPoint=bbox_top;
                }
                else
                {
                    colYPoint=bbox_bottom;
                }
                colXPoint=bbox_right;
            break;
            case 90:
                if(_velX>0)
                {
                    colXPoint=bbox_left;
                }
                else
                {
                    colXPoint=bbox_right;
                }
                colYPoint=bbox_top;
            break;
            case 180:
                if(yspeed>0)
                {
                    colYPoint=bbox_top;
                }
                else
                {
                    colYPoint=bbox_bottom;
                }
                colXPoint=bbox_left;
            break;
            case 270:
                if(_velX>0)
                {
                    colXPoint=bbox_left;
                }
                else
                {
                    colXPoint=bbox_right;
                }
                colYPoint=bbox_bottom;
            break;
    }
    var myGround=noone;
    var preMsk=mask_index;
    mask_index=sprDot;
    x=colXPoint+groundXDir*2;
    y=colYPoint+groundYDir*2;
    myGround=instance_place(x,y,objSolid);
    if(myGround==noone)
    {
        with(prtEntity)
        {
            if(dead||!(isSolid==1)||!insideView())
                continue;
            var b=false;
            with(other)
            {
                if place_meeting(x,y,other.id)
                {
                    myGround=other.id;
                    b=true;
                }
            }
            if(b)
            {
                break;
            }
        }
    }
    mask_index=preMsk;
    x=round(_X+xspeed);
    y=round(_Y+yspeed);
    if(myGround!=noone)
    {
        if(_velX!=0)
        {
            if(_velX>0)
                shiftObject((myGround.bbox_right+1)-bbox_left,0,1);
            else
                shiftObject((myGround.bbox_left-1)-bbox_right,0,1);
        }
        else if(_velY!=0)
        {
            
            if(_velY>0)//This one is different to prevet glitches when a slope is in the way when moving vertically
            {
                var clst=myGround.bbox_bottom+1;
                if(abs((myGround.bbox_bottom+1)-bbox_top)>abs((myGround.bbox_top-1)-bbox_top))
                    clst=myGround.bbox_top-1;
                shiftObject(0,(clst)-bbox_top,1);
                
            }
            else
            {
                var clst=myGround.bbox_top-1;
                if(abs((clst)-bbox_bottom)>abs((myGround.bbox_bottom+1)-bbox_bottom))
                    clst=myGround.bbox_bottom+1;
                shiftObject(0,clst-bbox_bottom,1);
            }
        }
    }
    else
    {
        print("HECK");//this should never happen
    }
    _groundDir = wrapAngle(_groundDir - 90*_dir);
    groundXDir=cos(degtorad(_groundDir));
    groundYDir=-sin(degtorad(_groundDir));
    _xdir=groundYDir*_dir;
    _ydir=-groundXDir*_dir;
    xspeed=_speed*_xdir;
    yspeed=_speed*_ydir; 
    if(_groundDir==90)
        grav=-0.25;
    else if (_groundDir==270)
        grav=0.25;   
    else
        grav=0;
    shiftObject(xspeed,yspeed,1);
    _velX=xspeed;
    _velY=yspeed;
    checkGround();
    _prevCollision=0;
            
}
else if (((xcoll!=0&&(_groundDir==90||_groundDir==270)) || (ycoll!=0&&(_groundDir==180||_groundDir==0))) )//if collided with a wall or ceiling just rotate and 
{
    _groundDir = wrapAngle(_groundDir + 90*_dir);
    groundXDir=cos(degtorad(_groundDir));
    groundYDir=-sin(degtorad(_groundDir));
    _xdir=groundYDir*_dir;
    _ydir=-groundXDir*_dir;
    _prevCollision = 1;
    _velX = _xdir*_speed;
    _velY = _ydir*_speed;
    xspeed=_velX;
    yspeed=_velY;
    shiftObject(xspeed,yspeed,1);
    checkGround();
    if(debug)
        print("Wall climb");
           
} 


if(onGround)
{   
    _prevCollision=1;
}

if(xspeed!=_velX)
    xspeed=_velX;
if(yspeed!=_velY)
    yspeed=_velY;


if(_prevCollision>-(abs(sprite_width+sprite_height)/2))
    return true;
else//if the script glitches out too much return false
{
    print("Please kill me");
    return false;
}


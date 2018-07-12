/// checkFall(xOffset,[usePositionCollision])
// check if an object would fall at a horizontal offset
// Note: checking for slopes with big collision masks might be slow
//if usePositionCollision us true, only the sign of xOffset will be used
if (!ground || !blockCollision)
    return true;
var _x = x;
var _y = y;
var _xspeed = xspeed;
var _yspeed = yspeed;
var _xcoll = xcoll;
var _ycoll = ycoll;
var usePositionCollision=false;
if(argument_count>1)
{
    usePositionCollision=argument[1];
}
var result=0;
if(usePositionCollision)
{
    var base = bbox_bottom;
    var front = bbox_right;
    if(sign(argument[0])==-1)
        front=bbox_left;
    if(sign(grav)==-1)
        base=bbox_top;
    result =  !positionCollision(front+sign(argument[0]),base+sign(grav),1,1);
}
else
{
    //Slope code has to be made, so I'll keep it simple for now
    
    xspeed = argument[0];
    generalCollision(1);
    checkGround(1);
    result = !ground;
}

x = _x;
y = _y;
xcoll = _xcoll;
ycoll = _ycoll;
ground = true;
xspeed = _xspeed;
yspeed = _yspeed;

return result;

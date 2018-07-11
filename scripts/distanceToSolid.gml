/// distanceToSolid(x, y, xstep, ystep, [positionCollision])
// returns number of steps from the given coords to the nearest solid in the direction of the step vector.
// returns -1 if failure
// if positionCollision (optional) is true then use positionCollision script for
// collision detection; use placeCollision otherwise.

var nsteps = 0;

var _x = argument[0];
var _y = argument[1];
var xstep = argument[2];
var ystep = argument[3];
var colScript = false;
if (argument_count > 4)
    colScript = argument[4];


var maxX = global.sectionRight;
var maxY = global.sectionBottom;
var minX = global.sectionLeft;
var minY = global.sectionTop;


while (true)
{
    if (colScript)
    {
        if (positionCollision(_x, _y))
            return nsteps;
    }
    else
    {
        if (placeCollision(_x, _y))
            return nsteps;
    }
    
    nsteps++;
    
    _x += xstep;
    _y += ystep;
    if (_x > maxX || _x < minX || _y < minY || _y > maxY || (xstep == 0 && ystep == 0))
    {
        return -1;
    }
}

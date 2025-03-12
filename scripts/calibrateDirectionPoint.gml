/// calibrateDirectionPoint(point_x)
// Like calibrateDirectionPoint, except with an x-coordinate,
// instead of an object
//
// Credit goes to Fabian for this version that preseves image scale

var sgn = sign(argument0 - x);
if (sgn != 0)
  image_xscale = sgn * abs(image_xscale);

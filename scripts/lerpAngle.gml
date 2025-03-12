/// rotation_movement(dirStart,dirFinish,x)
// argument0: angle to start
// argument1: angle to finish
// argument2: speed

var dir = argument0;
var dirF = argument1;
var l = argument2;

var xx = lerp(lengthdir_x(1, dir), lengthdir_x(1, dirF), l);
var yy = lerp(lengthdir_y(1, dir), lengthdir_y(1, dirF), l);

return point_direction(0, 0, xx, yy);

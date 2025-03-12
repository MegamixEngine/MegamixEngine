/// getWeaponWheelDirection(dir_x, dir_y)
var dir_x = argument0, dir_y = argument1;

if (checkCheats(cheatEnums.mirrorMode))
    dir_x *= -1;

return wrapAngle(point_direction(0, 0, dir_x, dir_y) + 22.5) div 45;

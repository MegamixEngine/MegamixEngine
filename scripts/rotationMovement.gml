/// rotation_movement(centerX,centerY,radius,speed)
// argument0: x-coordinate to orbit around
// argument1: y-coordinate to orbit around
// argument2: distance from orbit coordinates
// argument3: direction and speed of the orbiting movement

x = argument0 + argument2 * cos(direction / 57);
y = argument1 + argument2 * sin((direction + 180) / 57);

direction += argument3;

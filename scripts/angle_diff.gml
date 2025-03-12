/// angle_difference

//REDUNDANT IN GMS2. Remove when porting.

/// Returns the shortest difference between two angles in degrees.
/// Arguments:
/// angle1 - The first angle
/// angle2 - The second angle

var angle1 = argument0;
var angle2 = argument1;

// Calculate the difference
var diff = angle2 - angle1;

// Wrap the difference to the range -180 to 180
return (diff + 180) mod 360 - 180;

/// wrapAngle(angle)
// Changes the angle to fit within [0, 360) degrees

var angl = argument0;

while (angl >= 360)
    angl -= 360;

while (angl < 0)
    angl += 360;

return angl;

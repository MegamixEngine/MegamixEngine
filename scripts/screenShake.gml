/// screenShake(duration, x factor, y factor)
// argument0: duration of the shake, in frames
// argument1: horizontal shake factor
// argument2: vertical shake factor

var shakeTimer = argument0;
var shakeX = argument1;
var shakeY = argument2;

global.shakeTimer = shakeTimer;
global.shakeFactorX = shakeX;
global.shakeFactorY = shakeY;

//Rumble
if (argument0 > 0)
{
    with (objMegaman)
    {
        var initial = min(1, ((abs(shakeX) + abs(shakeY)) * 0.25));
        var dampen = (1 / shakeTimer);
        var timeInFrames = shakeTimer;
        
        applyRumble(playerID, 2, initial, dampen, timeInFrames);
    }
}


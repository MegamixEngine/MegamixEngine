/// rumbleClearAll()

//Clears all rumble for every controller, and reinitializes rumble variables.

var _gamepads = 12;
var _gamepadsDouble = (_gamepads * 2);

with (objGlobalControl) //May call unto self on startup but eh.
{
    for (var i = 0; i < _gamepads; i++)
    {
        gamepad_set_vibration(i, 0, 0);
    }
    
    rumbleTimers = allocateArray(_gamepadsDouble, -1);//For rumble support. Goes Left and Right motor for each of the 12 controller types (XInput followed by DInput).
    rumbleCurrent = allocateArray(_gamepadsDouble, 0);
    rumbleDampenAmount = allocateArray(_gamepadsDouble, 0);
    rumblePriority = allocateArray(_gamepads, -100);//Since this is meant for individual calls to motor, and we don't want those to be desynced, priority is shared between each motor.
}


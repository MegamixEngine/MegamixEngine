///controlMappingInit(playerID)

var keys, buttons;

var istart = 0;
var iEnd = MAX_PLAYERS;

if (argument[0] >= 0)
{
    istart = argument[0];
    iEnd = (istart + 1);
}

//Keyboard (Default values)
keys[INPUT_LEFT] = vk_left;
keys[INPUT_RIGHT] = vk_right;
keys[INPUT_UP] = vk_up;
keys[INPUT_DOWN] = vk_down;
keys[INPUT_JUMP] = ord('Z');
keys[INPUT_SHOOT] = ord('X');
keys[INPUT_SLIDE] = ord('C');
keys[INPUT_WEAPONLEFT] = ord('A');
keys[INPUT_WEAPONRIGHT] = ord('S');
keys[INPUT_PAUSE] = vk_space;
keys[INPUT_QUICKITEM] = vk_shift;
keys[INPUT_WEAPONWHEEL] = ord('W');

//Gamepad (Default values)
buttons[INPUT_LEFT] = 2;
buttons[INPUT_RIGHT] = 3;
buttons[INPUT_UP] = 0;
buttons[INPUT_DOWN] = 1;
buttons[INPUT_JUMP] = 12;
buttons[INPUT_SHOOT] = 14;
buttons[INPUT_SLIDE] = 9;
buttons[INPUT_WEAPONLEFT] = 10;
buttons[INPUT_WEAPONRIGHT] = 11;
buttons[INPUT_PAUSE] = 4;
buttons[INPUT_QUICKITEM] = 8;
buttons[INPUT_WEAPONWHEEL] = 6;
buttons[INPUT_WEAPONWHEEL2] = 7;

for (var i = istart; i < iEnd; i ++;)
{
    variable_global_set("keyboardBind" + string(i), keys);
    variable_global_set("gamepadBind" + string(i), buttons);
    
    global.joystick_rumbleType[i] = 1;
}


/// recordInputAppendFrame
// appends a frame of input

global.recordInputSaveData += "-";

// key input data:
for (var i = 0; i < global.playerCount; i++)
{
    var flags = "";
    if (global.keyLeftPressed[i])
        flags += "L";
    if (global.keyLeft[i])
        flags += "l";
    if (global.keyRightPressed[i])
        flags += "R";
    if (global.keyRight[i])
        flags += "r";
    if (global.keyUpPressed[i])
        flags += "U";
    if (global.keyUp[i])
        flags += "u";
    if (global.keyDownPressed[i])
        flags += "D";
    if (global.keyDown[i])
        flags += "d";
    if (global.keyShootPressed[i])
        flags += "X";
    if (global.keyShoot[i])
        flags += "x";
    if (global.keySlidePressed[i])
        flags += "S";
    if (global.keySlide[i])
        flags += "s";
    if (global.keyJumpPressed[i])
        flags += "J";
    if (global.keyJump[i])
        flags += "j";
    if (global.keyWeaponSwitchLeftPressed[i])
        flags += "{";
    if (global.keyWeaponSwitchLeft[i])
        flags += "[";
    if (global.keyWeaponSwitchRightPressed[i])
        flags += "}";
    if (global.keyWeaponSwitchRight[i])
        flags += "]";
    if (global.keyPausePressed[i])
    {
        flags += "P";
    }
    if (global.keyPause[i])
    {
        flags += "p";
    }
    if (global.keyMapPressed[i])
    {
        flags += "M";
    }
    if (global.keyMap[i])
    {
        flags += "m";
    }
    if (global.keyWheelSwitchPressed[i])
    {
        flags += "W";
    }
    if (global.keyWheelSwitch[i])
    {
        flags += "w";
    }
    var stick = "";
    var doWrite = false;
    for (var j = 0; j < 2; j++)
    {
        stick += "," + string(global.analogStickDirection[i,j]) + "," + string(global.analogStickTilt[i,j]);
        if (global.analogStickDirection[i,j] != 0 || global.analogStickTilt[i,j] != 0)
        {
            doWrite = true;
        }
    }
    if (doWrite)//Only add stick to the file if the stick values are not complete 0 (deadzone).
    {
        flags += stick;
    }
    if ((global.keyPausePressed[i] || global.keyPause[i]) && (global.keyMapPressed[i] || global.keyMap[i]))
    {
        global.recordInputEnd = true;
        global.keyPausePressed[i] = false;
        global.keyPause[i] = false;
    }
    
    global.recordInputSaveData += string(i) + ":" + flags + "|";
}

// error-checking
if (global.recordInputFidelityMessageBuffer != "")
{
    global.recordInputSaveData += "fi:" + stringSubstring(md5_string_utf8(global.recordInputFidelityMessageBuffer), 1, 5) + "|";
    global.recordInputFidelityMessageBuffer = "";
}

// append to file since last mark:
var file = file_text_open_append(global.recordInputFile);
if (file == -1)
    global.recordInputEnd = true;
else
{
    file_text_write_string(file, stringSubstring(global.recordInputSaveData, global.recordInputAppendMarker));
    file_text_close(file);
    global.recordInputAppendMarker = string_length(global.recordInputSaveData) + 1;
}

// end recording
if (global.recordInputEnd)
{
    global.recordInputEnd = false;
    global.recordInputMode = 0;
    print("Recording Stopped", WL_SHOW, c_orange);
}

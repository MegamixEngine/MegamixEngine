/// recordInputReadFrame()
// gobbles a frame from the recording string
// returns 0 if no error, 1 if terminated, 2 if force-terminated, negative if error.

// ensures we haven't lost the reading frame:

// dummy input script
if (global.recordInputScriptOverride)
{
    global.recordInputSaveData = script_execute(global.recordInputScriptOverride);
}

assert(stringStartsWith(global.recordInputSaveData, "-"));
while (stringStartsWith(global.recordInputSaveData, "-"))
    global.recordInputSaveData = stringSubstring(global.recordInputSaveData, 2);

// check if viewer has ended the playback
for (var i = 0; i < global.playerCount; i++)
{
    if (global.keyPause[i] || global.keyPausePressed[i])
        global.recordInputEnd = 2;
}

global.recordInputFidelityMessageCompare = "";

// read commands:
while (true)
{
    // detect EOF or frame end:
    var nextFrameMarker = stringIndexOf(global.recordInputSaveData, "-");
    if (nextFrameMarker == 0)
        return 1;
    if (nextFrameMarker == 1)
        break;
    
    // read key:
    var key;
    var colonIndex = stringIndexOf(global.recordInputSaveData, ":");
    if (colonIndex)
    {
        key = (stringSubstring(global.recordInputSaveData, 1, colonIndex));
        global.recordInputSaveData = stringSubstring(global.recordInputSaveData, colonIndex + 1);
    }
    else
        return -1;
    
    // read value:
    var value;
    var newlineIndex = stringIndexOf(global.recordInputSaveData, "|");
    if (newlineIndex)
    {
        value = stringTrim(stringSubstring(global.recordInputSaveData, 1, newlineIndex));
        global.recordInputSaveData = stringSubstring(global.recordInputSaveData, newlineIndex + 1);
    }
    else
        return -1;
    
    // execute command:
    if (key == "fi")
    {
        // fidelity
        global.recordInputFidelityMessageCompare = value;
        show_debug_message(key + ": " + value);
    }
    else
    {
        var pid = real(string_digits(key));
        var value = stringSplit(value,",",false);
        // dub input:
        global.keyLeftPressed[pid]              = stringIndexOf(value[0], "L") > 0;
        global.keyLeft[pid]                     = stringIndexOf(value[0], "l") > 0;
        global.keyRightPressed[pid]             = stringIndexOf(value[0], "R") > 0;
        global.keyRight[pid]                    = stringIndexOf(value[0], "r") > 0;
        global.keyUpPressed[pid]                = stringIndexOf(value[0], "U") > 0;
        global.keyUp[pid]                       = stringIndexOf(value[0], "u") > 0;
        global.keyDownPressed[pid]              = stringIndexOf(value[0], "D") > 0;
        global.keyDown[pid]                     = stringIndexOf(value[0], "d") > 0;
        global.keyJumpPressed[pid]              = stringIndexOf(value[0], "J") > 0;
        global.keyJump[pid]                     = stringIndexOf(value[0], "j") > 0;
        global.keyShootPressed[pid]             = stringIndexOf(value[0], "X") > 0;
        global.keyShoot[pid]                    = stringIndexOf(value[0], "x") > 0;
        global.keySlidePressed[pid]             = stringIndexOf(value[0], "S") > 0;
        global.keySlide[pid]                    = stringIndexOf(value[0], "s") > 0;
        global.keyWeaponSwitchLeftPressed[pid]  = stringIndexOf(value[0], "{") > 0;
        global.keyWeaponSwitchLeft[pid]         = stringIndexOf(value[0], "[") > 0;
        global.keyWeaponSwitchRightPressed[pid] = stringIndexOf(value[0], "}") > 0;
        global.keyWeaponSwitchRight[pid]        = stringIndexOf(value[0], "]") > 0;
        global.keyPausePressed[pid]             = stringIndexOf(value[0], "P") > 0;
        global.keyPause[pid]                    = stringIndexOf(value[0], "p") > 0;
        global.keyMapPressed[pid]             = stringIndexOf(value[0], "M") > 0;
        global.keyMap[pid]                    = stringIndexOf(value[0], "m") > 0;
        global.keyWheelSwitchPressed[pid] = stringIndexOf(value[0],"W");
        global.keyWheelSwitch[pid] = stringIndexOf(value[0],"w");
        if (array_length_1d(value) > 1)//Read analog inputs if changed.
        {
            global.analogStickDirection[pid,0] = real(value[1]);
            global.analogStickTilt[pid,0] = real(value[2]);
            global.analogStickDirection[pid,1] = real(value[3]);
            global.analogStickTilt[pid,1] = real(value[4]);
            //printErr(global.analogStickDirection);
            //printErr(global.analogStickTilt);
        }
    }
}

// error-checking
if (global.recordInputFidelity == 0 && !global.recordInputScriptOverride)
{
    if (global.recordInputFidelityMessageBuffer != "")
        global.recordInputFidelityMessageBuffer = md5_string_utf8(global.recordInputFidelityMessageBuffer);
    if (!stringStartsWith(global.recordInputFidelityMessageBuffer, global.recordInputFidelityMessageCompare)
        || (global.recordInputFidelityMessageBuffer != "" && global.recordInputFidelityMessageCompare == ""))
    {
        global.recordInputFidelity = -1;
    }
    global.recordInputFidelityMessageBuffer = "";
}

if (global.recordInputDeath)
{
    global.recordInputEnd = true;
}

return global.recordInputEnd;

//@noformat

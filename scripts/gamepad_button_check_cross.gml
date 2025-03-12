/// gamepad_button_check_cross(device, buttonIndex)
/*Cross-compatible version of gamepad_button_check.
Ensures buttons are mapped the same between XInput and DInput devices.
This does *not* work beyond 4 controllers, as XInput only supports up to 4.
DInputs beyond 4 (ID 8+) will return their natural value.
*/
var cID = argument[0];
if (cID > 3 && argument[1] < array_length_1d(global.DInputConversionTables))
{
    /*if (gamepad_button_check(cID,global.DInputConversionTables[argument[1]]))
    {
        printErr(argument[1]);
        printErr(global.DInputConversionTables[argument[1]]);
    }*/
    return gamepad_button_check(cID,global.DInputConversionTables[argument[1]]);
}
/*if (gamepad_button_check(cID,argument[1]))
{
    printErr(argument[1]);
}*/
return gamepad_button_check(cID,argument[1]);

/// borderInit()

var iarray;
var i = 0;

iarray[(i ++)] = "NONE";
iarray[(i ++)] = true;//Should always be true to be able to turn off borders.
iarray[(i ++)] = "Add an artistic border to the game window. Custom borders can be added in the Borders folder.";

iarray[(i ++)] = "SGB";
iarray[(i ++)] = true;//Unlock conditions go here.
iarray[(i ++)] = "Original by Capcom";

iarray[(i ++)] = "GB";
iarray[(i ++)] = true;
iarray[(i ++)] = "Original by Nintendo";

iarray[(i ++)] = "Switch Online";
iarray[(i ++)] = true;
iarray[(i ++)] = "Original by Nintendo";


//Add an entry for every custom border a user has loaded.
for (var a = 0; a < array_length_1d(global.customBorders); a++)
{
    iarray[(i++)] = string_replace(global.customBorders[a],".png","");//"CUSTOM " + string(i);;
    iarray[(i++)] = true;
    iarray[(i++)] = "Custom Border";
}


if (DEBUG_ENABLED)
{//Debug for bypassing unlock conditions above.
    if (global.keyMap[0])
    {
        for (var i = 0; i*3+1 < array_length_1d(iarray); i++)
        {
            iarray[i*3+1] = true;
        }
    }
}

return iarray;

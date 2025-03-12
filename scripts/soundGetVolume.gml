///soundGetVolume(For SFX?)
//Returns the sound-volume which gets calculated via a few variables

var forSfx = argument[0];
var value = 0;

if (forSfx) //SFX
{
    value = (global.soundvolume * 0.01);
    value *= global.roomvolume;
}
else //Music
{
    value = (global.musicvolume * 0.01);
    value *= global.levelVolume;
}

value *= (global.mastervolume * 0.01);

return(value);


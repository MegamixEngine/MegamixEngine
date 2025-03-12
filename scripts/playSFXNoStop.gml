/// playSFXNoStop(_sfx, ...)
/// WARNING: USE SPARINGLY. A variant of playSFX that does not stop the previous sound first. 

var _sfx = argument[0];

//Volume
var _vol = soundGetVolume(1);
if (argument_count > 1)
{
    _vol *= argument[1];
}

// - - - - - - - - - - - - - - - - - - - - -

var _mySound = audio_play_sound(_sfx, 50, 0);

audio_sound_gain(_mySound, _vol, 0);

// - - - - - - - - - - - - - - - - - - - - -

return _mySound;//99% of my sound issues have involved this not returning anything so I've had to copy-paste code. Fixing it now before it gets more messy, realistically shouldn't affect anything.

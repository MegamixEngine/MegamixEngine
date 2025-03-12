/// loopSFX(_sfx, ...)
// Loops a sound effect

var _sfx = argument[0];

var _vol = soundGetVolume(1);
if (argument_count > 1)
{
    _vol *= argument[1];
}

// - - - - - - - - - - - - - - - - - - - - -

audio_stop_sound(_sfx);

var _mySound = audio_play_sound(_sfx, 60, 1);

audio_sound_gain(_mySound, _vol, 0);

// - - - - - - - - - - - - - - - - - - - - -

return _mySound; // SCATMAN'S WORLD: Made this script able to retun the sound instance. I needed it for something.


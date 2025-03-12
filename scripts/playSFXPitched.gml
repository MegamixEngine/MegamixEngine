/// playSFXPitched(index, pitch, [volume])
// Plays a sound effect

var _sfx = argument[0];

//Volume
var _vol = soundGetVolume(1);
if (argument_count > 2)
{
    _vol *= argument[2];
}

//Pitch
var _pitch = argument[1];

// - - - - - - - - - - - - - - - - - - - - -

audio_stop_sound(_sfx);

var _mySound = audio_play_sound(_sfx, 50, 0);

audio_sound_gain(_mySound, _vol, 0);

audio_sound_pitch(_mySound, _pitch);

// - - - - - - - - - - - - - - - - - - - - -

return _mySound;

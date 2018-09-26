/// playSFX(index)
// Plays a sound effect

audio_stop_sound(argument0);

var mySound = audio_play_sound(argument0, 50, 0);
audio_sound_gain(mySound, global.soundvolume * 0.01, 0);

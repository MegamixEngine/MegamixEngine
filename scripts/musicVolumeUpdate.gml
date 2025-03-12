/// musicVolumeUpdate([factor])

// Update music volume

var _vol = soundGetVolume(0);
if (argument_count > 0)
{
    _vol *= argument[0];
}

// - - - - - - - - - - - - - - - - - -
if (global.levelSongType == "MIDI")
{
    Fluwiidi_SetGainMaster(_vol*.5);//Fluwiidi is by default a bit louder than other music types.
}
else if (global.levelSongType == "OGG")
{
    FMODInstanceSetVolume(global.songMemory, _vol);
}
else
{
    with (objMusicControl)
    {
        audio_sound_gain(sound_index, _vol, 0);
    }
}

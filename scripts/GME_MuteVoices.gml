/// GME_MuteVoices(_mask)

var _mask = argument0;

with (objMusicControl)
{
    if (playing)
    {
        GameMusicEmu_MuteVoices(_mask);
    }
}

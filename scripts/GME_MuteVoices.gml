/// GME_MuteVoices(mask)

var _mask = argument0;

if (!GME_ENABLED) exit;

with (objMusicControl)
{
    GameMusicEmu_MuteVoices(_mask);
}

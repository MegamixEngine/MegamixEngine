/// GME_MuteVoices(mask)

var _mask = argument0;

if (!global.gme_enabled) exit;

with (objMusicControl)
{
    GameMusicEmu_MuteVoices(_mask);
}

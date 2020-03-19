/// GME_MuteVoice(voice, mute)

var _voice = argument0;
var _mute = argument1;

if (!global.gme_enabled) exit;

with (objMusicControl)
{
    GameMusicEmu_MuteVoice(_voice, _mute);
}

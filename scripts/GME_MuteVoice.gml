/// GME_MuteVoice(voice, mute)

var _voice = argument0;
var _mute = argument1;

if (!GME_ENABLED) exit;

with (objMusicControl)
{
    GameMusicEmu_MuteVoice(_voice, _mute);
}

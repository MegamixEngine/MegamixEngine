/// GME_SetTempo(tempo)

var _tempo = argument0;

if (!global.gme_enabled) exit;

with (objMusicControl)
{
    GameMusicEmu_SetTempo(_tempo);
}

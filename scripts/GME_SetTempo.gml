/// GME_SetTempo(tempo)

var _tempo = argument0;

if (!GME_ENABLED) exit;

with (objMusicControl)
{
    GameMusicEmu_SetTempo(_tempo);
}

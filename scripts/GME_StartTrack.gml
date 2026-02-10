/// GME_StartTrack(_tracknumber)

var _return = 10;
var _tracknumber = argument0;

with (objMusicControl)
{
    var tIndex = _tracknumber;//
    if (tIndex >= GME_NumTracks())
    {
        if (GME_NumTracks() >= 1)
        {
            tIndex = GME_NumTracks()-1;
        }
        else//Can't detect? Somehow 0.
        {
            tIndex = 0;
        }
        
    }//%max(1,GME_NumTracks());
    _return = GameMusicEmu_StartTrack(tIndex,true,-1);//Modulo gets around error message introduced in new system. -1 gets around div by 0 error with fadeout.

    endReached = false;
    playing = false;
    buffer_index = 0;
    
    track_number = _tracknumber;
    
    // Clear buffers used for the audio queue
    for (var i = 0; i < buffer_count; i++)
        buffer_fill(buf[i], 0, buffer_u8, 0, buffer_size);
}

return _return;

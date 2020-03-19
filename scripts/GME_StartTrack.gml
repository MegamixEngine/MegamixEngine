/// GME_StartTrack(track_number)

var _return = 10;
var _tracknumber = argument0;

if (!global.gme_enabled) return 0;

with (objMusicControl)
{
    _return = GameMusicEmu_StartTrack(_tracknumber);
    endReached = false;
    playing = false;
    buffer_index = 0;
    
    track_number = _tracknumber;
    
    // Clear buffers used for the audio queue
    for (var i = 0; i < buffer_count; i++)
        buffer_fill(buf[i], 0, buffer_u8, 0, buffer_size);
}

return _return;

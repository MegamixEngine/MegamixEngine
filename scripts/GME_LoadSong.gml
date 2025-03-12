/// GME_LoadSong(_filename)

var _success = 0;
var _filename = argument0;
var _queue_index = noone;

// Create a gme instance if it does not exist
// if(!instance_exists(objMusicControl))
//  instance_create(0, 0, objMusicControl);

// Load the song
with (objMusicControl)
{
    var tmpQueue = noone;
    // Stop and clear the audio queue
    if (snd_queue != noone)
    {
        ignorePlayback = true;//Stop async processing briefly so we don't force ourselves upon a queue more than once.
        audio_stop_sound(snd_queue);
        tmpQueue = snd_queue;
        //audio_sound_set_track_position(snd_queue,0);
        //audio_free_play_queue(snd_queue);
    }
    //else
    //{
        // Create a new play queue
        snd_queue = audio_create_play_queue(buffer_s16, sample_rate, audio_stereo);
    //}
    
    /*
    To avoid a possible buffer bug that stutters NSF's, we need to store the 
    last sound queue temporarily,*then* free it once we've created the new sound queue.
    This fills in the sound queue first thing and prevents the buffer data from getting offset badly.
    Inadvertedly, this also solves a memory leak.
    
    */
    
    if (tmpQueue != noone)
    {
        audio_free_play_queue(tmpQueue);
    }
    
    
    // Set the local queue index variable
    _queue_index = snd_queue;
    
    // Reset playing variables
    playing = false;
    endReached = false;
    ignorePlayback = false;
    
    // Unload possible previous file
    if (buffer_gme != noone)
    {
        GameMusicEmu_Free();
        buffer_delete(buffer_gme);
    }
    
    // Clear buffers used for the audio queue
    for (var i = 0; i < buffer_count; i++)
        buffer_fill(buf[i], 0, buffer_u8, 0, buffer_size);
    
    
    // Load the song to a buffer
    buffer_gme = buffer_load(_filename);
    
    // Get the pointer to the buffer
    buffer_gme_address = string(buffer_get_address(buffer_gme));
    
    // Get the buffer size
    buffer_gme_size = buffer_get_size(buffer_gme);
    
    // Load the buffer as a song in the extension
    _success = GameMusicEmu_LoadBuffer(buffer_gme_size, buffer_gme_address);
}

if (_success)
    return _queue_index;
else
    return noone;

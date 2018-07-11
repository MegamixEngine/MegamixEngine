///GME_LoadSong(filename)

var _success = 0;
var _filename = argument0;
var _queue_index = noone;

// Create a gme instance if it does not exist
if(!instance_exists(obj_gme))
  instance_create(0, 0, obj_gme);
  
// Load the song
with(obj_gme)
{
  // Stop and clear the audio queue
  if(snd_queue != noone) {
    audio_stop_sound(snd_queue);
    audio_free_play_queue(snd_queue);
  }
  
  // Create a new play queue
  snd_queue = audio_create_play_queue(buffer_s16, sample_rate, audio_stereo);
  
  // Set the local queue index variable
  _queue_index = snd_queue;
  
  // Reset playing variables
  playing = false;
  end_reached = false;
  
  // Unload possible previous file
  if(buffer_gme != noone) {
    GameMusicEmu_Free();
    buffer_delete(buffer_gme);
  }
  
  // Clear buffers used for the audio queue
  for(var i=0; i<buffer_count; i++)
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
  
if(_success)
  return _queue_index;
else
  return noone;

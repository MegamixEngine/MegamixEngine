/// stopMusic()
// Stops the music

// Stop oggs
FMODAllStop();

if (global.tempSongData != -1)
{
    FMODSoundFree(global.tempSongData);
}

// Stop other files
with (objMusicControl)
{
    if (sound_index != noone)
    {
        GME_Stop();
    }
}

global.tempSongData = -1;

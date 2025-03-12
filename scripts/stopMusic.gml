/// stopMusic()
// Stops the music

// Stop oggs
FMODAllStop();

if (global.tempSongData != -1)
{
    FMODSoundFree(global.tempSongData);
}
if (global.tempSongData_MIDI != -1)
{
    //Fluwiidi_StopInstance(global.tempSongData_MIDI);
    Fluwiidi_StopAll();
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
global.tempSongData_MIDI = -1;

with (objMusicControl)
{
    fading = false;
    fadeFactor = 0.05;
}

with(objTwoPartMusicControl){
    instance_destroy();
}

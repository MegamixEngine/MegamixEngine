/// playMusic(music, "OGG" or "VGM", track number, song loop position in seconds, song length in seconds,  loops[true/false], volume)
// This script's meant to be used at the begining of a level so that way if a song stops, it can remember what song was playing before the song switched.
// If music type is VGM, the only arguments that will affect anything are music, track number, and volume. The rest is determined by the vgm file itself.
// If the music type is OGG, then everything but the track number will affect anything
// For the arguments that don't affect aything, you can put anything. The values won't be used.

var fileName = argument[0];
var fileType = argument[1];
var trackNumber = argument[2];
var loopPosition = argument[3];
var songLength = argument[4];
var loops = true;
if (argument_count > 5)
    loops = argument[5];
var volume = 1;
if (argument_count > 6)
    volume = argument[6];

// Search for music
var mus;

mus = 'Music\' + fileName;

if (!file_exists(mus) || mus == global.levelSong)
{
    exit;
}

stopMusic();

// Update music global variables

global.levelSong = fileName;
global.levelSongType = fileType;
global.levelTrackNumber = trackNumber;

global.levelLoopStart = loopPosition / songLength;
global.levelLoopEnd = 1;

global.levelLoop = loops;
global.levelVolume = volume;

if (global.levelSongType == "OGG")
{
    global.tempSongData = FMODSoundAdd(mus, false, true);
    
    // set loop points before playing
    FMODSoundSetLoopPoints(global.tempSongData, global.levelLoopStart, global.levelLoopEnd);
    
    // now play it
    if (global.levelLoop) // Loop
    {
        global.songMemory = FMODSoundLoop(global.tempSongData, false);
    }
    else // Play
    {
        global.songMemory = FMODSoundPlay(global.tempSongData, false);
    }
    
    // NOW set volume
    FMODInstanceSetVolume(global.songMemory, global.levelVolume * (global.musicvolume * 0.01));
}
else if (global.levelSongType == "VGM")
{
    with (objMusicControl)
    {
        sound_index = GME_LoadSong(mus);
        if (sound_index != noone)
        {
            audio_sound_gain(sound_index, global.levelVolume * (global.musicvolume * 0.01), 0); // set the volume
            song_tracks = GME_NumTracks();
            song_voices = GME_NumVoices();
            GME_StartTrack(global.levelTrackNumber);
            
            forceReset = true;
            
            // don't play the song before the force reset
            for (v = 0; v <= song_voices; v++)
            {
                GME_MuteVoice(v, true);
            }
            
            GME_Play();
        }
    }
}

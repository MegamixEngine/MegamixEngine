///playMusic(music, "OGG" "VGM" or "MIDI", VGM track or MIDI SF2 file, loops?, volume, [LEGACYARGS, SEE DEFINITION...]);
//LEGACY: playMusic(music, "OGG" or "VGM", track number or soundbank, song loop position in seconds, song length in seconds,  loops[true/false], volume, [midiSoundfont])

// This script's meant to be used at the begining of a level so that way if a song stops, it can remember what song was playing before the song switched.
// If music type is VGM, the only arguments that will affect anything are music, track number, and volume. The rest is determined by the vgm file itself.
// If the music type is OGG, then everything but the track number will affect anything
// For the arguments that don't affect aything, you can put anything. The values won't be used.

/*
MEGAMIX 1.9: To make music playback easier to use, and to prepare for 2.0,
we have added an easier means to play OGG files, by including metadata
directly in the OGG file itself for looping. This only requires one argument.
This also allows for easy hotswapping if, say, a streamer needs to replace a
song.

Currently, the legacy formatting is also supported, but not recommended, and
will be REMOVED in 2.0.

*/


var fileName = argument[0];//
var fileType = "";
var sf = "";

var mus = global.musicDirectory + fileName;
if (argument_count < 2 || argument[1] == "AUTO")//Auto.
{
    if (stringEndsWith(fileName,".ogg") || stringEndsWith(fileName,".mp3"))
    {
        fileType = "OGG";
    }
    else if (stringEndsWith(fileName,".mid") || stringEndsWith(fileName,".midi"))
    {
        fileType = "MIDI";
    }
    else
    {
        fileType = "VGM";
    }
}
else
{
    fileType = argument[1];
}

if (fileType == "MIDI")
{
    if (stringEndsWith(fileName,".mid"))
    {
        fileType = "MIDI";
        sf = string_copy(mus,0,string_length(mus)-3) + "sf2";
    }
    else if (stringEndsWith(mus,".midi"))
    {
        fileType = "MIDI";
        sf = string_copy(mus,0,string_length(mus)-4) + "sf2";
    }
}

var trackNumber = 0;

if (argument_count > 2)
{
    if (fileType == "MIDI")
    {
        sf = argument[2];
        trackNumber = sf;
    }
    else
    {
        trackNumber = argument[2];
    }
}

var loopPosition = 0;
var songLength = 0;
var loops = true;
var volume = 1;

// Search for music
//Music doesn't exist
if (!file_exists(mus))
{
    exit;
}
if (sf != "" && !file_exists(global.musicDirectory + sf))
{
    exit;
}

if (argument_count > 5)
{
    loopPosition = argument[3];
    songLength = argument[4];
    if (argument_count > 5)
    {
        loops = argument[5];
    }
    if (argument_count > 6)
    {
        volume = argument[6];
    }
}
else
{
    if (fileType == "OGG")
    {
        var res = MECLMM_GetOGGDataTagReal(mus,"LOOPSTART",1);
    
        if (res != -2 && res > -99)//Not FileNotFound or general error.
        {
            //TODO for 2.0: Replace this with an internal, cross-platform function.
            //For a brief moment load the song into memory in FMOD, so we can grab the frequency.
            var tempSongData = FMODSoundAdd(mus, false, true);
            var tempSongMem = FMODSoundLoop(tempSongData,false);
            var freq = FMODInstanceGetFrequency(tempSongMem);
            FMODInstanceSetVolume(tempSongMem, 0);
            FMODInstanceStop(tempSongMem);
            
            loopPosition = MECLMM_GetOGGDataTagReal(mus,"LOOPSTART",freq);
            songLength = MECLMM_GetOGGDataTagReal(mus,"LOOPEND",freq);
        }
        volume = MECLMM_GetOGGDataTagReal(mus,"VOLUME",1);
        if (volume < 0)
        {
            volume = 0;
        }
    }
    if (argument_count == 5)
    {
        loops = argument[3];
        volume = argument[4];
    }
    
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// Music already plays
if (global.tempSongData != -1 && global.levelSongType != "MIDI") || (global.tempSongData_MIDI != -1 && global.levelSongType == "MIDI")
{
    if (fileName == global.levelSong)
    {
        if (trackNumber == global.levelTrackNumber)
        {
            exit;
        }
    }
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

stopMusic();

// Update music global variables

global.levelSong = fileName;
global.levelSongType = fileType;
global.levelTrackNumber = trackNumber;

global.levelLoopStart = loopPosition / songLength;
global.levelSongLength = songLength;
global.levelLoopEnd = 1;

global.levelLoop = loops;
global.levelVolume = volume;
global.levelSoundfont = sf;

var volumeApply = soundGetVolume(0);
musicVolumeUpdate();
if (global.levelSongType == "MIDI")
{
    global.tempSongData = -1; // dumb placeholder
    global.tempSongData_MIDI = Fluwiidi_CreateInstance(global.musicDirectory + sf);
    
    Fluwiidi_Play(global.tempSongData_MIDI,mus,loops);
    Fluwiidi_SetAsyncTriggers(global.tempSongData_MIDI,true);//Used for certain triggers.
}
else if (global.levelSongType == "OGG")
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
    FMODInstanceSetVolume(global.songMemory, volumeApply);
}
else if (global.levelSongType == "VGM")
{
    global.tempSongData = 0; // dumb placeholder
    with (objMusicControl)
    {
        sound_index = GME_LoadSong(mus);
        
        if (sound_index != noone)
        {
            audio_sound_gain(sound_index, volumeApply, 0); // set the volume
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
            
            stuckTimer = 0;
            prePos = 0;
            alarm[1] = 2;
        }
    }
}
var sd = global.tempSongData;
if (global.levelSongType == "MIDI")
{
    sd = global.tempSongData_MIDI;
}
global.songCredits = musicGetInfo(sd, global.levelSongType,global.musicDirectory + global.levelSong, global.levelTrackNumber);

with (objGlobalControl)
{
    if (global.musicShowCredits == 2 || (global.musicShowCredits))
    {
        displayMusic = (60 * 5) * global.inGame;
    }
    else
    {
        displayMusic = 0;
    }
    displayMusic_FadeIn = 0;
}

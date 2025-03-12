/// resumeMusic()
// resumes last playing song before stop

var tmpCred = global.musicShowCredits;
global.musicShowCredits = false;
if (global.levelSongType == "MIDI")
{
    playMusic(global.levelSong, global.levelSongType,
    global.levelSoundfont, global.levelLoopStart, 1, global.levelLoop,
    global.levelVolume);
}
else
{
playMusic(global.levelSong, global.levelSongType,
    global.levelTrackNumber, global.levelLoopStart, 1, global.levelLoop,
    global.levelVolume);
}   
global.musicShowCredits = tmpCred;

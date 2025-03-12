/// playMusicTwoPart(music track 1, volume, music track 2, song loop position in seconds, song length in seconds, volume)
// Alternate version of playMusic() that starts playing one OGG file and then moves on to looping another OGG file
// Meant for use with tracks that have multiple intro variants

var fileName1 = argument[0];
var volume1 = argument[1];

var fileName2 = argument[2];
var loopPosition2 = argument[3];
var songLength2 = argument[4];
var volume2 = argument[5];

//Music (second part) already plays
if (global.tempSongData != -1)
{
    if (fileName2 == global.levelSong)
    {
        exit;
    }
}

playMusic(fileName1, "OGG", 0, 0, 0, 0, volume1);

// Set objMusicControl to remember the second OGG, to play it once the first OGG is done playing
with(instance_create(0,0,objTwoPartMusicControl)){
    print("- objTwoPartMusicControl spawned -"); //This has to be here or it doesn't work for some reason
    firstPartFileName = fileName1;
    twoPartFileName = fileName2;
    twoPartLoopPosition = loopPosition2;
    twoPartSongLength = songLength2;
    twoPartVolume = volume2;
}

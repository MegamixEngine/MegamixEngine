/// musicGetInfo(songMemory, songType, songFile, trackNumber)
var songMemory = argument0, songType = argument1, songFile = argument2, trackNumber = argument3;

var songExtension = string_copy(songFile,string_length(songFile)-3,3);
var songNoExt = string_copy(songFile,0,string_length(songFile)-3);
var returnData = array_create(0);

var credits = allocateArray(6,"");
//Credits format is TRACK/TRACK, ALBUM, COMPOSER, ARTIST, COPYRIGHT, and DATE.


if (songType == "MIDI")
{
    /*Ignore. If this data is available, it will be read in by the game as the 
    MIDI plays, presumably at Tick 0.
    
    */
    
}
else if (songType == "VGM")
{
    /*Note: As NSF2 is both not supported by the current GME version, 
    and its standard isn't fully adopted yet, we will rely soley on overrides
    via INI files for additional info.
    
    It also doesn't exactly have support for non-NES formats.
    
    */
    credits[1] = GME_GetName();
    credits[2] = GME_GetAuthor();
    credits[4] = GME_GetCopyright();
    
    //A basic 3 setup.
    
}
else if (songType == "OGG")
{
    var i = 0;
    credits[i++] = MECLMM_GetOGGDataTagString(songFile,"TITLE");
    credits[i++] = MECLMM_GetOGGDataTagString(songFile,"ALBUM");
    credits[i++] = MECLMM_GetOGGDataTagString(songFile,"COMPOSER");
    credits[i++] = MECLMM_GetOGGDataTagString(songFile,"ARTIST");
    credits[i++] = MECLMM_GetOGGDataTagString(songFile,"COPYRIGHT");
    credits[i++] = MECLMM_GetOGGDataTagString(songFile,"DATE");
}

/*That being said, allow using INI files even with other formats, as OGGs can
be lossy if not exported properly.*/
if (file_exists(songNoExt + "ini"))
{
    ini_open(songNoExt + "ini")
    credits[0] = ini_read_string("TRACKS",trackNumber,"");
    credits[1] = ini_read_string("DATA","ALBUM",credits[1]);
    credits[2] = ini_read_string("DATA","COMPOSER",credits[2]);
    credits[3] = ini_read_string("DATA","ARTIST",credits[3]);
    credits[4] = ini_read_string("DATA","COPYRIGHT",credits[4]);
    credits[5] = ini_read_string("DATA","DATE",credits[5]);
    
    credits[2] = ini_read_string("COMPOSERS",string(trackNumber),credits[2]);
    credits[3] = ini_read_string("ARTISTS",string(trackNumber),credits[3]);
    ini_close();
}
else
{
    var generalINI = filename_path(songFile) + "songinfo.ini";
    
    if (file_exists(generalINI))
    {
        ini_open(generalINI)
        credits[0] = ini_read_string("TRACKS",trackNumber,"");
        credits[1] = ini_read_string("DATA","ALBUM",credits[1]);
        credits[2] = ini_read_string("DATA","COMPOSER",credits[2]);
        credits[3] = ini_read_string("DATA","ARTIST",credits[3]);
        credits[4] = ini_read_string("DATA","COPYRIGHT",credits[4]);
        credits[5] = ini_read_string("DATA","DATE",credits[5]);
        
        credits[2] = ini_read_string("COMPOSERS",string(trackNumber),credits[2]);
        credits[3] = ini_read_string("ARTISTS",string(trackNumber),credits[3]);
        credits[0] = ini_read_string("DAT-" + filename_name(songFile),"TRACK",credits[0]);
        credits[2] = ini_read_string("DAT-" + filename_name(songFile),"COMPOSER",credits[2]);
        credits[3] = ini_read_string("DAT-" + filename_name(songFile),"ARTIST",credits[3]);
        
        ini_close();
        
    }
}
var key = "";
for (var i = 0; i < 6; i++)
{
    key += string(credits[i]);
}
if (global.musicShowCredits == 1 && !ds_map_exists(global.songCredits_History,key))
{
    global.songCredits_History[? key] = true;
}
else if (global.musicShowCredits < 2 && ds_map_exists(global.songCredits_History,key))
{
    return allocateArray(6,"");
}
return credits;

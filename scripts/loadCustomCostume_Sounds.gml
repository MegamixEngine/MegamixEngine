/// loadCustomCostume_Sounds(filename,playerID)

var baseName = string_copy(argument[0],1,string_length(argument[0])-4);
var playerID = argument[1];


var fileNameSuffixes = customCostume_GetSoundNames();


global.customCostume_UseVASounds[playerID] = false;
for (var i = 0; i < SFX_LENGTH; i++)
{
    if (fileNameSuffixes[i] == "")//For custom costumes, charging and charged will be the same sound, and should fade out. The rest aren't player sounds.
    {
        continue;
    }
    if (global.customSounds[playerID,i] >= 0 && audio_exists(global.customSounds[playerID,i]))
    {
        audio_destroy_stream(global.customSounds[playerID,i]);
    }
    global.customSounds[playerID,i] = -1;
    var file = baseName + "." + fileNameSuffixes[i] + ".ogg";
    if (file_exists(working_directory + file))
    {
        var temp = audio_create_stream(working_directory + file);
        if (temp >= 0)
        {
            global.customSounds[playerID,i] = temp;
        }
        else
        {
            print(file + " could not be loaded.",WL_SHOW);
        }
    }
    else
    {
        print("Custom sound not found " + file);
    }
}

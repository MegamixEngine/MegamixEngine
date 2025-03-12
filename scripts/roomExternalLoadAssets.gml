/// roomExternalLoadAssets(filepath)
var filepath = argument0;
var roomfile = filepath;
filepath = filename_path(filepath) + "assets\";
//show_message(filepath);
if (directory_exists(filepath))
{
    var file = file_find_first(filepath + "*.png",0);
    //Note: Add JPG/GIF support later as alternatives.
    if (file == "")
    {
        print("Asset folder found, but no external assets for room.");
        //show_message("No files");
        //return;//No files.
    }
    else
    {
        var rf = file_text_open_read(roomfile);
        var txt = file_text_read_string(rf);
        file_text_close(rf);
        
        while (file != "")
        {
            var assetfile = filename_name(file);
            var assetName = (filename_removeExtension(assetfile));

            roomExternalLoadAsset(0,assetName,filepath)
            file = file_find_next();
            
            
            
        }
        
    }
    file_find_close();
}
else
{
    print("No external assets for room.");
    //show_message("No folder.");
}
/*else
{
    assert(false, "Directory " + filepath + " not found when loading external assets.");
    
}*/

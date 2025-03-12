///slDelete(file name, slot dependent?, [keep backup])
//NOTE: KEEP BACKUP WILL ALSO DELETE ALL CHECKPOINT SAVES!
var fileName = argument[0];
var slotDependent = argument[1];

var backup = 0;
var backupName = "";

if (argument_count > 2)
{
    backup = 1;
    backupName = argument[2];
}

if (slExists(fileName, slotDependent))
{
    fileName = fileName + ".sav";
    
    //Slot specific
    if (slotDependent)
    {
        var folder = "slot" + string(global.saveSlot) + "/";
        
        fileName   = folder + fileName;
        backupName = folder + backupName;
    }
    
    if (backup)
    {
        for (var i = 4; i > 0; i--)
        {
            var oldName = backupName + string(i) + ".sav";
            var rename = backupName + string(i+1) + ".sav";
            
            if (file_exists(oldName))
            {
                if (file_exists(rename))
                {
                    file_delete(rename);//Delete if exists.
                }
                file_copy(oldName, rename);
                break;
            }
        }
        file_copy(fileName, backupName + "1.sav");
        file_delete(fileName);
        //Delete all checkpoint saves now.
        // Find the first file in the directory
        var file_pattern = "slot" + string(global.saveSlot) + "/*.sav";
        var file = file_find_first(file_pattern,0);
        
        // Loop through all files in the directory
        while (file != "") {
            // Extract the filename without the path
            var file_name = filename_name(file);
        
            // Check if the filename starts with "lvl"
            if (string_copy(file_name, 1, 3) == "lvl" || string_copy(file_name, 1, 2) == "rm") {
                // Delete the file
                file_delete("slot" + string(global.saveSlot) + "/" + file);
            }
        
            // Find the next file
            file = file_find_next();
        }

    }
    else
    {
        file_delete(fileName);
    }
}


///sl_begin(save?, filename, slot dependent?, [hash-check?], [saltKey],[b64Encode?], [secure?])
// begins saving or loading the given file.
// after this call, use value = sl(value) to save/load values,
// and use slEnd() to close the file.

// save? - bool - true: save; false: load
// filename: what file name to use, e.g. "file1"
//   Directory not needed to be supplied
// hash-check: stamp/check hash on save/load.
// saltKey: a random string, used here to keep checkpoint saves locked to their file.
// secure: Encrypts the data such that it is unique to the device running it. Should only really be used for sensitive info like login data.

global.sl_save = argument[0];
global.sl_filename = argument[1] + ".sav";
global.sl_hash_check = false;
global.sl_salt_key = "";
global.sl_b64encode = false;
global.sl_secure = false;
global.sl_hotbarMode = false;//Used to slightly change SL's functionality during hotbar usage.
if (argument_count >= 4) global.sl_hash_check = argument[3];
if (argument_count >= 5) global.sl_salt_key = argument[4];//Used later in sl end.
if (argument_count >= 6) global.sl_b64encode = argument[5];
if (argument_count >= 7) global.sl_secure = argument[6];

//Slot dependent
if (argument[2])
{
    var folder = "slot" + string(global.saveSlot) + "/";
    global.sl_filename = folder + global.sl_filename;
}

// counts unkeyed variables for sl() calls
global.sl_varcounter = 0;
global.sl_error = false;
global.sl_map = -1;

if (global.sl_save == SL_SAVE)
{
    print("Saving to " + global.sl_filename, WL_VERBOSE);
    
    global.sl_map = mm_ds_map_create(true);
}
else if (global.sl_save == SL_LOAD)
{
    print("Loading from " + global.sl_filename, WL_VERBOSE);
    
    if (global.sl_secure)
    {
        global.sl_map = ds_map_secure_load(global.sl_filename);
    }
    else
    {
    
        var file = file_text_open_read(global.sl_filename);
        
        if (file == -1)
        {
            global.sl_error = 1;
            exit;
        }
        
        var file_contents = "";
        
        while (!file_text_eof(file))
        {
            file_contents += file_text_readln(file);// + chr(10); This newline broke the algorithm.
        }
        
        file_text_close(file);
        
        
        // read optional hash stamp.
        var stamp = "";
        var stampLengthPre = 9;
        var stampLength = 40;
        var stampLengthPost = 1;
        var stampLengthTotal = stampLengthPre + stampLength + stampLengthPost;
        if (string_length(file_contents) >= stampLengthTotal)
        {
            if (stringStartsWith(file_contents, "CHECKSUM:") && string_char_at(file_contents, stampLengthTotal) == ":")
            {
                stamp = stringSubstring(file_contents, stampLengthPre + 1, stampLengthPre + stampLength + 1);
                file_contents = stringSubstring(file_contents, stampLengthTotal + 1);
                print("File loaded stamped with hash " + stamp, WL_VERBOSE);
            }
        }
        
        // compare hash stamp
        if (global.sl_hash_check)
        {
            if (stamp == "")
            {
                if (!DEBUG_ENABLED) // permit unstamped files until game is released.
                {
                    print("File corruption detected: stamp not present.", WL_VERBOSE);
                    global.sl_error = 3;
                    exit;
                }
                else
                {
                    print("No hash. Devs: Save your file again!",WL_SHOW);
                }
            }
            else
            {
                var hash = sha1_string_utf8(global.sl_salt_key + file_contents + "&salt=" + SAVES_CHECKPOINTBASESALT);
                print("The calculated hash is " + hash, WL_VERBOSE);
                if (hash != stamp || hash == "")
                {
                    print("Checkpoint cannot be loaded: From different save file.", WL_VERBOSE);
                    if (DEBUG_ENABLED)
                    {
                        print("Hash failure 2!",WL_SHOW);
                    }
                    else
                    {
                        global.sl_error = 3;
                        exit;
                    }
                }
            }
        }    
        
        
        
        global.sl_map = slDecode(file_contents);
        
    }
    if (global.sl_map == -1)
    {
        global.sl_error = 2;
    }
}

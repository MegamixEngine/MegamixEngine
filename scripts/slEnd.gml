/// sl_end()
// completes save/load process, cleaning up resources and writing to file if
// necessary.
// returns 0 if no error, otherwise returns some error code.

if (global.sl_error)
{
    if (global.sl_map >= 0)
    {
        mm_ds_map_destroy(global.sl_map);
    }
    
    return global.sl_error;
}

// saving:
if (global.sl_save)
{
    
    
    if (global.sl_secure)
    {
        ds_map_secure_save(global.sl_map,global.sl_filename);
    }
    else
    {
    
        var jsonstr = slEncode(global.sl_map);
        
        if (filename_name(global.sl_filename) == "gameProgress.sav")
        {
            if (file_exists(global.sl_filename + ".bak"))
            {
                file_delete(global.sl_filename + ".bak");
            }
            if (file_exists(global.sl_filename))
            {
                file_copy(global.sl_filename,global.sl_filename + ".bak");
            }
        }
        var file = file_text_open_write(global.sl_filename);
        
        if (file == -1)
        {
            if (global.sl_map >= 0)
                mm_ds_map_destroy(global.sl_map);
            return -1;
        }
        if (global.sl_hash_check)
        // stamp with hash
        {
            var hash = sha1_string_utf8(global.sl_salt_key + jsonstr + "&salt=" + SAVES_CHECKPOINTBASESALT);
            assert(string_length(hash) == 40);
            jsonstr =  "CHECKSUM:" + hash + ":" + jsonstr;
        }
        
        file_text_write_string(file, jsonstr);
        
        file_text_close(file);
        
        show_debug_message("Saving completed without errors.");
    }
}
else
{
    show_debug_message("Loading completed without errors.");
}

if (global.sl_map >= 0)
{
    mm_ds_map_destroy(global.sl_map);
}

return 0;

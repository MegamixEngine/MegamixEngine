/// sl_end()
// completes save/load process, cleaning up resources and writing to file if
// necessary.
// returns 0 if no error, otherwise returns some error code.

if (global.sl_error)
{
    if (global.sl_map >= 0)
        ds_map_destroy(global.sl_map);
    return global.sl_error;
}

// saving:
if (global.sl_save)
{
    var file = file_text_open_write(global.sl_filename);
    if (file == -1)
    {
        if (global.sl_map >= 0)
            ds_map_destroy(global.sl_map);
        return -1;
    }
    file_text_write_string(file, json_encode(global.sl_map));
    file_text_close(file);
    show_debug_message("Saving completed without errors.");
}
else
{
    show_debug_message("Loading completed without errors.");
}

if (global.sl_map >= 0)
    ds_map_destroy(global.sl_map);

return 0;

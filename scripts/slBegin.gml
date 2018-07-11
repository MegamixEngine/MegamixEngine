/// sl_begin(save?, filename)
// begins saving or loading the given file.
// after this call, use value = sl(value) to save/load values,
// and use slEnd() to close the file.

// save? - bool - true: save; false: load
// filename: what file name to use, e.g. "file1.sav"
//   Directory not needed to be supplied

global.sl_save = argument0;
global.sl_filename = argument1;

// counts unkeyed variables for sl() calls
global.sl_varcounter = 0;
global.sl_error = false;
global.sl_map = -1;

if (global.sl_save)
{
    print("Saving to " + global.sl_filename, WL_VERBOSE);
    global.sl_map = ds_map_create();
}
else
{
    print("Loading from " + global.sl_filename, WL_VERBOSE);
    var file = file_text_open_read(global.sl_filename);
    if (file == -1)
    {
        global.sl_error = 1;
        exit;
    }
    var file_contents = "";
    while (!file_text_eof(file))
        file_contents += file_text_readln(file) + chr(10);
    file_text_close(file);
    global.sl_map = json_decode(file_contents);
    if (global.sl_map == -1)
        global.sl_error = 2;
}

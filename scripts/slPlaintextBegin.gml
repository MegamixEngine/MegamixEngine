/// sl_plaintext_begin([string])
// begins saving or loading to a plaintext string.
// saving: no string provided
// loading: loads from the given string.
// after this call, use value = sl(value) to save/load values,
// and use slPlaintextEnd() to return the string

// [string] -- if provided, loads from the given string.

global.sl_save = argument_count == 0;
global.sl_filename = "(plaintext)";
global.sl_varcounter = 0;
global.sl_error = false;
global.sl_map = -1;

if (global.sl_save)
{
    global.sl_map = mm_ds_map_create(true);
}
else
{
    global.sl_map = json_decode(argument[0]);
    if (global.sl_map == -1)
        global.sl_error = 2;
}

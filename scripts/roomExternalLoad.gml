/// roomExternalLoad(filename, [hash])
/// loads a room from an external file and returns its room id, or a negative
/// number if an error occurred.

/// filename: assumed to be relative to the included files directory, and ".room.gmx" extension should be left off.
/// but for external files prepend a + symbol and include the extension

/// if a hash is supplied, the hash is checked and if the level file is corrupted then
/// the file will not be loaded.

/// if room already cached, return that.
if (!is_undefined(global.roomExternalCache[? argument[0]]))
    return global.roomExternalCache[? argument[0]];

// determine actual path to file
var filepath;
if (stringStartsWith(argument[0], "+"))
    filepath = stringSubstring(argument[0], 2);
else
    filepath = argument[0] + ".room.gmx";

// determine file hash
var file_hash = md5FileContents(filepath);
if (is_real(file_hash))
{
    printErr("ERROR LOADING FILE, unable to hash file contents: " + filepath);
    return -5;
}

// enforce file hash (optional)
if (argument_count > 1)
{
    if (file_hash != argument[1])
    {
        printErr("HASH FAILED loading external room: " + filepath);
        printErr("Expected hash: " + argument[1]);
        printErr("Actual hash: " + file_hash);
        return -12;
    }
}

// open file for parsing
var file = file_text_open_read(filepath);
if (file == -1)
    return -1;

var prop_width = 256;
var prop_height = 240;
var prop_bg_n = 0;
var prop_bg;
var prop_inst_n = 0;
var prop_inst;
var prop_tile_n = 0;
var prop_tile;
var prop_colour = 0;
var code_str = "";

// parse properties:
while (!file_text_eof(file))
{
    var text = file_text_readln(file);
    text = stringSubstring(text, string_pos("<", text));
    
    // room properties
    if (stringStartsWith(text, "<width>"))
        prop_width = real(string_digits(text));
    if (stringStartsWith(text, "<height>"))
        prop_height = real(string_digits(text));
    if (stringStartsWith(text, "<colour>"))
        prop_colour = real(string_digits(text));
    if (stringStartsWith(text, "<code>"))
    {
        code_str = text + global.newLine;
        while (!file_text_eof(file))
        {
            if (string_pos("</code>", code_str) != 0)
                break;
            code_str += file_text_readln(file) + global.newLine;
        }
        continue;
    }
    
    // backgrounds
    if (stringStartsWith(text, "<background "))
    {
        prop_background[prop_bg_n++] = xmlParseTag(text);
    }
    
    // views [not implemented]
    
    // instances
    if (stringStartsWith(text, "<instance "))
    {
        prop_inst[prop_inst_n++] = xmlParseTag(text);
    }
    
    // tiles
    if (stringStartsWith(text, "<tile "))
    {
        prop_tile[prop_tile_n++] = xmlParseTag(text);
    }
}

file_text_close(file);

// external room's id:
var exrm = room_add();

// residual instance properties (must be stored in exgrid below)
var prop_copy, prop_copy_n;
prop_copy[0] = "code";
prop_copy[1] = "scaleX";
prop_copy[2] = "scaleY";
prop_copy[3] = "colour";
prop_copy[4] = "rotation";
prop_copy_n = 5;

// this grid will remain for the length of the game
// it details creation event code for each instance.
var exgrid = ds_grid_create(prop_inst_n + 1, prop_copy_n + 1);
global.roomExternalSetupMap[? exrm] = exgrid;
exgrid[# 0, 0] = stringBetween(code_str, "<code>", "</code>");

print("Room loaded externally: " + filepath, WL_VERBOSE);
if (argument_count > 1)
    print("Hash confirmed.", WL_VERBOSE);
else
    print("Hash is " + file_hash + " (not enforced!)", WL_VERBOSE);

// apply properties
room_set_width(exrm, prop_width);
room_set_height(exrm, prop_height);
room_set_background_colour(exrm, prop_colour, true);

// add backgrounds [not implemented]
for (var i = 0; i < prop_bg_n; i++)
{
    if (i > 7 || i < 0)
        return -2;
    var map = prop_background[i];
    var bgName = map[? "name"];
    var bgID = asset_get_index(bgName);
    if (bgID < 0)
        continue;
    room_set_background(exrm, i,
        real(map[? "visible"]),
        real(map[? "foreground"]),
        bgID,
        real(map[? "x"]),
        real(map[? "y"]),
        real(map[? "htiled"]),
        real(map[? "vtiled"]),
        real(map[? "hspeed"]),
        real(map[? "vspeed"]),
        real(map[? "alpha"]));
    ds_map_destroy(map);
}

// add instances
room_instance_add(exrm, 0, 0, objExternalRoomSetup);
for (var i = 0; i < prop_inst_n; i++)
{
    var map = prop_inst[i];
    var objName = map[? "objName"];
    var objId = asset_get_index(objName);
    var _x = map[? "x"];
    var _y = map[? "y"];
    var inst_id = room_instance_add(exrm, real(_x), real(_y), objId);
    
    // copy over additional attributes to the room loader map:
    exgrid[# i + 1, 0] = inst_id;
    for (var j = 0; j < prop_copy_n; ++j)
    {
        exgrid[# i + 1, j + 1] = map[? prop_copy[j]];
        
    }
    
    
    ds_map_destroy(map);
}

// add tiles
for (var i = 0; i < prop_tile_n; i++)
{
    var map = prop_tile[i];
    room_tile_add_ext(exrm, asset_get_index(map[? "bgName"]),
        real(map[? "xo"]), real(map[? "yo"]),
        real(map[? "w"]), real(map[? "h"]),
        real(map[? "x"]), real(map[? "y"]),
        real(map[? "depth"]), real(map[? "scaleX"]), real(map[? "scaleY"]),1);
    ds_map_destroy(map);
}

global.roomExternalCache[? argument[0]] = exrm;

return exrm;

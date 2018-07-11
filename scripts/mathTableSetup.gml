/// mathTableSetup(); (Only run once at the start of the game)

// trig tables ( value of the table at index 45 for instance gives cos(degtorad(45)) )
global.sinTableID = ds_list_create();

var sinTableFile = file_text_open_read("Misc/sinTable.txt");
assert(sinTableFile != -1, "COULD NOT LOAD: sinTable.txt");

var hashStrSin = ""

;
while (!file_text_eof(sinTableFile))
{
    var line = file_text_readln(sinTableFile);
    ds_list_add(global.sinTableID, real(line));
    hashStrSin += line + global.newLine;
}

// giving false positives
// assert(md5_string_utf8(hashStrSin) == "eef69c071615fd00c9e80978cd749c35", "Trig table has been modified! Go no farther, ya dirty hacker. You've been warned.");

file_text_close(sinTableFile);

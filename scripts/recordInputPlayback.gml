/// recordInputPlayback(filename)
// begins playback for given file
// returns 0 if successful, negative if error

if (global.recordInputMode != 0)
    return -1;

var filename = argument0;

var file = file_text_open_read(filename);
if (file == -1)
{
    return -1;
}
global.recordInputSaveData = "";
while (!file_text_eof(file))
    global.recordInputSaveData += file_text_readln(file) + chr(10);
file_text_close(file);

var HEADER_MARKER = "END HEADER";
var headerEnd = stringIndexOf(global.recordInputSaveData, HEADER_MARKER);
var headerString = stringSubstring(global.recordInputSaveData, 1, headerEnd);

global.recordInputSaveData = stringSubstring(global.recordInputSaveData, headerEnd + string_length(HEADER_MARKER));
global.recordInputSaveData = stringTrim(global.recordInputSaveData);
global.recordInputRoom = room;
global.recordInputScriptOverride = false;
global.recordInputSkipSpawn = true;
global.recordInputReturnRoom = rmTitleScreen;
global.recordInputDeath = false;

show_debug_message(headerString);
show_debug_message("=========");

slPlaintextBegin(headerString);
saveLoadRecordInput();
var error = slPlaintextEnd();

if (!error)
{
    // begins recording on next frame
    global.recordInputBegin = true;
    global.recordInputEnd = false;
    global.recordInputMode = 2; // 0: naught, 1: record, 2: playback
    global.recordInputFrame = 0;
    return 0;
}
else
{
    randomize();
    global.recordInputMode = 0;
    return -1;
}

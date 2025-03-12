/// recordInputToFile(filename, [room])
/// begins recording to the given file
/// if room is provided, will go to that room and spawn; otherwise, recording
/// begins mid-level (which could mean the recording is unfaithful)
/// returns -1 if error, 0 if success

if (global.recordInputMode != 0)
    return -1;

if (!instance_exists(objMegaman) && argument_count > 1)
    return -1;

global.recordInputSkipSpawn = argument_count <= 1;
if (argument_count > 1)
    global.recordInputRoom = argument[1];
else
    global.recordInputRoom = room;

slPlaintextBegin();

saveLoadRecordInput();

// replace file:
global.recordInputFile = argument[0];
global.recordInputSaveData = slPlaintextEnd() + "END HEADER";
var ft = file_text_open_write(global.recordInputFile)
    ;
if (ft > 0)
{
    file_text_write_string(ft, global.recordInputSaveData);
    global.recordInputSaveData = "";
}

file_text_close(ft);

// begins recording on next frame
global.recordInputBegin = true;
global.recordInputEnd = false;
global.recordInputMode = 1; // 0: naught, 1: record, 2: playback
global.recordInputFrame = 0;
global.recordInputAppendMarker = 1;
global.recordInputFidelity = 0;

print("Recording Begun", WL_SHOW, c_orange);

return 0;

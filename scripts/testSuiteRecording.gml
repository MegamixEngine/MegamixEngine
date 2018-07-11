// ensures playback of recordings actually functions.
// absolutely necessary for any gameplay unit tests.

if (unitCase("basic recording can be loaded and played"))
{
    unitCritical();
    
    // single-execution
    if (unitBegin())
    {
        recordInputPlayback("UnitTests/Recordings/recTestA.mrc");
        global.recordInputReturnRoom = rmUnitTest;
    }
    
    if (unitTick())
    {
        // exit test if recording finishes
        if (global.recordInputMode == 0)
        {
            unitEnd();
            exit;
        }
        
        if (global.recordInputFrame > 300)
        {
            unitRequire(false, "Playback did not terminate.");
            unitEnd();
        }
    }
    
    if (unitCleanUp())
    {
        global.recordInputMode = 0;
        room_goto(rmUnitTest);
    }
}

if (unitCase("non-reset 'here' recordings"))
{
    unitCritical();
    
    if (unitBegin())
    {
        recordInputPlayback("UnitTests/Recordings/RecordingTestHere.mrc");
        global.recordInputReturnRoom = rmUnitTest;
    }
    
    if (unitTick())
    {
        // exit test if recording finishes
        if (global.recordInputMode == 0)
        {
            unitEnd();
            exit;
        }
        
        if (global.recordInputFrame < 30)
        {
            unitRequire(global.recordInputFidelity == 0, "Non-reset recordings do not play accurately. (Has spawning logic changed?)");
        }
        else
        {
            unitRequire(global.recordInputFidelity == 0, "Physics failed after spawning. (Has spawning logic changed?)");
        }
    }
    
    if (unitCleanUp())
    {
        global.recordInputMode = 0;
        room_goto(rmUnitTest);
    }
}

if (unitCase("reset 'beam-in' recordingg"))
{
    unitCritical();
    
    if (unitBegin())
    {
        recordInputPlayback("UnitTests/Recordings/RecordingTestReset.mrc");
        global.recordInputReturnRoom = rmUnitTest;
    }
    
    if (unitTick())
    {
        // exit test if recording finishes
        if (global.recordInputMode == 0)
        {
            unitEnd();
            exit;
        }
        
        if (global.recordInputFrame < 90)
        {
            unitRequire(global.recordInputFidelity == 0, "Reset recordings do not play accurately. (Has spawning logic changed?)");
        }
        else
        {
            unitRequire(global.recordInputFidelity == 0, "Physics failed after spawning.  (Has spawning logic changed?)");
        }
    }
    
    if (unitCleanUp())
    {
        global.recordInputMode = 0;
        room_goto(rmUnitTest);
    }
}

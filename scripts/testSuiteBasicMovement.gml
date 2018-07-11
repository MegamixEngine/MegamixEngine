// ensures mega man's basic movement physics have not changed

if (unitCase("Various basic movement capabilities"))
{
    unitCritical();
    
    if (unitBegin())
    {
        recordInputPlayback("UnitTests/Recordings/RecordingTestBasicMovement.mrc");
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
        
        // quit early before dying
        if (global.recordInputFrame >= 2000)
        {
            global.recordInputMode = 0;
            room_goto(rmUnitTest);
            unitEnd();
            exit;
        }
        
        // Error message could be made more useful... try reading the timer to see what mega man
        // is currently doing?
        unitRequire(global.recordInputFidelity == 0,
            "Something about mega man's basic physics has changed. This seriously requires investigation!");
    }
    
    if (unitCleanUp())
    {
        global.recordInputMode = 0;
        room_goto(rmUnitTest);
    }
}

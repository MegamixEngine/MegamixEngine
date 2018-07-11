if (unitCase("Boss doors"))
{
    if (unitBegin())
    {
        // dummy recording
        recordInputPlayback("UnitTests/Recordings/RecordingTestBasicMovement.mrc");
        global.recordInputRoom = getRoom("lvlUnitTestBossDoors", "UnitTests/Rooms/lvlUnitTestBossDoors");
        global.recordInputScriptOverride = testSuiteBossDoorsHelperMockInput;
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
        
        // death is an error
        unitRequire(instance_exists(objMegaman) || global.recordInputFrame < 150, "Mega man despawned");
        
        // TLE
        unitRequire(global.recordInputFrame <= 20000, "Time Limit expired");
        
        with (objMegaman)
        {
            if (place_meeting(x, y, objLadder))
            {
                global.recordInputMode = 0;
                room_goto(rmUnitTest);
                unitEnd();
                exit;
            }
        }
    }
    
    if (unitCleanUp())
    {
        global.recordInputMode = 0;
        room_goto(rmUnitTest);
    }
}

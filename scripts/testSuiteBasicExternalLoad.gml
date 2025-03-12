// checks that external room loading is functional.
// important for other tests.

// this unit test lasts multiple frames. Therefore,
// instead of a single unitExecute() block, there
// are unitBegin(), unitTick(), and unitCleanUp() blocks.

if (unitCase("External room loading"))
{
    unitCritical();
    
    // setup
    if (unitBegin())
    {
        // load external room
        lvlUnitTestRecordBasic = roomExternalLoad("UnitTests/Rooms/lvlUnitTestBasic");
        
        // makes sure room loaded
        unitRequire(lvlUnitTestRecordBasic >= 0);
        if (unitValid()) // ensure require did not fail
        {
            room_goto(lvlUnitTestRecordBasic);
        }
    }
    
    if (unitTick())
    {
        // ensure room changed.
        unitRequire(room == lvlUnitTestRecordBasic, "Did not go to the correct room.");
        
        // finish test.
        unitEnd();
    }
    
    // clean-up
    if (unitCleanUp())
    {
        room_goto(lvlShowcaseHUB);
    }
}

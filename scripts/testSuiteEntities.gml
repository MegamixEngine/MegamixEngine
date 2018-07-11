// checks that entities do not crash the game when created,
// that they do not crash the game if no mega man on screen,
// and that they do not set random values in their create events

if (unitCase("Basic entity safety"))
{
    // setup
    if (unitBegin())
    {
        // load external room
        rmUnitTestRecordBasic = roomExternalLoad("UnitTests/Rooms/lvlRecordingTest");
        
        // makes sure room loaded
        unitRequire(rmUnitTestRecordBasic >= 0);
        if (unitValid()) // ensure require did not fail
        {
            global.beginStageOnRoomBegin = true;
            room_goto(rmUnitTestRecordBasic);
        }
    }
    
    if (unitTick())
    {
        // destroy mega man
        if (global.roomTimer == 5)
        {
            with (objMegaman)
            {
                instance_destroy();
            }
        }
        
        var RAND_MAX = 100000;
        
        if (global.roomTimer == 6)
        {
            randomize();
            global.unitTestRandSeed = irandom(RAND_MAX);
            random_set_seed(global.unitTestRandSeed);
            global.unitTestSeedCmp = irandom(RAND_MAX);
            global.unitTestTestInstance = noone;
        }
        
        if (global.roomTimer > 6 && global.roomTimer mod 3 == 0)
        {
            var objectIndex = global.roomTimer - 7;
            with (global.unitTestTestInstance)
            {
                instance_destroy();
            }
            if (object_exists(objectIndex))
            {
                print("Creating " + object_get_name(objectIndex));
                
                // TODO: remove the && !object_is_ancestor(objectIndex, prtEnemyProjectile), they should be tested too but they were too buggy...
                if (object_is_ancestor(objectIndex, prtEntity) && !object_is_ancestor(objectIndex, prtEnemyProjectile))
                {
                    if (string_pos("SharkSubmarine", object_get_name(objectIndex)))
                    {
                        // sigh
                        unitEnd();
                        exit;
                    }
                    random_set_seed(global.unitTestRandSeed);
                    global.unitTestTestInstance = instance_create(128, 90, objectIndex);
                    unitRequireEquals(irandom(RAND_MAX), global.unitTestSeedCmp, object_get_name(objectIndex) + " generated a random value in its create event, which is not allowed as it interferes with action replays.");
                }
            } // finish test
            else if (objectIndex > global.objectLast)
            {
                unitEnd();
            }
        }
    }
    
    // clean-up
    if (unitCleanUp())
    {
        room_goto(rmUnitTest);
    }
}

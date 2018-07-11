// ensures playback of recordings actually functions.
// absolutely necessary for any gameplay unit tests.

exit;

var objectCheck = makeArray(objSolid, objLadder, objSpike, objWater, objIce, objBossDoor);
for (var i = 0; i < array_length_1d(objectCheck); i++)
{
    var objectPlace = objectCheck[i];
    var objectName = object_get_name(objectPlace);
    if (unitCase("Object setter can place " + objectName))
    {
        unitCritical();
        
        // single-execution
        if (unitBegin())
        {
            recordInputPlayback("UnitTests/Recordings/RecordingObjectSet.mrc");
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
            
            if (global.recordInputFrame == 3)
            {
                instance_activate_all();
            }
            
            if (global.recordInputFrame == 4)
            {
                var placed = false;
                with (objectPlace)
                {
                    if (y < 256)
                    {
                        placed = true;
                    }
                }
                
                unitRequire(placed, "objObjectSetter failed to place " + objectName);
                
                unitEnd();
                exit;
            }
            
            unitRequire(global.recordInputFrame <= 4, "Was supposed to exit recording on frame 4.");
        }
        
        if (unitCleanUp())
        {
            global.recordInputMode = 0;
            room_goto(rmUnitTest);
        }
    }
}

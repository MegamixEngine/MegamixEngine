/// recordInputHandle()
/// handles recording and playback for recorded input
/// called each frame by objGlobalControl

if (global.recordInputMode == 0)
{
    // no need for this to grow indefinitely.
    global.recordInputFidelityMessageBuffer = "";
}
else
{
    // periodically record mega man's coordinates for error-checking
    if (global.recordInputFrame mod 30 == 20 && instance_exists(objMegaman))
    {
        recordInputFidelityMessage(string(round(objMegaman.x)) + "," + string(round(objMegaman.y)));
    }
}

// recording
if (global.recordInputMode == 1)
{
    // recording -- begin
    if (global.recordInputBegin)
    {
        // go to correct room for recording input
        if (room == global.recordInputRoom && global.recordInputSkipSpawn)
        {
            global.recordInputBegin = false;
            global.recordInputFidelityMessageBuffer = "";
            
            // set random seed (created in saveLoadRecordInput)
            //random_set_seed_safe(global.recordInputRandomSeed); Handled in DefaultSpawn now due to object/action priority.
        }
        else if (global.nextRoom != global.recordInputRoom)
        {
            global.nextRoom = global.recordInputRoom;//room_goto(global.recordInputRoom);
            global.recordInputSkipSpawn = true;
            
            exit;
        }
    }
    
    // recording -- frame logic
    recordInputAppendFrame();
    global.recordInputFrame++;
}

// playback
if (global.recordInputMode == 2)
{
    // playback -- begin
    if (global.recordInputBegin)
    {
        if (room == global.recordInputRoom)
        {
            global.recordInputBegin = false;
            if (false)//global.recordInputSkipSpawn)
            {
                // skipping spawn -- we must warp directly to the recording start point and
                // set up mega man's state correctly.
                global.playerCount = global.recordPlayerCount;
                
                // we'll replace this with our own
                with (objMegaman)
                    instance_destroy();
                
                // setup player values
                for (var i = 0; i < global.playerCount; i++)
                {
                    global.playerHealth[i] = global.recordInputPlayerHealth[i];
                    for (var j = 0; j <= global.totalWeapons; j++)
                    {
                        global.ammo[i, j] = global.recordInputAmmo[i, j];
                    }
                    
                    global.weapon[i] = global.recordInputWeapon[i];
                    global.respawnTimer[i] = global.recordInputRespawnTimer[i];
                    
                    if (global.recordInputActive[i])
                    {
                        with (instance_create(0, 0, objMegaman))
                        {
                            playerID = i;
                            x = global.recordInputPlayerX[i];
                            y = global.recordInputPlayerY[i];
                            image_xscale = global.recordInputXScale[i];
                            image_yscale = global.recordInputYScale[i];
                            gravfactor = global.recordInputGravFactor[i];
                            gravDir = global.recordInputGravDir[i];
                            playerPalette();
                            visible = true;
                        }
                    }
                }
                
                setSection(objMegaman.x, objMegaman.y, true);
                playerCamera(1);
                reAndDeactivateObjects(1, 1);
            }
            
            global.recordInputFidelityMessageBuffer = "";
            
            // set random seed
            //random_set_seed_safe(global.recordInputRandomSeed); Handled in objDefaultSpawn now.
        }
        else
        {
            if (!global.nextRoom)
            {
                global.playerCount = global.recordPlayerCount;
                global.livesEnabled = false;
                goToLevel(global.recordInputRoom);
            }
            exit;
        }
    }
    
    // playback -- frame logic
    var status = recordInputReadFrame();
    if (status == 1)
    {
        global.recordInputEnd = false;
        print("Playback Complete", WL_VERBOSE);
    }
    if (status == 2)
    {
        global.recordInputEnd = false;
        print("Playback Aborted", WL_VERBOSE);
    }
    if (status != 0)
    {
        global.recordInputMode = 0;
        randomize();
        saveLoadOptions(false);
        global.roomReturn = global.recordInputReturnRoom;
        returnFromLevel(false);
    }
    global.recordInputFrame++;
}

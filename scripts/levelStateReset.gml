/// levelStateReset()
/// resets stage variables

global.endStageOnRoomEnd = false;

// - - - - - - - - - - - - - - - - - - - - - - - - - 

//global.levelReward = makeArray(0);
global.bossTextShown = false;

global.freeMovement = false;
global.timeStopped = false;

disableRespawnReset(); //Reset collected pickups

setCheckpoint(0);

// Refresh health and ammo
for (var i = 0; i < global.playerCount; i++)
{
    playerStateReset(i);
}

global.displayCheck = false;
global.protoWhistle = false;
// TODO: level reward, etc.

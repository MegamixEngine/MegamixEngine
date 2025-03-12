/// stageStart()
/// sets the game as currently in a stage, resetting the level's run statistics.
// this is called by default after the room begins after calling goToLevel(),
// but you can actually call it mid-way through a hub level if you want it
// to switch to being a stage for some reason.
if (!global.inGame)
{
    print("Attempted to start a stage while not in a game room", WL_ERR*DEBUG_ENABLED);
}

print("Beginning Stage");

with (prtLevelCallbacks)
    event_user(0);

global.stage = global.roomName;

/// stageStart()
/// sets the game as currently in a stage, resetting the level's run statistics.
// this is called by default after the room begins after calling goToLevel(),
// but you can actually call it mid-way through a hub level if you want it
// to switch to being a stage for some reason.

assert(global.inGame, "attempted to start a stage while not in a game room");
global.stageStartRoom = room;
global.levelReward = makeArray(0);

global.bossTextShown = false;

ds_list_clear(pickups);
checkpoint = false;

// refresh health and ammo
for (var i = 0; i < global.playerCount; i++)
{
    resetPlayerState(i);
}

print("Beginning Stage");

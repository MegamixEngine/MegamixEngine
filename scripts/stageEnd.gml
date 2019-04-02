/// stageEnd()
/// sets the game as being no longer in a stage
/// in speed runner terminology, this would mark the end of a split.

assert(global.inGame, "Tried to end stage without being in a stage");
global.endStageOnRoomEnd = false;

ds_list_clear(pickups);

global.timeStopped = false;

// TODO: level reward, etc.
print("Ending Stage");
with(prtLevelCallbacks)
{
    event_user(1);
}

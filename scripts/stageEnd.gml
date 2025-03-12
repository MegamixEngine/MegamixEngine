/// stageEnd()
/// sets the game as being no longer in a stage
/// in speed runner terminology, this would mark the end of a split (Though this does not apply to leaderboard timings, which end on element collection).
if (!global.inGame)
{
    print("Tried to end stage without being in a stage"/*, WL_ERR*global.debugEnabled*/);
}

//assert(global.inGame, "Tried to end stage without being in a stage");
levelStateReset();

//global.timeStopped = false;

// TODO: level reward, etc.
print("Ending Stage");
with(prtLevelCallbacks)
{
    event_user(1);
}

if (!global.stageIsHub)
{
    with (objMusicControl)
    {
        event_user(0);
    }
}

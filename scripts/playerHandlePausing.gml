/// playerHandlePausing();
// Pausing
if (!playerIsLocked(PL_LOCK_PAUSE))
{
    if (!instance_exists(objPauseMenu))
    {
        if (global.keyPausePressed[playerID])
        {
            if (global.playerHealth[playerID] > 0)
            {
                queuePause(true);
                global.createArgument[0] = playerID;
                instance_create(x, y, objPauseMenu);
                playSFX(sfxPause);
            }
        }
    }
}

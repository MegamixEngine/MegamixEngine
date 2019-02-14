/// playerHandlePausing();
// Pausing
if (!playerIsLocked(PL_LOCK_PAUSE))
{
    if (global.keyPausePressed[0])
    {
        if (global.playerHealth[playerID] > 0)
        {
            queuePause(true);
            instance_create(x, y, objPauseMenu);
            playSFX(sfxPause);
        }
    }
}

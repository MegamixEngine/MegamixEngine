/// playerHandlePausing();
// Pausing
if (!playerIsLocked(PL_LOCK_PAUSE))
{
    if (global.keyPausePressed[playerID])
    {
        if (global.playerHealth[playerID] > 0)
        {
            global.frozen = true;
            with (instance_create(x, y, objPauseMenu))
            {
                playerID = other.playerID;
                oldWeapon = global.weapon[playerID];
            }
            playSFX(getGenericSFX(SFX_PAUSE));
        }
    }
}

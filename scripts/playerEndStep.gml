/// playerEndStep
if (!global.frozen && !frozen)
{
    // Pausing
    playerHandlePausing();
    
    // Free movement debug
    playerHandleFreeMovement();
    
    healthpoints = global.playerHealth[playerID];
}

playerHandleDeath();

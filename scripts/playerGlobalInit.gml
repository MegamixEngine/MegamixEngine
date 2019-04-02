/// playerGlobalInit()
// initializes player global variables up to the current player count
// call this any time the number of players increases.

for (var i = global.playerCountInitialized; i < global.playerCount; i++)
{
    global.playerHealth[i] = 28;
    global.weapon[i] = 0;

    global.respawnTimer[i] = -1;
    
    global.primaryCol[i] = c_white;
    global.secondaryCol[i] = c_white;
    global.outlineCol[i] = c_black;
    global.characterSelected[i] = "NONE";
    
    for (var j = 0; j <= global.totalWeapons; j++)
    {
        global.ammo[i, j] = 0;
    }
}

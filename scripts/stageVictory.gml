/// stageVictory(ending)
// name = name of the stage + element index
// Sets the stage to being completed

var ending = argument0;

var name = argument[0];

if (!global.inGame)
{
    print("Tried to end stage without being in a stage");
}

//Lock player movement
victoryLock = playerLockMovement();

//Get rid of level checkpoint
slDelete(global.stage, 1);

//Save the game file
saveLoadGame(true);


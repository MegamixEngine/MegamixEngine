/// customCostume_GetSoundNames()
var fileNameSuffixes = array_create(SFX_LENGTH);
for (var i = 0; i < array_length_1d(fileNameSuffixes); i++)
{
    fileNameSuffixes[i] = "";//Blank for non-specified.
}

fileNameSuffixes[SFX_BUSTER] = "buster";
fileNameSuffixes[SFX_BUSTERCHARGED] = "busterCharged";
fileNameSuffixes[SFX_BUSTERHALFCHARGED] = "busterHalfCharged";
fileNameSuffixes[SFX_CHARGING] = "busterCharging";
fileNameSuffixes[SFX_DOOR] = "bossDoor";
fileNameSuffixes[SFX_HURT] = "hurt";
fileNameSuffixes[SFX_JUMP] = "land";
fileNameSuffixes[SFX_JUMPMARIO] = "jump";
fileNameSuffixes[SFX_SLIDE] = "slide";
fileNameSuffixes[SFX_LIFE] = "life";
fileNameSuffixes[SFX_TANK] = "tank";
fileNameSuffixes[SFX_PLAYERDIE] = "death";
fileNameSuffixes[SFX_REFILL] = "refill";
fileNameSuffixes[SFX_SPLASH] = "splash";
fileNameSuffixes[SFX_TELEIN] = "teleportIn";
fileNameSuffixes[SFX_TELEOUT] = "teleportOut";
fileNameSuffixes[SFX_PAUSE] = "pause";
fileNameSuffixes[SFX_UNPAUSE] = "unpause";
fileNameSuffixes[SFX_RUSHBIKE_START] = "bikeStart";
fileNameSuffixes[SFX_RUSHBIKE_JUMP] = "bikeJump";
fileNameSuffixes[SFX_RUSHBIKE_SKID] = "bikeSkid";
fileNameSuffixes[SFX_VICTORY] = "pose";
fileNameSuffixes[SFX_LOOKUP] = "lookUp";
fileNameSuffixes[SFX_SPIN] = "spin";
fileNameSuffixes[SFX_VICTORYMUS] = "victory";
fileNameSuffixes[SFX_WHISTLE] = "whistle";
return fileNameSuffixes;

///playerGetFrozen(type, [damage], [time])
// freezes the player. only call ON the player

// type: 0 = frozen, 1 = paralyzed

var freezeType = argument[0];

var freezeDMG = 2;
var freezeTime = 60;

if (argument_count >= 2)
    freezeDMG = argument[1];
if (argument_count >= 3)
    freezeTime = argument[2];    

if (freezeDMG < 0)
    exit;

// freezing code starts here
if !(checkCheats(cheatEnums.invincible) && !checkCheats(cheatEnums.buddha))
{
    if (!isHit)
    {
        if (global.characterSelected[playerID] == CHAR_PROTOMAN && freezeDMG >= 1) // +2 damage for Proto Man
            freezeDMG += 2;
    
        global.damage = freezeDMG;
        if (global.damagePopup) // Damagepopup
        {
            instance_create(bboxGetXCenter(), bbox_top + 4, objDamagePopup);
        }

        if (global.skullAmulet)
        {
            if (!(global.playerHealth[playerID] - freezeDMG) && global.playerHealth[playerID] > 1)
            {
                freezeDMG = global.playerHealth[playerID] - 1;
                playSFX(sfxSkullAmulet);
            }
        }
        global.playerHealth[playerID] -= freezeDMG;
    }

    freezeTimer = freezeTime;
    isFrozen = freezeType;
    xspeed = 0;
    yspeed = 0;
    playerHandleSprites('Normal');
    playerPalette();
    
    climbing = false;
    climbLock = lockPoolRelease(climbLock);
}

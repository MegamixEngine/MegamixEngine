///coopWarp(playerID,[autoTrigger],[time],[global.frozen],[playSFX],[movePlayer],[freeOnScreenTransition],[specificPlayerToWarp]);

//playerID: Player ID to warp to
//autoTrigger: Automatically release when timer finishes. If false, you need to use this code to end the warp: with (objCoOpWarpStar) {event_user(EV_DEATH);} (default: true)
//time: How long in frames it lasts (default: 15)
//global.frozen: Whether or not global.frozen is taken into consideration (default: true)
//playSFX: Whether to play teleporting SFX on creation (default: true)
//movePlayer: If false, the warp is purely visual and doesn't change the player's x/y position (default: true)
//freeOnScreenTrans: coop warps are automatically released on screen transition; setting this to false will override that. (default: true)
//specificPlayerToWarp: If set to a playerID, only that player will get warped instead of all other players (default: -1)

var pid = argument[0];
var pg; if (argument_count > 1) pg = argument[1]; else pg = false;
var tim; if (argument_count > 2) tim = argument[2]; else tim = 15;
var frz; if (argument_count > 3) frz = argument[3]; else frz = true;
var sf; if (argument_count > 4) sf = argument[4]; else sf = true;
var mp; if (argument_count > 5) mp = argument[5]; else mp = true;
var freeOnScreenTrans; if (argument_count > 6) freeOnScreenTrans = argument[6]; else freeOnScreenTrans = true;
var specificPlayerToWarp; if (argument_count > 7) specificPlayerToWarp = argument[7]; else specificPlayerToWarp = -1;

var mX = 0;
var mY = 0;
var myPlayerObj;

with (objMegaman)
{
    if (playerID == pid)
    {
        mX = x;
        mY = y;
        myPlayerObj = id;
    }
}

with (objMegaman)
{
    if (playerID !=  pid)
    {
        if (specificPlayerToWarp > -1)
        {
            if (playerID != specificPlayerToWarp)
            {
                continue;
            }
        }
        
        var myP = playerID;
        var meID = id;
        playerPalette();
        dieToPit = false;
        dieToSpikes = false;
        visible = false;
        if (instance_exists(objCoOpWarpStar))
        {
            with (objCoOpWarpStar)
            {
                if (playerID == myP)
                continue;
            }
        }
        
        if (instance_exists(objRushCycle))
        {
            with (objRushCycle)
            {
                if (rider == other.id)
                {
                    instance_destroy();
                }
            }
        }
 
        with (instance_create(x,y,objCoOpWarpStar))
        {
            var warpS = id;
            playSound = sf;
            if (playSound)
            {
                playSFX(getGenericSFX(SFX_TELEOUT));
            }
            parent = meID;
            playerID = myP;
            targetPlayerID = pid;
            myPal[0] = global.primaryCol[myP];
            if (!global.multiplayerColors)
                myPal[1] = global.secondaryCol[myP];
            else
                myPal[1] = merge_color(global.primaryCol[myP],c_white,0.75);
            myPal[2] = global.outlineCol[myP];
            timerMax = tim;
            freeOnKill = pg;
            if (distance_to_point(mX,mY) < tim *2)
            {
                fastTimer = true;
            }
            movePlayer = mp;
            freezeActive = frz;
            cAngle += myP * 30;
            depth = myPlayerObj.depth + playerID;
            freeOnScreenTransition = freeOnScreenTrans;
        }
        
        warpS.myLock = lockPoolLock(
                localPlayerLock[PL_LOCK_MOVE],
                localPlayerLock[PL_LOCK_PHYSICS],
                localPlayerLock[PL_LOCK_SHOOT],
                localPlayerLock[PL_LOCK_CLIMB],
                localPlayerLock[PL_LOCK_CHARGE],
                localPlayerLock[PL_LOCK_PAUSE],
                localPlayerLock[PL_LOCK_TURN],
                localPlayerLock[PL_LOCK_GRAVITY],
                localPlayerLock[PL_LOCK_SLIDE],
                localPlayerLock[PL_LOCK_WEAPONCHANGE],
                );
    }
}

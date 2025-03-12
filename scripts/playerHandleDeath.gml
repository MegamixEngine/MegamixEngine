/// playerHandleDeath();
// Dying

var maxHealth = 28;

//Cheats
if (cheatsAllowed())
{
    if (global.playerHealth[playerID] < maxHealth)
    {
        if (checkCheats(cheatEnums.instantDeathMode))
        {
            global.playerHealth[playerID] = 0;
        }

        if !deathByPit
        {
            if (checkCheats(cheatEnums.buddha) && global.playerHealth[playerID] <= 0)
            {
                global.playerHealth[playerID] = 1;
            }
            
            if (checkCheats(cheatEnums.invincible))
            {
                global.playerHealth[playerID] = maxHealth;
            }
        }
    }
}

if (global.playerHealth[playerID] <= 0)
{
    var stopSfx = 0;
    var playSfx = 0;
    
    if (deathTimer)
    {
        deathTimer --;
    }
    
    if (deathTimer <= 0)
    {
        // - - - - - - - - - - - - - - - - - - - - - - - - - - - -
        
        //Players left?
        tpk = true;
        
        for (var i = 0; i < global.playerCount; i ++)
        {
            print(i);
            if (global.playerHealth[i] > 0)
            {
                tpk = false;
            }
        }
        
        recordInputFidelityMessage("Death " + string(playerID));
        
        //Start death
        if (deathTimer == -1)
        {
            if (deathByPit) //Skip death if died by pit
            {
                deathTimer = 0;
                playSfx = 1;
            }
            else
            {
                deathTimer = 30;
                global.frozen = true;
                
                isHit = 0;
                playerPalette();
                
                yspeed = 0;
                xspeed = 0;
            }
            
            stopSfx = 1;
        }
        
        // - - - - - - - - - - - - - - - - - - - - - - - - - - - -
        
        //Actual death
        if (deathTimer == 0)
        {
            // - - - - - - - - - - - - - - - - - - - - - - - - - - - -
            
            //Visual effect
            if (!deathByPit)
            {
                applyRumble(playerID, 0, 1, 0.0075, 120);
                
                for (i = 0; i < 16; i += 1)
                {
                    explosionID = instance_create(x, y, objMegamanExplosion);
                    explosionID.dir = i * 45;
                    explosionID.spd = 0.75 * (1 + floor(i / 8));
                    
                    with (explosionID)
                    {
                        if (global.deathEffect >= 1)
                        {
                            sprite_index = sprExplosionClassic;
                            if (global.deathEffect == 2)
                            {
                                var RNG_C = irandom_range(15,25);
                                myPal[0] = global.nesPalette[RNG_C];
                                myPal[1] = global.nesPalette[RNG_C + $10];
                            }
                        }
                        else
                        {
                            sprite_index = sprExplosion;
                        }
                    }
                    
                }
                
                playSfx = 1;
                global.frozen = false;
            }
            
            // - - - - - - - - - - - - - - - - - - - - - - - - - - - -
            playerPalette(); //reset palette so UI stuff works properly.
            instance_destroy(); //DIE
            
            var iRoom = global.checkpoint;
            
            if (tpk) //No players left - Back to checkpoint
            {
                global.decrementLivesOnRoomEnd = true;
                
                with (objGlobalControl)
                {
                    alarm[0] = (3 * global.gameSpeed);
                    for (var i = 0; i < global.playerCount; i ++)
                    {
                        respawnLocation[i] = -1;

                    }
                }
            }
            else //Players left - Respawn
            {
                var time = global.respawnTime; //Time to respawn
                
                if (instance_exists(prtBoss)) //Extend if boss is around
                {
                    time *= global.respawnTimeBoss;
                }
                
                var pID = playerID;
                global.respawnTimer[pID] = time;
                with (objGlobalControl)
                {
                    for (var i = 0; i < global.playerCount; i ++)
                    {
                        if (respawnLocation[i] == -1)
                        {
                            respawnLocation[i] = pID;
                            break;
                        }
                    }
                }
            }
            
            // - - - - - - - - - - - - - - - - - - - - - - - - - - - -
        }
    }
    
    // - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    
    var deathSFX = getGenericSFX(SFX_PLAYERDIE);
    
    if (stopSfx)
    {
        if (tpk)
        {
            for (i = 0; i <= 4000; i += 1)
            {
                if (i != deathSFX)
                {
                    stopSFX(i);
                }
            }
            
            stopMusic();
            global.levelSong = "";
            global.levelTrackNumber = -1;
        }
    }
    
    if (playSfx)
    {
        playSFX(deathSFX); //Handled later otherwise.
    }
    
    // - - - - - - - - - - - - - - - - - - - - - - - - - - - -
}


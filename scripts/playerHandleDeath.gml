/// playerHandleDeath();
// Dying

// Set up death sound
if (global.deathEffect)
{
    deathSFX = sfxDeathClassic;
}
else
{
    deathSFX = sfxDeath;
}

if (global.playerHealth[playerID] <= 0)
{
    if (deathTimer)
    {
        deathTimer -= 1;
    }
    
    if (!deathTimer)
    {
        tpk = instance_number(objMegaman) <= 1;
        recordInputFidelityMessage("Death " + string(playerID));
        
        // stop audio and play death sound
        if ((tpk && !audio_is_playing(deathSFX) && deathTimer == 0)
            || (deathByPit && deathTimer == -1))
        {
            // stop cUTTING OFF THE DEATH SOUND AAAAA
            for (i = 0; i <= 4000; i += 1)
            {
                if (i != deathSFX)
                {
                    stopSFX(i);
                }
            }
            stopMusic();
            playSFX(deathSFX);
            
            // for pit
            if (deathTimer == -1)
            {
                deathTimer = -2;
            }
        }
        
        if (!deathByPit)
        {
            if (deathTimer == -1)
            {
                deathTimer = 30;
                queuePause(true);
                isHit = 0;
                playerPalette();
                yspeed = 0;
                xspeed = 0;
                
                // stop cUTTING OFF THE DEATH SOUND AAAAA
                for (i = 0; i <= 4000; i += 1)
                {
                    if (i != deathSFX)
                    {
                        stopSFX(i);
                    }
                }
                stopMusic();
                
                exit;
            }
            
            for (i = 0; i < 16; i += 1)
            {
                explosionID = instance_create(x, y, objMegamanExplosion);
                explosionID.dir = i * 45;
                explosionID.spd = 0.75 * (1 + floor(i / 8));
                with (explosionID)
                {
                    if (global.deathEffect)
                    {
                        sprite_index = sprExplosionClassic;
                    }
                    else
                    {
                        sprite_index = sprExplosion;
                    }
                }
            }
        }
        
        if (tpk)
        {
            global.decrementLivesOnRoomEnd = true;
            with (objGlobalControl)
            {
                alarm[0] = 3 * room_speed;
            }
        }
        else
        {
            global.respawnTimer[playerID] = global.respawnTime * max(1,
                instance_exists(prtBoss) * global.respawnTimeBoss);
        }
        
        instance_destroy();
        queueUnpause(true);
    }
}

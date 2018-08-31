var bulletLimit = 3;
var weaponCost = 0;
var action = 1; // 0 - no frame; 1 - shoot; 2 - throw
var willStop = 0; // If this is 1, the player will halt on shooting ala Metal Blade.

var chargeTime = 57; // Set charge time for this weapon
var initChargeTime = 20;

if (!global.lockBuster)
{
    if (global.keyShootPressed[playerID] && !playerIsLocked(PL_LOCK_SHOOT) && chargeTimer == 0)
    {
        i = fireWeapon(16, 0, objBusterShot, bulletLimit, weaponCost, action, willStop);
        if (i)
        {
            i.xspeed = image_xscale * 5; // zoom
        }
    }
    
    //////////////
    // Charging //
    //////////////
    
    if (global.enableCharge)
    {
        if ((global.keyShoot[playerID] || (isSlide && chargeTimer > 0))
            && !playerIsLocked(PL_LOCK_CHARGE))
        {
            if (!isShoot)
            {
                isCharge = true;
                
                if (!isSlide)
                {
                    initChargeTimer += 1;
                }
                
                if (initChargeTimer >= initChargeTime)
                {
                    if (!chargeTimer)
                    {
                        playSFX(sfxCharging);
                    }
                    
                    chargeTimer++;
                    
                    if (chargeTimer < chargeTime)
                    {
                        var chargeTimeDiv, chargeCol;
                        chargeTimeDiv = round(chargeTime / 3);
                        
                        if (chargeTimer < chargeTimeDiv)
                        {
                            chargeCol = make_color_rgb(168, 0, 32); // Dark red
                        }
                        else if (chargeTimer < chargeTimeDiv * 2)
                        {
                            chargeCol = make_color_rgb(228, 0, 88); // Red (dark pink)
                        }
                        else
                        {
                            chargeCol = make_color_rgb(248, 88, 152); // Light red (pink)
                        }
                        
                        if (chargeTimer mod 6 >= 0 && chargeTimer mod 6 < 3)
                        {
                            global.outlineCol[playerID] = chargeCol;
                        }
                        else
                        {
                            global.outlineCol[playerID] = c_black;
                        }
                    }
                    else
                    {
                        if (chargeTimer == chargeTime)
                        {
                            audio_stop_sound(sfxCharging);
                            playSFX(sfxCharged);
                        }
                        if (!inked)
                        {
                            switch (floor(chargeTimer / 3 mod 3))
                            {
                                case 0: // Light blue helmet, black shirt, blue outline 
                                    global.primaryCol[playerID] = rockSecondaryCol;
                                    global.secondaryCol[playerID] = c_black;
                                    global.outlineCol[playerID] = rockPrimaryCol;
                                    break;
                                case 1: // Black helmet, blue shirt, light blue outline 
                                    global.primaryCol[playerID] = c_black;
                                    global.secondaryCol[playerID] = rockPrimaryCol;
                                    global.outlineCol[playerID] = rockSecondaryCol;
                                    break;
                                case 2: // Blue helmet, light blue shirt, blue outline 
                                    global.primaryCol[playerID] = rockPrimaryCol;
                                    global.secondaryCol[playerID] = rockSecondaryCol;
                                    global.outlineCol[playerID] = c_black;
                                    break;
                            }
                        }
                    }
                }
            }
        }
        else // Release the charge shot
        {
            if (!playerIsLocked(PL_LOCK_SHOOT) && chargeTimer != 0 && !isSlide)
            {
                /////////////////////
                // ACTUAL SHOOTING //
                /////////////////////
                
                if (chargeTimer < chargeTime) // Half charge
                {
                    i = fireWeapon(12, 0, objBusterShotHalfCharged, bulletLimit, weaponCost, action, willStop);
                    if (i)
                    {
                        i.xspeed = image_xscale * 5;
                    }
                }
                else // Full charge
                {
                    i = fireWeapon(20, 0, objBusterShotCharged, 3, 0, 1, 0);
                    if (i)
                    {
                        i.xspeed = image_xscale * 5.5;
                    }
                }
                
                // Reset all charging stuff
                chargeTimer = 0;
                initChargeTimer = 0;
                audio_stop_sound(sfxCharged);
                audio_stop_sound(sfxCharging);
                playerPalette(); // Reset the colors
            }
        }
    }
}

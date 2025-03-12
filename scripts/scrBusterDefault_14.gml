
if (global.lockBuster)
{
    exit;
}

var bulletLimit = 3 + (12 * (global.shotUpgrade > 0));
var weaponCost = 0;
var action = 1; // 0 - no frame; 1 - shoot; 2 - throw
var willStop = 0; // If this is 1, the player will halt on shooting ala Metal Blade.

// Set charge time for this weapon
chargeTime = 57; 
initChargeTime = 20;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

if (performShoot) //Shoot
{
    if ((global.customCostumeEquipped[playerID] && global.customCostumeShotSetting[playerID] == 1))
    {
        action = 2;
    }
    if ((global.customCostumeEquipped[playerID] && global.customCostumeShotSetting[playerID] == 2))
    {
        action = 3;
    }
    if (!releaseCharge) //Not charged
    {
        i = fireWeapon(16+6, 0, objBusterShot, bulletLimit, weaponCost, action, willStop);
        if (i)
        {
            i.xspeed = image_xscale * 5;
            
            if (global.characterSelected[playerID] == CHAR_BASS) // Set damage to 1 when riding vehicles in Bass Mode
            {
                i.contactDamage = 1;
            }
        }
    }
    
    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
    
    //Release charge shot
    else
    {
        if (isCharge == 1) // Half charge
        {
            weaponCost *= 2;
            i = fireWeapon(12+6, 0, objBusterShotHalfCharged, bulletLimit, weaponCost, action, willStop);
            if (i)
            {
                i.xspeed = (image_xscale * 5);
            }
        }
        else // Full charge
        {   
            weaponCost *= 3;
            if (global.customCostumeEquipped[playerID] && global.customCostumeChargeShotSetting[playerID] == 1) // Special exception for Cut Man
            {
                action = 2;
            }
            else if (global.customCostumeEquipped[playerID] && global.customCostumeChargeShotSetting[playerID] == 2) // Special-er exception for Dr. Light
            {
                action = 3;
            }
            else
            {
                action = 1;
            }
            
            i = fireWeapon(20+6, 0, objBusterShotCharged, bulletLimit, 0, action, 0);
            if (i)
            {
                i.xspeed = (image_xscale * 5.5);
                applyRumble(playerID,0,.75,.05,60);
            }
            
        }
        audio_stop_sound(getGenericSFX(SFX_CHARGING));
    }
}


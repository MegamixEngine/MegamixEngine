if (global.lockBuster)
{
    exit;
}

var bulletLimit = 2 + (12 * (global.shotUpgrade > 0));
var weaponCost = 0;
var action = 1; // 0 - no frame; 1 - shoot; 2 - throw
var willStop = 0; // If this is 1, the player will halt on shooting ala Metal Blade.

chargeTime = 57; // Set charge time for this weapon
initChargeTime = 20;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if (isCharge > 0)
{
    if (chargeTimer >= chargeTime && !inked) // Full Charge palette effect
    {
        switch (floor(chargeTimer / 2 mod 4))
        {
            case 0: // Bright yellow nuclear power
                global.primaryCol[playerID] = make_color_rgb(240, 184, 56); //pals[0];//rockSecondaryCol;
                global.secondaryCol[playerID] = make_color_rgb(248, 224, 160);//pals[1];//c_black;
                global.outlineCol[playerID] = make_color_rgb(248, 112, 96);//pals[2];//rockPrimaryCol;
                break;
            case 1: // Normal colours, white if we're fully charged
                global.primaryCol[playerID] = getWeaponPrimaryColor(global.weapon[playerID], costumeID);//rockPrimaryCol;playerPalette
                global.secondaryCol[playerID] = getWeaponSecondaryColor(global.weapon[playerID], costumeID);
                global.outlineCol[playerID] = c_black;
                break;
            case 2: // Normal colours but we're slightly purple
                global.primaryCol[playerID] = getWeaponPrimaryColor(global.weapon[playerID], costumeID);
                global.secondaryCol[playerID] = getWeaponSecondaryColor(global.weapon[playerID], costumeID);
                global.outlineCol[playerID] = make_color_rgb(184, 0, 184); //c_black;
                break;
            case 3: // Normal colours
                global.primaryCol[playerID] = getWeaponPrimaryColor(global.weapon[playerID], costumeID);//rockPrimaryCol;playerPalette
                global.secondaryCol[playerID] = getWeaponSecondaryColor(global.weapon[playerID], costumeID);
                global.outlineCol[playerID] = c_black; //pals[3];
                break;
        }
    }
    else // Half Charge palette effect
    {
        var chargeTimeDiv, chargeCol;
        chargeTimeDiv = round(chargeTime / 3);
        
        chargeCol = make_color_rgb(184, 0, 184); //(148,0,132);//make_color_rgb(168, 0, 32); // Dark red

        if (chargeTimer mod 6 >= 0 && chargeTimer mod 6 < 3)
        {
            global.outlineCol[playerID] = chargeCol;
        }
        else
        {
            global.outlineCol[playerID] = c_black;
        }
    }
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

if (performShoot) //Shoot
{
    if (!releaseCharge) //Not charged
    {
        i = fireWeapon(16, 0, objBusterShot, bulletLimit, weaponCost, action, willStop);
        if (i)
        {
            i.xspeed = image_xscale * 5;
        }
    }
    
    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
    
    //Release charge shot
    else
    {
        if (isCharge == 1) // Half charge
        {
            weaponCost *= 2;
            i = fireWeapon(12, 1, objBusterShotHalfChargedProto, bulletLimit, weaponCost, action, willStop);
            if (i)
            {
                i.xspeed = (image_xscale * 5);
            }
        }
        else // Full charge
        {   
            weaponCost *= 3;
            action = 1;

            i = fireWeapon(20, 1, objBusterShotChargedProto, bulletLimit, 0, action, 0);
            if (i)
            {
                i.xspeed = (image_xscale * 5.5);
                applyRumble(playerID,0,.75,.05,60);
            }
            
        }
        audio_stop_sound(getGenericSFX(SFX_CHARGING));
    }
}


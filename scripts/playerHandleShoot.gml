/// playerHandleShoot()
// Handles Mega Man's shooting

global.playerProjectileCreator = id;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

performShoot = 0;
releaseCharge = 0;
isCharge *= (chargeTime != 0);

//Reset them here as a failsafe
chargeTime     = 0; 
initChargeTime = 0;

var isProtoBuster = (global.characterSelected[playerID] == CHAR_PROTOMAN && global.weapon[playerID] == 0);

var chargeup = 0;
var shootLocked = playerIsLocked(PL_LOCK_SHOOT);

if (!playerIsLocked(PL_LOCK_CHARGE) && global.enableCharge) //Handle charge
{
    var useToggle = 0;
    
    chargeup = global.keyShoot[playerID];

    if (global.weapon[playerID] == global.weaponID[? objBusterShot] || //Buster, Break Dash, and Treble Burst
        global.weapon[playerID] == global.weaponID[? objBreakDash]) 
    {
        if (global.autoCharge == 1) //Auto charging
        {
            chargeup = !chargeup;
        }
        else if (global.autoCharge == 2) //Toggle charge
        {
            useToggle = 1;
        }
    }
    //else //All other weapons
    //{
        if (global.weapon[playerID] != global.weaponID[? objBusterShot] && 
        global.weapon[playerID] != global.weaponID[? objRushCycle])
        {
            if (global.holdToggle)
            {
                useToggle = 1;
            }
        }
    //}
    
    if (useToggle)
    {
        if (global.keyShootPressed[playerID])
        {
            fireHeld = !fireHeld;
        }
        
        chargeup = fireHeld;
    }
    
    if (checkCheats(cheatEnums.instantCharge))
    {
        chargeup = false;
        isCharge = ternary(global.autoFire && !autoFireDelay,global.keyShoot[playerID],global.keyShootPressed[playerID])*2;
    }
    
    if (!chargeup) //Don't charge
    {
        if (isCharge) //But we have been charging prior
        {
            if (!shootLocked) //Only release if we can shoot
            {
                releaseCharge = 1; //RELEASE
                audio_stop_sound(getGenericSFX(SFX_CHARGING));
                audio_stop_sound(getGenericSFX(SFX_CHARGED));
            }
            else //Keep charged even if not pressing
            {
                chargeup = 1;
            }
        }
    }
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
    
if (!shootLocked) //Check if we should fire the weapon
{
    if (global.autoFire && (autoFireDelay >= 0))
    {
        if (!autoFireDelay)
        {
            performShoot = global.keyShoot[playerID];
        }
    }
    else
    {
        performShoot = global.keyShootPressed[playerID];
    }
    
    if (releaseCharge)
    {
        performShoot = 1;
    }
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

// Shooting
event_perform_object(global.weaponObject[global.weapon[playerID]], ev_other, ev_user14);

//No charging time set? Stop charging
if ((chargeTime == 0) || (releaseCharge))
{
    isCharge = 0;
}
var rumblePower = .5;//Apply dampening to all charging.
if (chargeup) //Charge up
{
    if (!isShoot)
    {
        switch(isCharge)
        {
            case 0: // No charge
                
                if (!shootLocked)
                {
                    initChargeTimer ++;
                }
                
                if (initChargeTimer >= initChargeTime)
                {
                    isCharge = 1;
                    chargeTimer = 0;
                }
                
                break;
            
            // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
                
            case 1: // Half charged
                
                if (!chargeTimer) //SFX
                {
                    playSFX(getGenericSFX(SFX_CHARGING));//sfxCharging);
                }
                
                var chargeTimeDiv = round(chargeTime / 3);
                var chargeCol = c_black;
                if (((chargeTimer / 6) mod 1) < 0.5)
                {
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
                }
                
                if (!isProtoBuster)
                {
                    global.outlineCol[playerID] = chargeCol;
                }
                
                
                
                chargeTimer ++;
                
                if (chargeTimer >= chargeTime)
                {
                    isCharge = 2;
                }
                //applyRumble(playerID,-1,(chargeTimer/chargeTime)*.5*rumblePower,0.01,1);
                break;
                
            // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
                
            case 2: // Fully charged
            
                if (chargeTimer == chargeTime) //SFX
                {
                    if !(global.customCostumeEquipped[playerID] && global.customSounds[playerID,SFX_CHARGING] >= 0) &&
                        !(isProtoBuster)
                    {
                        audio_stop_sound(getGenericSFX(SFX_CHARGING));
                        playSFX(getGenericSFX(SFX_CHARGED));
                    }
                }
                
                if (!inked && !(isProtoBuster))//Hacky disable so proto buster uses cleaner charge colors for Proto Man.
                {
                    if (((global.customCostumeEquipped[playerID] && (global.customCostumeChargeType[playerID] > 0)) || (!global.customCostumeEquipped[playerID] && global.costumeSelected[playerID] == "Bass")) /*&& (global.weapon[playerID] == 0)*/) && (!global.multiplayerColors) // Special Bass charge effect
                    {
                        switch (floor((chargeTimer / 2) mod 3)) //(floor((chargeTimer / 3) mod 4))
                        {
                            case 0: // Goin' grink, baybee
                                
                                switch (global.weaponObject[global.weapon[playerID]])
                                {
                                    case objBusterShot:
                                    case objTrebleBoost:
                                        if (global.customCostumeEquipped[playerID] && (global.customCostumeChargeType[playerID] > 0))
                                        {//Custom costumes: Choose your palette!
                                            global.primaryCol[playerID] = global.customCostumeChargePrimary[playerID];
                                            global.secondaryCol[playerID] = global.nesPalette[$30];
                                            global.outlineCol[playerID] = global.customCostumeChargeSecondary[playerID];
                                        }
                                        else
                                        {
                                            global.primaryCol[  playerID] = global.nesPalette[$2B];
                                            global.secondaryCol[playerID] = global.nesPalette[$30];
                                            global.outlineCol[playerID] = global.nesPalette[$1A];
                                        }
                                        break;
                                    default:
                                        global.primaryCol[playerID] = getWeaponSecondaryColor(global.weapon[playerID],costumeID);
                                        global.secondaryCol[playerID] = global.nesPalette[$30];
                                        global.outlineCol[playerID] = getWeaponPrimaryColor(global.weapon[playerID],costumeID,playerID);
                                    break;
                                }
                                
                                break;
                            case 1: // Normal palette
                            case 3:
                                global.primaryCol[  playerID] = getWeaponPrimaryColor(global.weapon[playerID], costumeID);
                                global.secondaryCol[playerID] = getWeaponSecondaryColor(global.weapon[playerID], costumeID);
                                global.outlineCol[playerID] = c_black;
                                break;
                            case 2: // Pink outline
                                global.primaryCol[  playerID] = getWeaponPrimaryColor(global.weapon[playerID], costumeID);
                                global.secondaryCol[playerID] = getWeaponSecondaryColor(global.weapon[playerID], costumeID);
                                global.outlineCol[playerID] = global.nesPalette[$4];
                                break;
                        }
                    }
                    else
                    {
                        switch (floor((chargeTimer / 3) mod 3)) // Normal charge effect
                        {
                            case 0: // Light blue helmet, black shirt, blue outline 
                            
                                global.primaryCol[  playerID] = getWeaponSecondaryColor(global.weapon[playerID], costumeID);
                                global.secondaryCol[playerID] = c_black;
                                //override  if using multiplayer colors.
                                if ((global.weaponPrimaryColor[global.weapon[playerID]] || global.weapon[playerID] == 0) && (global.playerCount > 1 && global.multiplayerColors))
                                    global.outlineCol[  playerID]= global.multiplayerPalette[playerID,global.weapon[playerID]];
                                else 
                                    global.outlineCol[  playerID] = getWeaponPrimaryColor(global.weapon[playerID], costumeID);
                                break;
                                
                            case 1: // Black helmet, blue shirt, light blue outline 
                            
                                global.primaryCol[  playerID] = c_black;
                                if ((global.weaponPrimaryColor[global.weapon[playerID]] || global.weapon[playerID] == 0) && (global.playerCount > 1 && global.multiplayerColors))
                                    global.secondaryCol[  playerID]= global.multiplayerPalette[playerID,global.weapon[playerID]];
                                else 
                                    global.secondaryCol[playerID] = getWeaponPrimaryColor(global.weapon[playerID], costumeID);
                                global.outlineCol[  playerID] = getWeaponSecondaryColor(global.weapon[playerID], costumeID);
                                break;
                                
                            case 2: // Blue helmet, light blue shirt, black outline 
                            
                                if ((global.weaponPrimaryColor[global.weapon[playerID]] || global.weapon[playerID] == 0) && (global.playerCount > 1 && global.multiplayerColors))
                                    global.primaryCol[  playerID]= global.multiplayerPalette[playerID,global.weapon[playerID]];
                                else 
                                    global.primaryCol[  playerID] = getWeaponPrimaryColor(global.weapon[playerID], costumeID);
                                global.secondaryCol[playerID] = getWeaponSecondaryColor(global.weapon[playerID], costumeID);
                                global.outlineCol[  playerID] = c_black;
                                break;
                        }
                    }
                }
                chargeTimer ++;
                
                break;
                
            // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
        }
    }
}
else
{
    chargeTimer     = 0; 
    initChargeTimer = 0;
    
    if (releaseCharge) // Reset the colors
    {
        if (!inked)
        {
            playerPalette();
        }
        //applyRumble(playerID,-1,0,0.01,1);
    }
    
    if (checkCheats(cheatEnums.instantCharge))
    {
        isCharge = 2;
    }
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// Stopping Mega Man when shooting, setting shoot animation timer
if (isShoot) // While shooting
{
    if (shootStandStillLock) // standing still from firing, ala metal blade.
    {
        if (!ground && !climbing)
        {
            shootStandStillLock = lockPoolRelease(shootStandStillLock);
        }
    }
    
    shootTimer ++;
    
    if (shootTimer >= 16) // 20 looks better, but 16 is more accurate
    {
        isShoot = 0;
        shootStandStillLock = lockPoolRelease(shootStandStillLock);
    }
}

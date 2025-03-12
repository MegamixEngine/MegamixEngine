/// playerSwitchWeapons()
// Allows for quick weapon switching
// If you do not want quick weapon switching in your game, simply remove the script from objMegaman's step event

bassModeHandleSupports();

if (playerIsLocked(PL_LOCK_WEAPONCHANGE))
{
    weaponIconDrawing = 0;
    weaponIconMode = 0;
    
    exit;
}

// Timers
if (weaponIconDrawing)
{
    weaponIconDrawing --;
}

if (quickWeaponScrollTimer >= 0)
{
    quickWeaponScrollTimer --;
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

var canSwitch = 1;

if (instance_exists(vehicle))
{
    if (!vehicle.weaponsAllowed) // No error sound here
    {
        canSwitch = 0;
    }
}

var oldWeapon = global.weapon[playerID],
    wheelDis = 0,
    weaponReset = false,
    switchSfx = sfxWeaponSwitch,

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if (!global.holdToggle)
    usingWheel = false;

//If the weapon wheel is enabled, check for numpad/analog input
if (global.WheelEnabled)
{
    var prevDirection = wheelDirection;
    
    if (global.analogStickTilt[playerID, 1] > 0.75)
    {
        wheelDirection = round(global.analogStickDirection[playerID, 1] / 45) mod 8;
        
        usingWheel = true;
    }
    else if (global.keyWheelSwitch[playerID])
    {
        weaponIconDrawing = max(weaponIconDrawing, 8);
        weaponIconMode = 1;
        
        if (global.keyWheelSwitchPressed[playerID] && !global.holdToggle) // Press wheel-button to reset weapon (but only if we aren't tilting the stick)
        {
            weaponReset = true;
            
        }
    }
    
    // sigh. i'm being careful here so i'm copying code
    if (global.holdToggle)
    {
        if (global.keyWheelSwitchPressed[playerID])
        {
            usingWheel = !usingWheel;
            if (!usingWheel)
                weaponReset = true;
            else
                wheelDirection = round(global.analogStickDirection[playerID, 1] / 45) mod 8;
        }
        
        if (usingWheel)
        {
            //wheelDirection = round(global.analogStickDirection[playerID, 1] / 45) mod 8;
            weaponIconDrawing = max(weaponIconDrawing, 8);
            weaponIconMode = 1;
        }
    }
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if (usingWheel) // Weapon Wheel-ing
{
    if (!canSwitch) // No error sound here
    {
        exit;
    }
    
    wpn = global.wheelSetWep[playerID, wheelDirection];
    
    weaponIconMode = 1;
    
    if (wpn != -1) // No weapon in this slot? Do Nothing
    {
        if (global.weaponLocked[wpn] % 2 == 0 && !(wpn == 0 && global.lockBuster))
        {
            setWeapon(wpn, playerID);
        }
        else
        {
            if (prevDirection != wheelDirection)
            {
                switchSfx = sfxWeaponWheelLocked;
            }
        }
    }
    
    weaponIconDrawing = max(weaponIconDrawing, 8);
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

else // Use weapon switch keys
{
    var wpnDir = 0;
    var pressCount = 0;
    
    if (global.keyWeaponSwitchRight[playerID]) //Press right
    {
        wpnDir ++;
        pressCount ++;
    }
    
    if (global.keyWeaponSwitchLeft[playerID]) //Press left
    {
        wpnDir --;
        pressCount ++;
    }
    
    if (wpnDir != 0) // Switching left / right
    {
        if (!canSwitch)
        {
            if (!audio_is_playing(sfxError))
                playSFX(sfxError);
            exit;
        }
        
        if (!quickWeaponScrollTimer)
        {
            var loops_done = 0;
            
            while (true)
            {
                var wpn = indexOf(global.weaponHotbar, global.weapon[playerID]);
                    wpn = modf((wpn + wpnDir), (global.totalWeapons + 1));
                
                global.weapon[playerID] = global.weaponHotbar[wpn];
                weaponIconMode = 0;
                
                if (global.weaponLocked[global.weapon[playerID]] < 1 && !global.weaponHidden[global.weapon[playerID]]  // Ain't locked
                    && !(global.weapon[playerID] == 0 && global.lockBuster))
                {
                    break;
                }
                
                if (++loops_done >= 256)
                {
                    if (global.roomTimer mod 45 == 0)
                    {
                        show_debug_message("Stopped an infinite loop in the playerSwitchWeapons script");
                    }
                        
                    global.weapon[playerID] = oldWeapon;
                    
                    break;
                }
            }
        }
    }
    else if (pressCount >= 2)
    {
        weaponReset = 1;
    }
    else
    {
        quickWeaponScrollTimer = 0;
    }
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// Reset to base weapon
if (weaponReset)
{
    var defaultWeapon = 0;
    if (global.lockBuster)
    {
        for (var i = 1; i <= global.weaponHotbar; i++)
        {
            if (!global.weaponLocked[global.weaponHotbar[i]] && !global.weaponHidden[global.weaponHotbar[i]])
            {
                defaultWeapon = global.weaponHotbar[i];
                break;
            }
        }
    }
    
    if ((defaultWeapon == 0 && !global.lockBuster) || (!global.weaponLocked[defaultWeapon] && !global.weaponHidden[defaultWeapon]))
    {
        global.weapon[playerID] = defaultWeapon;
        
        wheelDirection = -1;
        
        quickWeaponScrollTimer = 8;
    }
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// Weapon has been changed
if (global.weapon[playerID] != oldWeapon)
{
    // slight pause between scrolls
    if (quickWeaponScrollTimer < 0) //Initial one is longer
    {
        quickWeaponScrollTimer = 16;
    }
    else
    {
        quickWeaponScrollTimer = 10;
    }
    
    initChargeTimer = 0;
    chargeTimer = 0;
    performShoot = 0;
    releaseCharge = 0;
    isCharge = 0;
    autoFireDelay = 0;
    
    // Accessibility option related
    fireHeld = false;
    
    // For the dashing effect of Tengu Blade to not activate mid-slide.
    notDashing = false;
    
    // error-checking for recording/playback
    recordInputFidelityMessage(string(playerID) + ":" + object_get_name(global.weaponObject[global.weapon[playerID]]));
    
    weaponIconDrawing = 32;
    playerPalette();
    autoFireDelay = 0;
    
    if (!checkCheats(cheatEnums.lingeringWeapons))
    {
        with (prtPlayerProjectile)
        {
            if (playerID == other.playerID)
            {
                instance_destroy();
            }
        }
    }
    
    playSFX(switchSfx);
    
    audio_stop_sound(getGenericSFX(SFX_CHARGING));
    audio_stop_sound(getGenericSFX(SFX_CHARGED));
    audio_stop_sound(sfxWheelCutter1);
    audio_stop_sound(sfxWheelCutter2);
    audio_stop_sound(sfxProtoChamber);
}

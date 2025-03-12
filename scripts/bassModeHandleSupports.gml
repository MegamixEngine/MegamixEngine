///bassModeHandleSupports([initWeapons?])
//Call this whenever setting/unsetting weapons on a global scale so support weapons are properly set.

var isBass = (global.characterSelected[0] == CHAR_BASS);

if (argument_count > 0 && argument[0]) //Mostly used for debug mode.
{
    setWeaponHidden(objRushCoil, isBass, 1);
    setWeaponHidden(objRushJet, isBass, 1);
    setWeaponHidden(objTrebleBoost, !isBass, 1);
}
else
{
    if (isBass)
    {   
        setWeaponHidden(objRushCoil, 1, 1);
        setWeaponHidden(objRushJet, 1, 1);
        setWeaponHidden(objTrebleBoost, 0, 1);
        
        if (global.weaponLocked[global.weaponID[? objRushCoil]] == 1 || global.weaponLocked[global.weaponID[? objRushJet]] == 1)
            global.weaponLocked[global.weaponID[? objTrebleBoost]] = 1;
        
        // Apply infinite energy if RC/RJ have it
        if (global.infiniteEnergy[global.weaponID[? objRushCoil]] == true) || (global.infiniteEnergy[global.weaponID[? objRushJet]] == true)
        {
            global.infiniteEnergy[global.weaponID[? objTrebleBoost]] = true;
        }
        
        // Fix weapon unlock icons
        with (objWeaponModifier)
        {
            if (weapon == objRushCoil) || (weapon == objRushJet)
                weapon = objTrebleBoost;
        }
    }
    else
    {
        setWeaponHidden(objRushCoil, 0, 1);
        setWeaponHidden(objRushJet, 0, 1);
        setWeaponHidden(objTrebleBoost, 1, 1);
    }
}

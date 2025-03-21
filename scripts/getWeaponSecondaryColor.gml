/// getWeaponSecondaryColor(weaponID, costumeID)
_n = global.weaponSecondaryColor[argument[0]];
_c = argument[1];

if (_n >= 0)
{
    return _n;
}
else
{
    // special cases
    
    switch (_n)
    {
        default:
        case -1:
            var ret = global.costumeSecondaryColor[_c];
            if (_c == 0 && global.mmColor)
            {
                // special case for the mega man color option
                ret = make_color_rgb(56, 184, 248);
            }
            return ret;
        case -2:
        case -7:
            return global.costumeRushCoilSecondaryColor[_c];
        case -3:
            return global.costumeRushJetSecondaryColor[_c];
        case -4: return global.costumeSakugarneSecondaryColor[_c];
        case -5: return global.costumeRushBikeSecondaryColor[_c];
    }
}

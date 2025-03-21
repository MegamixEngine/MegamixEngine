/// getWeaponPrimaryColor(weaponID, costumeID,[_p])
_n = global.weaponPrimaryColor[argument[0]];
_c = argument[1];

var _p = 0;
if argument_count > 2
    _p = argument[2];

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
            var ret = global.costumePrimaryColor[_c];
            if (_c == 0 && global.mmColor)
            {
                // special case for the mega man color option
                ret = make_color_rgb(0, 112, 236);
            }
            return ret;
        
        case -2:
        case -7://Treble Boost.
            if (global.playerCount > 1 && global.multiplayerColors)
                return global.multiplayerPalette[_p,global.weapon[_p]];
            else
            {
                return global.costumeRushCoilPrimaryColor[_c];
            }
        case -3: 
            if (global.playerCount > 1 && global.multiplayerColors)
                return global.multiplayerPalette[_p,global.weapon[_p]];
            else
            {
                return global.costumeRushJetPrimaryColor[_c];
            }
        case -4: 
            if (global.playerCount > 1 && global.multiplayerColors)
                return global.multiplayerPalette[_p,global.weapon[_p]];
            else
                return global.costumeSakugarnePrimaryColor[_c];
        case -5: 
            if (global.playerCount > 1 && global.multiplayerColors)
                return global.multiplayerPalette[_p,global.weapon[_p]];
            else
            {
                return global.costumeRushBikePrimaryColor[_c];
            }
    }
}

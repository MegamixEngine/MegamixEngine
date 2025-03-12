/// getWeaponPrimaryColor(weaponID, costumeID,[_p])
_n = global.weaponPrimaryColor[argument[0]];
_c = argument[1];

var _p = 0;
if argument_count > 2
    _p = argument[2];
/*
if (rare weapon check)
{
    return rare weapon color;
}
*/

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
            if ((_c == 0 || _c == 13 || _c == 19) && global.mmColor)
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
                if ((_c == 18) && global.mmColor)
                {
                    // special case for Rush and the mega man color option
                    return make_color_rgb(0, 112, 236);
                }
                else
                    return global.costumeRushCoilPrimaryColor[_c];
            }
        case -3: 
            if (global.playerCount > 1 && global.multiplayerColors)
                return global.multiplayerPalette[_p,global.weapon[_p]];
            else
            {
                if ((_c == 18) && global.mmColor)
                {
                    // special case for Rush and the mega man color option
                    return make_color_rgb(0, 112, 236);
                }
                else
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
                if ((_c == 18) && global.mmColor)
                {
                    // special case for Rush and the mega man color option
                    return make_color_rgb(0, 112, 236);
                }
                else
                    return global.costumeRushBikePrimaryColor[_c];
            }
        case -6:
            if (_c == 30) && (!global.multiplayerColors)
            {
                return global.costumePrimaryColor[_c];
            }
            else
            {
                if (global.tapeSide == "A")
                {
                    if (global.playerCount > 1 && global.multiplayerColors)
                        return global.multiplayerPalette[_p,global.weapon[_p]];
                    else    
                        return global.nesPalette[$22];
                }
                else if (global.tapeSide == "B")
                {
                    if (global.playerCount > 1 && global.multiplayerColors)
                        return global.multiplayerPalette[_p,27];
                    else   
                        return global.nesPalette[$16];
                }
            }
    }
}

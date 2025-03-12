/// getWeaponSecondaryColor(weaponID, costumeID)
_n = global.weaponSecondaryColor[argument[0]];
_c = argument[1];

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
            var ret = global.costumeSecondaryColor[_c];
            if ((_c == 0 || _c == 13 || _c == 19) && global.mmColor)
            {
                // special case for the mega man color option
                ret = make_color_rgb(56, 184, 248);
            }
            return ret;
        case -2:
        case -7:
            if ((_c == 18) && global.mmColor) // special case for Rush and the mega man color option
                {
                    return make_color_rgb(56, 184, 248);
                }
            else
                return global.costumeRushCoilSecondaryColor[_c];
        case -3:
            if ((_c == 18) && global.mmColor) // special case for Rush and the mega man color option
                {
                    return make_color_rgb(56, 184, 248);
                }
            else
                return global.costumeRushJetSecondaryColor[_c];
        case -4: return global.costumeSakugarneSecondaryColor[_c];
        case -5:
            if ((_c == 18) && global.mmColor) // special case for Rush and the mega man color option
                {
                    return make_color_rgb(56, 184, 248);
                }
            else
                return global.costumeRushBikeSecondaryColor[_c];
    }
}

///getPlayerNameColor()
// returns the name color for the skin

/*if (global.customCostumeEquipped)
{
    return global.customCostumeNameColor;
    exit;
}*/
if (global.weapon[0] != 0)
{
    return global.primaryCol[0];
    exit;
}
if (global.multiplayerColors && global.playerCount > 1)
{
    return global.multiplayerPalette[0,0];
    exit;
}
if (global.customCostumeEquipped[0])
{
    return global.customCostumeNameColor;
}

switch (global.costumeSelected[0])
{
    case "Mega Man": return global.nesPalette[ $11]; break;
    case "Proto Man": return global.nesPalette[ $15]; break;
    case "Bass": return global.nesPalette[ $28]; break;
    case "Roll": return global.nesPalette[ $25]; break;
    case "Custom Costume": return global.customCostumeNameColor; break;
    
    default: return global.nesPalette[ $30]; break;
}

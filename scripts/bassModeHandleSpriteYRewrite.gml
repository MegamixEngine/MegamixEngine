/// bassModeHandleSpriteYRewrite(defaultToShootFrame?)
//As Bass can't shoot while moving, certain sprites are unneeded for Bass.
//Following this pattern allows us to save on the number of required cells in the spritesheet.
//In MM10, they default to either the standard shoot frames or non-shoot frames.
//As Megamix uses some shoot frames where other games otherwise don't, this version is a slightly altered mixture,
//but can be adjusted by modifying the argument above where called.
//These sprites are walking, slide, and hurt frames.
//Changes certain sprites while in Bass Mode to redirect
if (global.characterSelected[playerID] == CHAR_BASS)
{
    switch (spriteY)
    {
        case 3:
        case 4:
        case 5:
            if (argument[0])
            {
                spriteY = 1;
            }
            else
            {
                spriteY = 0;
            }
        
        break;
    }
}

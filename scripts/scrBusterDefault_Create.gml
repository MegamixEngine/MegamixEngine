bulletLimitCost = 1;

contactDamage = 1;

penetrate = 0;
pierces = 0;

xspeed = 0;
yspeed = 0;
grav = 0;

autoFireSet = 8;
if (global.characterSelected[playerID] == CHAR_BASS && global.weapon[playerID] != global.weaponID[? objRushCycle])//Though I'm removing most other sound differences with Bass from 48H, I'm keeping this one out of the fact the latter two sounds do *not* sound nice when rapid-fired.
{
    playSFX(sfxBusterClassic);
}
else
{
    playSFX(getGenericSFX(SFX_BUSTER,playerID));
}

/* NOTE FROM PMB - Added to fix a devteam-caused bug in an 
entry stage caused by custom bullet graphics for costumes. */
graphicsOverride = false;

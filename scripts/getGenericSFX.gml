///getGenericSFX(SFX_SOUND, [pID?]);

//returns a generic sound effect chosen in the options screen


var CLS = 1;
var MM3 = 0;
var GB1 = 2;
var GB2 = 3;
var GB3 = 4;
var DOS = 5;

var pID = 0;//Assume 0 unless overwritten, *or* if the caller is Mega Man.
var isProtoBuster = false;
if (object_index == objMegaman)
{
    pID = playerID;
    if (global.characterSelected[playerID] == CHAR_PROTOMAN && global.weapon[max(0,pID)] == 0)
    {
        isProtoBuster = true;
    }

}
else if (argument_count > 1)
{
    pID = argument[1];
}
/*If someone wants this would make things more efficient with a switch case.
enum soundEffectEnums{
    MM3,
    CLS,
    GB3,
    GB2,
    DOS,
    CUSTOM,
    
    
}*/
//Custom. We always want this one first as I'm not quite sure if GMS compresses the OGG it uses or not, so we want it to run as fast as possible.
if (pID >= 0 && global.customSounds[pID,argument[0]] >= 0 && global.customCostumeEquipped[pID])
{
    return (global.customSounds[pID,argument[0]]);
}

switch(argument[0])
{
    case SFX_JUMP: //jump
        if (global.jumpSound == CLS) //classic
            return(sfxLandClassic);
        else if (global.jumpSound == MM3)
            return(sfxLand); //3+
        else if (global.jumpSound == GB3) //GB3+
            return(sfxGB3Land);
        else if (global.jumpSound == GB2) //GB2
            return(sfxGB2Land);
        else if (global.jumpSound == GB1) //GB1
            return(sfxGB1Land);
        else if (global.jumpSound == DOS) //dos
            return(sfxMMDosLandingSound);
    break;
    case SFX_TELEIN: //teleporter in
          if (global.teleportSound == CLS) //classic
            return(sfxTeleportInClassic);
        else if (global.teleportSound == MM3)
            return(sfxTeleportIn); //3+
        else if (global.teleportSound == GB3) //GB3+
            return(sfxGB3TeleIn);
        else if (global.teleportSound == GB2) //GB2
            return(sfxGB2TeleIn);
        else if (global.teleportSound == GB1) //GB1
            return(sfxGB1Pause);
        else if (global.teleportSound == DOS) //dos
            return(sfxMMDosTele2);
    break;
    case SFX_TELEOUT: //teleporter out
          if (global.teleportSound == CLS) //classic
            return(sfxTeleportOutClassic);
        else if (global.teleportSound == MM3)
            return(sfxTeleportOut); //3+
        else if (global.teleportSound == GB3) //GB3+
            return(sfxGB3TeleOut);
        else if (global.teleportSound == GB2) //GB2
            return(sfxGB2Teleport);
        else if (global.teleportSound == GB1) //GB1
            return(sfxGB1Pause);
        else if (global.teleportSound == DOS) //dos
            return(sfxMMDosTele1);
    break;
    case SFX_BUSTER: //buster sound
        if (global.busterSound == CLS) //classic
            return(sfxBusterClassic);
        else if (global.busterSound == MM3)
            return(sfxBuster); //3+
        else if (global.busterSound == GB3) //GB3+
            return(sfxGB3Buster);
        else if (global.busterSound == GB2) //GB2
            return(sfxGB2Buster);
        else if (global.busterSound == GB1) //GB1
            return(sfxGB1Buster);
        else if (global.busterSound == DOS) //dos
            return(sfxMMDosGenericShoot1);
    break;
    case SFX_BUSTERCHARGED:
        if (isProtoBuster)
        {
            return sfxBusterProtoCharged;
        }
        else if (global.busterSound == CLS) //classic
            return(sfxBusterChargedMM9Unused);//sfxBusterChargedAlt);
        else if (global.busterSound == MM3)
            return(sfxBusterCharged); //3+
        else if (global.busterSound == GB3) //GB3+
            return(sfxGB3BusterCharged);
        else if (global.busterSound == GB2) //GB2
            return(sfxGB2BusterCharged);
        else if (global.busterSound == GB1) //GB1
            return(sfxGB1EnemyDead);
        else if (global.busterSound == DOS) //dos
            return(sfxSonicManSonicMine);
    break;
    case SFX_CHARGING: //buster sound
        if (isProtoBuster)
        {
            return sfxProtoChargingMM9True;
        }
        else if (global.busterSound == CLS) //classic
            return(sfxChargingMM9Unused);//sfxCharging);
        else if (global.busterSound == MM3)
            return(sfxCharging); //3+
        else if (global.busterSound == GB3) //GB3+
            return(sfxGB3Charging);
        else if (global.busterSound == GB2) //GB2
            return(sfxGB2Charging);
        else if (global.busterSound == GB1) //GB1
            return(sfxGB1Charging);
        else if (global.busterSound == DOS) //dos
            return(sfxMMDosCharging);
    break;
    case SFX_CHARGED: //buster sound
        //Proto Man's is handled special due to his charging above containing "one in the chamber" at the start.
        if (global.busterSound == CLS) //classic
            return(sfxChargedMM9Unused);
        else if (global.busterSound == MM3)
            return(sfxCharged); //3+
        else if (global.busterSound == GB3) //GB3+
            return(sfxGB3Charged);
        else if (global.busterSound == GB2) //GB2
            return(sfxGB2Charged);
        else if (global.busterSound == GB1) //GB1
            return(sfxGB1Charged);
        else if (global.busterSound == DOS) //dos
            return(sfxMMDosCharged);
    break;
    case SFX_BUSTERHALFCHARGED: //buster sound
        if (global.busterSound == CLS) //classic
            return(getGenericSFX(SFX_BUSTER));//The unused sounds don't include a half-charge, so the assumption is it'd be similar to MM9's Proto Man half charged, which is just the buster sound.
        else if (global.busterSound == MM3)
            return(sfxBusterHalfCharged); //3+
        else if (global.busterSound == GB3) //GB3+
            return(sfxGB3BusterHalfCharged);
        else if (global.busterSound == GB2) //GB2
            return(sfxGB2BusterHalfCharged);
        else if (global.busterSound == GB1) //GB1
            return(sfxGB1Splash);
        else if (global.busterSound == DOS) //dos
            return(sfxMMDosHalfCharged);
    break;
    case SFX_HURT: //hurt sound //this ones weird so...
        if (global.hurtSound == CLS) //classic
            return(sfxHitClassic);
        else if (global.hurtSound == MM3)
            return(sfxHit); //3+
        else if (global.hurtSound == 2) //MM1
            return(sfxHitMM1); 
        else if (global.hurtSound == 3) //GB1
            return(sfxGB1Hurt);
        else if (global.hurtSound == 4) //GB2
            return(sfxGB2Hurt);
        else if (global.hurtSound == 5) //GB3+
            return(sfxGB3Hurt);
        else if (global.hurtSound == 6) //dos
            return(sfxMMDosHurt);    
    break;
    case SFX_REFILL: //item refill
        if (global.refillSound == CLS) //classic
            return(sfxEnergyRestoreClassic);
        else if (global.refillSound == MM3)
            return(sfxEnergyRestore); //3+
        else if (global.refillSound == GB3) //GB3+
            return(sfxGB3Refill);
        else if (global.refillSound == GB2) //GB2
            return(sfxGB2Refill);
        else if (global.refillSound == GB1) //GB1
            return(sfxGB1Refill);
        else if (global.refillSound == DOS) //dos
            return(sfxMMDosPickup);
    break;
    case SFX_SPLASH: //water splash
        if (global.splashSound  == CLS) //classic
            return(sfxSplashClassic);
        else if (global.splashSound  == MM3)
            return(sfxSplash); //3+
        else if (global.splashSound  == GB3) //GB3+
            return(sfxGB3WaterSplash);
        else if (global.splashSound  == GB2) //GB2
            return(sfxGB2WaterSplash);
        else if (global.splashSound  == GB1) //GB1
            return(sfxGB1Splash);
        else if (global.splashSound  == DOS) //dos
            return(sfxDynaManThrow);    
    break;
    case SFX_DOOR: // boss door
        if (global.doorSound == CLS) //classic
            return(sfxDoorClassic);
        else if (global.doorSound == MM3)
            return(sfxDoor); //3+
        else if (global.doorSound == GB3) //GB3+
            return(sfxGB3BossShutter);
        else if (global.doorSound == GB2) //GB2
            return(sfxGB2BossDoor);
        else if (global.doorSound == GB1) //GB1
            return(sfxGB1Door);
        else if (global.doorSound == DOS) //dos
            return(sfxMMDosDoor);
    break;
    case SFX_PLAYERDIE: //player death sound
        if (global.deathSound == CLS) //classic
            return(sfxDeathClassic);
        else if (global.deathSound == MM3)
            return(sfxDeath); //3+
        else if (global.deathSound == 2) //MM1
            return(sfxDeathClassic);
        else if (global.deathSound == 3) //GB1
            return(sfxGB1Dead);
        else if (global.deathSound == 4) //GB2) //GB2
            return(sfxGB2Dead);
        else if (global.deathSound == 5) //GB3) //GB3+
            return(sfxGB3Dead);
        else if (global.deathSound == 6) //DOS) //dos
            return(sfxMMDosDeath);    
    break;
    case SFX_BOSSDIE: //boss death sound
        if (global.deathSound == CLS) //classic
            return(sfxDeathClassic);
        else if (global.deathSound == MM3) //3+
            return(sfxDeath);
        else if (global.deathSound == 2) // MM1
            return(sfxClassicExplosion);
        else if (global.deathSound == 3) //GB1
            return(sfxGB1EnemyDead);
        else if (global.deathSound == 4) //GB2) //GB2
            return(sfxGB2Dead);
        else if (global.deathSound == 5) //GB3) //GB3+
            return(sfxGB3BossDead);
        else if (global.deathSound == 6) //DOS) //dos
            return(sfxMMDosDeath);    
    break;
    case SFX_PAUSE: //boss death sound
        switch (global.pauseSound)
        {
            case 0:
                return sfxPause;
            break;
            case 1:
                return sfxMM4Pause;
            break;
            case 2:
                return sfxGB1Pause;
            break;
            case 3:
                return sfxGB2PauseIn;
            break;
            case 4:
                return sfxGB3Pause;
            break;
            case 5:
                return sfxMMDosPause;
            break;
        }
    break;
    case SFX_UNPAUSE: //boss death sound
        switch (global.pauseSound)
        {
            case 0:
                return sfxMenuSelect;
            break;
            case 1:
                return sfxMM4Pause;
            break;
            case 2:
                return sfxGB1Pause;
            break;
            case 3:
                return sfxGB2PauseOut;
            break;
            case 4:
                return sfxGB3Pause;
            break;
            case 5:
                return sfxMMDosPause;
            break;
        }
    break;
    case SFX_VICTORYMUS://This is a case specifically to tell the game to use actual music for main-game costumes.
        return -1;//Custom costumes instead use this for their own victory theme!
    break;
    case SFX_LIFE:
    case SFX_TANK:
        return sfxImportantItem;
    break;
    case SFX_JUMPMARIO://This and below are meant *purely* for custom skins: Namely ones that may fit better with these types of sound.
        return -1;
    break;
    case SFX_SLIDE:
        return -1;
    break;
    case SFX_LOOKUP:
        return -1;
    break;
    case SFX_SPIN:
        return -1;
    break;
    //The below are merely meant as an easier means of implementing the Undertale explosions code game-wide.
    //I did multiple if-elses so a single sound doesn't take up too much processing.
    case SFX_EXPLOSION:
        return sfxExplosion;
    break;
    case SFX_EXPLOSIONMM3:
        return sfxMM3Explode;
    break;
    case SFX_EXPLOSION2:
        return sfxExplosion2;
    break;
    case SFX_EXPLOSIONMM5:
        return sfxMinorExplosion;
    break;
    case SFX_EXPLOSIONMM9:
        return sfxMM9Explosion;
    break;
    case SFX_EXPLOSIONMM9Alt:
        return sfxMM9ExplosionAlt;
    break;
    case SFX_EXPLOSIONCLASSIC:
        return sfxClassicExplosion;
    break;
    case SFX_EXPLOSIONBALLADE:
        return sfxBalladeCrackerExplosion;
    break;
    case SFX_ENEMYHIT:
        return sfxEnemyHit;
    break;
    case SFX_RUSHBIKE_START:
        return sfxLargeClamp;
    break;
    case SFX_RUSHBIKE_JUMP:
        return sfxRushCycle1;
    break;
    case SFX_RUSHBIKE_SKID:
        return sfxRushCycle2;
    break;
    case SFX_VICTORY:
        return sfxMenuSelect;
    break;
    case SFX_WHISTLE:
        if (costumeID == 1 || costumeID == 10)
        {
            return sfxProtoWhistleShort;
        }
        else
        {
            return -1;
        }
    break;
    case SFX_TEXTSTART:
    case SFX_TEXTBLIP:
    case SFX_TEXTCONTINUE:
    case SFX_TEXTEND:
        var textSounds = array_create(SFX_TEXTEND-SFX_TEXTSTART+1);
        var genericSounds = array_create(SFX_TEXTEND-SFX_TEXTSTART+1);
        genericSounds[2] = sfxTextBox;//The only one that matters for generic.
        
        if (global.textAppearanceSounds) //Generic add enter/exit sounds.
        {
            genericSounds[0] = sfxTenguBlade;
            genericSounds[3] = sfxStegorusMissile;
        }
        
        switch (global.textSounds)
        {
            case 1://Mega Man IV/V.
                if (SFX_TEXTBLIP == argument[0] && blipCount % 2 == 0)
                {
                    textSounds[SFX_TEXTBLIP-SFX_TEXTSTART] = sfxTextboxGBBlip;
                }
            break;
            case 2://Mega Man 7.
                if (SFX_TEXTBLIP == argument[0])
                {
                    if (mugshotPlayer)
                    {
                        textSounds[SFX_TEXTBLIP-SFX_TEXTSTART] = sfxTextboxMM7BlipPlayer;
                    }
                    else if (name == "Roll")
                    {
                        textSounds[SFX_TEXTBLIP-SFX_TEXTSTART] = sfxTextboxMM7BlipRoll;
                        
                    }
                    else
                    {
                        textSounds[SFX_TEXTBLIP-SFX_TEXTSTART] = sfxTextboxMM7BlipGeneric;
                    }
                }
            break;
            case 3://Mega Man 8.
                if (SFX_TEXTBLIP == argument[0])
                {
                    if (mugshotPlayer)
                    {
                        textSounds[SFX_TEXTBLIP-SFX_TEXTSTART] = sfxTextboxMM8BlipPlayer;
                    }
                    else if (name == "Dr. Wily" || name == "Ernest Will")
                    {
                        textSounds[SFX_TEXTBLIP-SFX_TEXTSTART] = sfxTextboxMM8BlipWily;
                        
                    }
                    else
                    {
                        textSounds[SFX_TEXTBLIP-SFX_TEXTSTART] = sfxTextboxMM8BlipGeneric;
                    }
                }
            break;
            case 4://Mega Man X.
                if (SFX_TEXTBLIP == argument[0] && blipCount % 2 == 0)
                {
                    textSounds[SFX_TEXTBLIP-SFX_TEXTSTART] = sfxTextboxMMXBlip;
                }
            break;
            case 5://Battle Network.
                if (SFX_TEXTBLIP == argument[0])
                {
                    textSounds[SFX_TEXTBLIP-SFX_TEXTSTART] = sfxTextboxBNBlip;
                }
            break;
        }
        if (textSounds[argument[0]-SFX_TEXTSTART] > 0)
        {
            return textSounds[argument[0]-SFX_TEXTSTART];
        }
        else
        {
            return genericSounds[argument[0]-SFX_TEXTSTART];
        }
    break;
    
}


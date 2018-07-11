/// playerHandleShoot()
// Handles Mega Man's shooting

global.playerProjectileCreator = id;

// Shooting
event_perform_object(global.weaponObject[global.weapon[playerID]], ev_other, ev_user14);

// Stopping Mega Man when shooting, setting shoot animation timer

if (isShoot) // While shooting
{
    if (shootStandStillLock) // standing still from firing, ala metal blade.
    {
        if (!ground && !climbing)
        {
            shootStandStillLock = lockPoolRelease(shootStandStillLock);
        }
    }
    
    shootTimer += 1;
    if (shootTimer >= 16) // 20 looks better, but 16 is more accurate
    {
        isShoot = 0;
        shootStandStillLock = lockPoolRelease(shootStandStillLock);
    }
}

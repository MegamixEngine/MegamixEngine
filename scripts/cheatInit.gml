enum cheatEnums {
/*NOTICE: DO NOT CHANGE THE ORDER!
if you need to make a new cheat, always add it to the bottom.
*/
    invincible,
    infiniteWeapons,
    doubleJump,
    burstChaser,
    airSliding,
    moonwalk,
    permaLowGravity,
    permaHighGravity,
    instantDeathMode,
    noIFrames,
    noIFramesBoss,
    invisiblePlayer,
    invisibleHealthbars,
    crazyDropRate,
    lingeringWeapons,
    hugeWeapons,
    noBulletLimits,
    VVVVV, //2525
    allBossExplosion,
    hyperKnockback,
    mirrorMode,
    ignoreWeaponLocks,
    permaIcePhysics,
    holdSlide,
    noItemDrops,
    doubleEnemyHealth,
    instantCharge,
    wiiPhysics,//I can't use numbers in a variable name.
    infiniteTanks,
    buddha,
    permanentInk,
    length,//Keep as last.
}

global.cheats = array_create(cheatEnums.length);

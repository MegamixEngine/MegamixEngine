///playerExplosion([sprite],[speed],[alarmDie],[sfx],[if sprExplosionClassic = primary palette], [secondary palette])
var spr, spd, almDie, myP0, myP1;

if (argument_count > 0)
    spr = argument[0];
else
    spr = sprExplosion;

if (argument_count > 1)
    spd = argument[1];
else
    spd = 1.5;

if (argument_count > 2)
    almDie = argument[2];
else
    almDie =-1;
if (argument_count > 3)
    playSFX(argument[3]);
else
    playSFX(getGenericSFX(SFX_BOSSDIE));

//if sprite index = sprExplosionClassic, then use palette
if (argument_count > 4)
    myP0 = argument[4];
else
    myP0 = global.primaryCol[0];

if (argument_count > 5)
    myP1 = argument[5];
else
    myP1 = global.secondaryCol[0];


// Classic boss explosion
var explosionID;
for (var h = 0; h < 2; h += 1)
{ 
    for (var i = 0; i < 8; i += 1)
    {
        explosionID = instance_create(bboxGetXCenter(), bboxGetYCenter(),
            objMegamanExplosion);
        explosionID.dir = i * 45;
        explosionID.spd = spd * ternary(h == 0, 0.5, 1);
        explosionID.sprite_index =  spr;
        explosionID.alarmDie = almDie;
        explosionID.myPal[0] = myP0;
        explosionID.myPal[1] = myP1;
    }
}

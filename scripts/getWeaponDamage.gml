/// getWeaponDamage(aggressor, [target])
// returns how much damage the aggressor would do to the given target.

var aggressor = argument[0];
var target = id;
if (argument_count > 1)
{
    var target = argument[1];
}

with (target) // Do this to set "other" to the target's ID
{
    with (aggressor)
    {
        global.damage = contactDamage;
        
        event_user(EV_WEAPON_SETDAMAGE);
        
        with (other)
        {
            event_user(EV_GUARD);
        }
        
        return (global.damage);
    }
}

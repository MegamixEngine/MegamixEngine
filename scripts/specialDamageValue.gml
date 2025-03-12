/// specialDamageValue(type, damage);
// This script checks the object_index of the "other" instance
// to determine a new value for "global.damage"

// type: either an object index or a string category (see below)
// damage: how much damage to do.

var type = argument0;
var newDamage = argument1;

// Basic, by-object
if (!is_string(type))
{
    if (other.object_index == type)
    {
        if (global.damageIsContact)
        {//Always override the contact damage.
            global.damageIsContact = false;
            global.damage = newDamage;
        }
        //If the incoming damage is immune or healed (and damage is already 0), that should always take priority from then on.
        //Otherwise, take the maximum damage of the two values.
        if (newDamage <= 0 || global.damage <= 0)
            global.damage = min(global.damage,newDamage);
        else if (newDamage > 0)
            global.damage = max(global.damage,newDamage);
        
    }
}
else // Based on the category of the enemy
{
    if (hasCategory(other.category, type))
    {
        if (global.damageIsContact)
        {
            global.damageIsContact = false;
            global.damage = newDamage;
        }
        if (newDamage <= 0 || global.damage <= 0)
            global.damage = min(global.damage,newDamage);
        else if (newDamage > 0)
            global.damage = max(global.damage,newDamage);
    }
}

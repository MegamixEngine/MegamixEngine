/// enemyDamageValue(object_index,damage)
// Use this from an enemy/boss to set its special damage values
// outside of EV_GUARD/EV_WEAPON_SETDAMAGE
// note: any weakness set in the events mentioned above will override these changes

var i = indexOf(specialDamageValues, argument[0]);
var addNew = false;
if (i == -1)
{
    i = specialDamageValuesTotal * 2;
    addNew = true;
}
specialDamageValues[i] = argument[0];
specialDamageValues[i + 1] = argument[1];
if (addNew)
    specialDamageValuesTotal += 1;

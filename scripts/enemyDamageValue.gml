/// enemyDamageValue(object_index,damage)
// Use this from an enemy/boss to set its special damage values
// outside of EV_GUARD/EV_WEAPON_SETDAMAGE
// note: any weakness set in the events mentioned above will override these changes

var _obj = argument[0];
var _dmg = argument[1];

// - - -

//Check if already exists
var i = indexOf(specialDamageValues, _obj);

//New or override old?
if (i == -1)
{
    i = (specialDamageValuesTotal * 2);
    
    specialDamageValuesTotal ++;
}

//Set values
specialDamageValues[i] = _obj;
specialDamageValues[(i + 1)] = _dmg;


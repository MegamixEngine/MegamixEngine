/// ammoCanAfford(_playerID, ...)
///ammoCanAfford(playerID, [cost])

var _playerID = argument[0];
var _playerWeapon = global.weapon[_playerID];

var _ammoCost = 0;

if (argument_count >= 2)
{
    _ammoCost = argument[1];
}

// - - - - - - - - - - - - - - - - - - - - -

var _currentAmmo = global.ammo[_playerID, _playerWeapon];

_currentAmmo = max(0, _currentAmmo);

// - - - - - - - - - - - - - - - - - - - - -

if (_ammoCost <= 0) //Any ammo?
{
    return (_currentAmmo > 0)
}
else //Required ammo?
{
    return (_currentAmmo >= _ammoCost)
}


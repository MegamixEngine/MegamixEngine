///ammoDecrease(playerID, value)

var _playerID = argument[0];
var _ammoCost = argument[1];

var _playerWeapon = global.weapon[_playerID];

// - - - - - - - - - - - - - - - - - - - - -

var _currentAmmo = global.ammo[_playerID, _playerWeapon];
//Subtract ammo
global.ammo[_playerID, _playerWeapon] = max(0, (_currentAmmo - _ammoCost));

//_currentAmmo = global.ammo[_playerID, _playerWeapon];

// - - - - - - - - - - - - - - - - - - - - -

//return(_currentAmmo);


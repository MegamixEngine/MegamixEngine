/// addMugshot(_sprite, _start, _end, _speed, _textbox = noone)

var _sprite = argument[0], _start = argument[1], _end = argument[2], _speed = argument[3];
var _textbox; if (argument_count > 4) _textbox = argument[4]; else _textbox = noone;
//var storeRandom = random_get_seed();





if (!instance_exists(_textbox))
    _textbox = instance_nearest(x, y, objDialogueBox);

with (_textbox) {
    var myChar = 0;
    
    sprite_index = _sprite;
    mugshotIndex = _start;
    mugshotIndexStart = _start;
    mugshotIndexEnd = _end;
    mugshotSpeed = _speed;
    
    if (_sprite == -1) { // Is this a player mugshot?
        mugshotPlayer = true;
        
        /*with (objMegaman) {
            if (playerID == myChar)
                other.mugshotIndex = costumeID;
        }*/
        
        //name = global.costumeSelected[0];
        //nameCol = global.costumeSecondaryColor[mugshotIndex];
    }
}
//random_set_seed_safe(storeRandom);

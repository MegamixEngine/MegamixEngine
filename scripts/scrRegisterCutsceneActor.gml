/// scrRegisterCutsceneActor(_x, _y, _name, _sprite, _dir, _anim = "", _state = "")
// Helper script to create actors for the calling cutscene
//
// This script should only be called by child objects of `prtCutscene`

var _x = argument[0], _y = argument[1], _name = argument[2], _sprite = argument[3], _dir = argument[4];
var _anim; if (argument_count > 5) _anim = argument[5]; else _anim = "";
var _state; if (argument_count > 6) _state = argument[6]; else _state = "";

assert(object_index == prtCutscene || object_is_ancestor(object_index, prtCutscene),
    "scrRegisterCutsceneActor was called by an " + object_get_name(object_index) + ", but is meant for child objects of prtCutscene");

var _actor = instance_create(_x, _y, objCutsceneDummy);
_actor.sprite_index = _sprite;
_actor.image_xscale = _dir;
_actor.cutscene = id;
_actor.name = _name;
_actor.animation = _anim;
_actor.state = _state;

ds_map_add(actorMap, _name, _actor);

return _actor;

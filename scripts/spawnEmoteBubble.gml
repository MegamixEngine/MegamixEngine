/// spawnEmoteBubble(_emoter, _type, _duration = 80, _y_offset = -4)
// 0 = ?; 1 = !; 2 = ...; 3 = X;

var _emoter = argument[0], _type = argument[1];
var _duration; if (argument_count > 2) _duration = argument[2]; else _duration = 80;
var _y_offset; if (argument_count > 3) _y_offset = argument[3]; else _y_offset = -4;

var _emote = instance_create(_emoter.x, _emoter.y, objCutsceneEmote);
_emote.emoter = _emoter;
_emote.emoteType = _type;
_emote.yOffset = _y_offset;
_emote.lifeDuration = _duration;

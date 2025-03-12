/// setNPCTextOption(_index, _text, _response = "", _script_on_talk_start = 0, _script_on_talk_end = 0, _code_on_talk_start = "", _code_on_talk_end = "")
// Shortcut script to quickly set options in a NPC's dialogue

var _index = argument[0], _text = argument[1];
var _response; if (argument_count > 2) _response = argument[2]; else _response = "";
var _script_on_talk_start; if (argument_count > 3) _script_on_talk_start = argument[3]; else _script_on_talk_start = 0;
var _script_on_talk_end; if (argument_count > 4) _script_on_talk_end = argument[4]; else _script_on_talk_end = 0;
var _code_on_talk_start; if (argument_count > 5) _code_on_talk_start = argument[5]; else _code_on_talk_start = "";
var _code_on_talk_end; if (argument_count > 6) _code_on_talk_end = argument[6]; else _code_on_talk_end = "";

option[_index] = _text;
option_text[_index] = _response;
option_script_on_talk_start[_index] = _script_on_talk_start;
option_script_on_talk_end[_index] = _script_on_talk_end;
option_code_on_talk_start[_index] = _code_on_talk_start;
option_code_on_talk_end[_index] = _code_on_talk_end;

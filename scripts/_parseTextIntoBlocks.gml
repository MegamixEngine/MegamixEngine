/// _parseTextIntoBlocks(_raw_text, _max_line_width, _font)
// A utility script used by both spawnTextBoxSingleString & spawnPassiveTextBoxSingleString
// to split their given textline into multiple blocks of text

// Initialize Variables
// - Text
var _raw_text = argument0,
    _split_text = array_create(0), // Raw text split into multiple blocks
    _text = ""; //Text for the current section
// - Lines
var _max_line_width = argument1, //Max width for a given line, in pixels
    _max_line_height = 5 * 8, //Max height for a given text block
    _line_width = 0, //How long our current line is, in pixels
    _line_height = 0; //Height, in pixels, of the current section
// - Parsing
var _check_word = true,
    _ignore_next_line_break = false,
    _first_char_in_text_block = true,
    _motion_effect = "/0", //Used to keep track of effects that carry over between blocks
    _colour_effect = "/C00";
// - Special Chars I Have To Account For
var _carriage_return_char = chr(13),
    _line_feed_char = chr(10);
// - Debug
var _debug_msg = false;

draw_set_font(argument2);

// -- Let the text splitting begin --
// (This is a modified version of the parser in objDialogueBox,
// there's probably a better way to do this, but I can't figure it out)
while (_raw_text != "") {
    var _char = string_char_at(_raw_text, 1);
    //show_debug_message(ord(_char));
    
    if (_char == _carriage_return_char) {
        _raw_text = string_delete(_raw_text, 1, 1);
        continue;
    }
    
    // If this is the beginning of a word, check to see if this word approaches the limit of the current line
    // we need to know in advance if we need to either place this word on a new line,
    // make put it in a new section
    if (_check_word) {
        switch (_char) {
            case " ":
            case _line_feed_char:
            case "#":
                break; //These characters do not signify the start of a word, so we ignore them
            
            case "/": //Only break if it's not leading to a literal / or #
                if (string_char_at(_raw_text, 2) != "/" && string_char_at(_raw_text, 2) != "#")
                    break;
            
            default:
                var _end_point = string_length(_raw_text),
                    _seek_char = "",
                    _word_width = 0;
                
                // We will seek ahead of the raw line until we hit the end of this word
                // Let's assume we've hit the end of the word once we hit a ' ', a '#', or the end of the string
                for (var i = 1; i <= _end_point; i++) {
                    _seek_char = string_char_at(_raw_text, i);
                    
                    if (_seek_char == "/") { // Effect
                        // Effects aren't actually part of the word, so we need to jump over them
                        var _seek_effect_type = string_char_at(_raw_text, i + 1);
                        
                        switch (_seek_effect_type) {
                            case "C": i += 3; break; // Colour
                            case "D": i += 4; break; // Delay
                            
                            case "E": // Emoji
                                getTextboxEmoji(real(string_copy(_raw_text, i + 2, 2)));
                                i += 3;
                                _word_width += sprite_get_width(emojiSprite);
                                break;
                            
                            case "/": // Literal '/'
                            case "#": // Literal '#'
                                i += 1;
                                _word_width += string_width(_seek_effect_type);
                                break;
                            
                            default: // Motion Effects, Instant-Type, Auto-Advance
                                i += 1;
                                break;
                        }
                    } else if (_seek_char == " " || _seek_char == _line_feed_char || _seek_char == "#") { // End of the word
                        break; // Stop the for-loop, we've reached the end of the word
                    } else {
                        _word_width += string_width(_seek_char);
                    }
                }
                
                if (_debug_msg) {
                    show_debug_message(
                        "Upcoming word"
                        + " | Word Length: " + string(_word_width)
                        + " | Current Line Length: " + string(_line_width)
                        + " | New Line Length: " + string(_line_width + _word_width)
                        + " | Will Cause Linebreak: " + string(_line_width + _word_width > _max_line_width)
                    );
                }
                
                // Will this word put us over the end of the current line?
                // If so, that must mean a new line
                if (_line_width + _word_width > _max_line_width) {
                    // If this is the first word of the current line,
                    // and it's so long that it exceeds the full width of the textbox
                    // Forego marking the new line (it shall become victim to the auto line-break system)
                    if (!(_line_width == 0 && _word_width > _max_line_width)) {
                        if (_debug_msg) {
                            show_debug_message(
                                "Line Break"
                                + " | Line Length: " + string(_line_width)
                                + " | Line Count: " + string(_line_height + string_height("A"))
                            );
                        }
                        
                        _line_height += string_height("A");
                        _line_width = 0;
                    }
                } else if (_line_width + _word_width == _max_line_width) {
                    // Is this word right up against the right side of the textbox,
                    // such that the very next char must go on the next line?
                    // Well, ignore that char if it's a line break or a space.
                    // The parser will make an automated line break in its place
                    _ignore_next_line_break = true;
                }
                
                // If we've exceeded the line limit (or reached the end),
                // make a new section
                if (_line_height >= _max_line_height) {
                    if (_debug_msg)
                        show_debug_message("New Text Block");
                    
                    arrayAppend(_split_text, _text);
                    _line_height = 0;
                    _line_width = 0;
                    _text = "";
                    _first_char_in_text_block = true;
                    
                    if (_motion_effect != "/0")
                        _text += _motion_effect;
                    
                    if (_colour_effect != "/C00")
                        _text += _colour_effect;
                }
                
                _check_word = false;
                break;
        }
    }
    
    switch (_char) {
        case "/": // Text Effects
            var _effect_type = string_char_at(_raw_text, 2);
            
            switch (_effect_type) {
                case "C": // Text Colour (/CXX)
                    _colour_effect = string_copy(_raw_text, 1, 4);
                    _text += string_copy(_raw_text, 1, 4);
                    _raw_text = string_delete(_raw_text, 1, 4);
                    break;
                
                case "D": // Delay (/DXXX)
                    _text += string_copy(_raw_text, 1, 5);
                    _raw_text = string_delete(_raw_text, 1, 5);
                    break;
                
                case "E": // Emoji (/EXX)
                    getTextboxEmoji(real(string_copy(_raw_text, 3, 2)));
                    _text += string_copy(_raw_text, 1, 4);
                    _line_width += sprite_get_width(emojiSprite);
                    _raw_text = string_delete(_raw_text, 1, 4);
                    break;
                
                case "/": // Literal '/' (//)
                    _text += "//";
                    _line_width += string_width("/");
                    _raw_text = string_delete(_raw_text, 1, 2);
                    break;
                
                case "#": // Literl '#' (/#)
                    _text += "/#";
                    _line_width += string_width("\#");
                    _raw_text = string_delete(_raw_text, 1, 2);
                    break;
                
                case "I": // Instant-Type (/I)
                case "A": // Auto-Advance (/A)
                    _text += string_copy(_raw_text, 1, 2);
                    _raw_text = string_delete(_raw_text, 1, 2);
                    break;
                
                default: // Motion (/X)
                    _motion_effect = string_copy(_raw_text, 1, 2);
                    _text += string_copy(_raw_text, 1, 2);
                    _raw_text = string_delete(_raw_text, 1, 2);
                    break;
            }
            break;
        
        case " ": // Space
        case _line_feed_char: // The original objDialogueBox interpreted it as a space, so we'll do the same here.
            // Ignore this space if it's the first char in the current block
            if (!_first_char_in_text_block) {
                if (_ignore_next_line_break)
                    _ignore_next_line_break = false;
                else
                    _line_width += string_width(" ");
                
                _text += " ";
            } else {
                _ignore_next_line_break = false;
            }
            
            _raw_text = string_delete(_raw_text, 1, 1);
            _check_word = true;
            break;
        
        case "#": // Line Break
            // Ignore this space if it's the first char in the current block
            if (!_first_char_in_text_block) {
                if (_ignore_next_line_break) {
                    _ignore_next_line_break = false;
                } else {
                    _line_width = 0;
                    _line_height += string_height("A");
                }
                
                _text += "#";
            } else {
                _ignore_next_line_break = false;
            }
            
            _raw_text = string_delete(_raw_text, 1, 1);
            _check_word = true;
            break;
        
        default: // Any other chars
            _text += _char;
            _line_width += string_width(_char);
            _raw_text = string_delete(_raw_text, 1, 1);
            break;
    }
    
    _first_char_in_text_block = false;
    
    // If we're at the limit of the current line, make a new one
    // (unless we've reached the end of the text)
    if (_line_width >= _max_line_width && _raw_text != "") {
        if (_debug_msg) {
            show_debug_message(
                "Line Break"
                + " | Line Length: " + string(_line_width)
                + " | Line Count: " + string(_line_height + string_height("A"))
            );
        }
        
        _line_height += string_height("A");
        _line_width = 0;
    }
    
    // If we've exceeded the line limit (or reached the end),
    // make a new section
    if (_line_height >= _max_line_height || _raw_text == "") {
        if (_debug_msg)
            show_debug_message("New Text Block");
        
        arrayAppend(_split_text, _text);
        _line_height = 0;
        _line_width = 0;
        _text = "";
        _first_char_in_text_block = true;
        
        if (_motion_effect != "/0")
            _text += _motion_effect;
        
        if (_colour_effect != "/C00")
            _text += _colour_effect;
    }
}

draw_set_font(global.font);

return _split_text;

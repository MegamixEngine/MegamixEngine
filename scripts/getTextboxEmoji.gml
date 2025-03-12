/// @param _emoji_index
/// getTextboxEmoji(_emoji_index)
// Used to set up variables relating to the current sprite/emoji a textbox has to draw
// Expected to be used by objTextbox

var _emoji_index = argument0;

//assert(object_index == objDialogueBox || object_index == objPassiveDialogueBox, "getTextboxEmoji can only be used by objDialogueBox or objPassiveDialogueBox");

emojiImageIndex = 0;

switch (_emoji_index) {
    // Button Prompts
    case 0: //left
    case 1: //right
    case 2: ///up
    case 3: //down
    case 4: //jump
    case 5: //shoot 
    case 6: //slide 
    case 7: //pause 
    case 8: //map 
    case 9: //switchleft 
    case 10: //switchright 
    case 11: //wheel 
    case 12: //wheel2 
        emojiSprite = sprInputPromptKey;
        emojiImageIndex = _emoji_index;
        break;
    
    case 13: emojiSprite = sprKeyHud; break; // Key
    case 14: emojiSprite = sprKeyCoinHUD; break; // Key Coin
    case 15: emojiSprite = sprFontEllipses; break; //Single Ellipses
    
    case 16: //Music notes
    case 17:
        emojiSprite = sprFontMusicalNote;
        emojiImageIndex = _emoji_index - 16;
        break;
    
    case 18: //Eddie icon
        emojiSprite = sprEddieIcon;
        break;
}

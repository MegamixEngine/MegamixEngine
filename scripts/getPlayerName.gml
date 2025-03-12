///getPlayerName(original)
// Replaces the given string with a proper replacement. Useful for custom skins.
// Example: "Rock" when playing as Proto Man becomes "Blues," "he" when playing as Roll becomes "she," etc.

var myChar = 0;

var original = argument0,
    substitute = "",
    costume = global.costumeSelected[myChar],
    gender = 0; // 0 = Male, 1 = Female, 2 = Neutral

// genders
if (costume == "Roll")
{
    gender = 1;
}

var _customName = global.customCostumeName;
if (global.customCostumeEquipped[myChar])//costume == "Custom Costume")
{
    gender = global.customCostumeGender[0];
    _customName = global.customCostumeName;
    if (string_pos(" (", _customName) > 0)
    {
        _customName = string_copy(_customName, 1, string_pos(" (", _customName) - 1);
    }
}

switch (original)
{
    case "Mega Man":
        substitute = costume;
        if (costume == "Custom Costume")
        {
            substitute = _customName;
        }
        break;
    case "Megaman":
        substitute = costume;
        if (costume == "Mega Man") {substitute = "Megaman";}
        else if (costume == "Proto Man") {substitute = "Protoman";}
        else if (costume == "Custom Costume")
        {
            // delete spaces and lower the uppercase letters after the first one
            if (string_length(_customName) > 1)
            {
                substitute = string_copy(_customName, 1, 1) + string_lower(string_copy(_customName, 2, string_length(_customName)));
                substitute = string_replace_all(substitute, " ", "");
            }
            else
            {
                substitute = _customName;
            }
        }
        break;
    case "Mega":
        substitute = costume;
        if (costume == "Mega Man") {substitute = "Mega";}
        else if (costume == "Proto Man") {substitute = "Proto";}
        else if (costume == "Custom Costume")
        {
            // only use part before the first space
            substitute = _customName;
            if (string_pos(" ", substitute) > 0)
            {
                substitute = string_copy(substitute, 1, string_pos(" ", substitute) - 1);
            }
        }
        break;
    case "Rockman":
        substitute = costume;
        if (costume == "Mega Man") {substitute = "Rockman";}
        else if (costume == "Proto Man") {substitute = "Blues";}
        else if (costume == "Bass") {substitute = "Forte";}
        else if (costume == "Custom Costume")
        {
            // delete spaces and lower the uppercase letters after the first one
            if (string_length(_customName) > 1)
            {
                substitute = string_copy(_customName, 1, 1) + string_lower(string_copy(_customName, 2, string_length(_customName)));
                substitute = string_replace_all(substitute, " ", "");
            }
            else
            {
                substitute = _customName;
            }
        }
        break;
    case "Rock":
        substitute = costume;
        if (costume == "Mega Man") {substitute = "Rock";}
        else if (costume == "Proto Man") {substitute = "Blues";}
        else if (costume == "Bass") {substitute = "Forte";}
        else if (costume == "Custom Costume")
        {
            // only use part before the first space
            substitute = _customName;
            if (string_pos(" ", substitute) > 0)
            {
                substitute = string_copy(substitute, 1, string_pos(" ", substitute) - 1);
            }
        }
        break;
    case "He/She":
        if (gender == 0) {substitute = "He";}
        else if (gender == 1) {substitute = "She";}
        else if (gender == 2) {substitute = "They";}
        break;
    case "he/she":
        if (gender == 0) {substitute = "he";}
        else if (gender == 1) {substitute = "she";}
        else if (gender == 2) {substitute = "they";}
        break;
    case "he's/she's":
        if (gender == 0) {substitute = "he's";}
        else if (gender == 1) {substitute = "she's";}
        else if (gender == 2) {substitute = "they're";}
        break;
    case "they've":
        if (gender == 0) {substitute = "he's";}
        else if (gender == 1) {substitute = "she's";}
        else if (gender == 2) {substitute = "they've";}
        break;
    case "man/woman":
        if (gender == 0) {substitute = "man";}
        else if (gender == 1) {substitute = "woman";}
        else if (gender == 2) {substitute = "person";}
        break;
    case "Man/Woman/Bot":
        if (gender == 0) {substitute = "Man";}
        else if (gender == 1) {substitute = "Woman";}
        else if (gender == 2) {substitute = "Bot";}
        break;
    case "him/her":
        if (gender == 0) {substitute = "him";}
        else if (gender == 1) {substitute = "her";}
        else if (gender == 2) {substitute = "them";}
        break;
    case "his/her":
        if (gender == 0) {substitute = "his";}
        else if (gender == 1) {substitute = "her";}
        else if (gender == 2) {substitute = "their";}
        break;
    case "his/hers":
        if (gender == 0) {substitute = "his";}
        else if (gender == 1) {substitute = "hers";}
        else if (gender == 2) {substitute = "theirs";}
        break;
    case "mister/miss":
        if (gender == 0) {substitute = "mister";}
        else if (gender == 1) {substitute = "miss";}
        else if (gender == 2) {substitute = "mix";}
        break;
    case "sir/ma'am":
        if (gender == 0) {substitute = "sir";}
        else if (gender == 1) {substitute = "ma'am";}
        else if (gender == 2) {substitute = "mate";}
        break;
    case "boy/girl":
        if (gender == 0) {substitute = "boy";}
        else if (gender == 1) {substitute = "girl";}
        else if (gender == 2) {substitute = "child";}
        break;
    case "Mr./Mrs.":
        if (gender == 0) {substitute = "Mr.";}
        else if (gender == 1) {substitute = "Mrs.";}
        else if (gender == 2) {substitute = "Mx.";}
        break;
    case "Dude":
        if (gender == 0) {substitute = "Dude";}
        else if (gender == 1) {substitute = "Dudette";} // Gamer Dudes, Dudettes
        else if (gender == 2) {substitute = "Dude";}
        break;
    case "dude":
        if (gender == 0) {substitute = "dude";}
        else if (gender == 1) {substitute = "dudette";}
        else if (gender == 2) {substitute = "dude";}
        break;
    case "brother":
        if (gender == 0) {substitute = "brother";}
        else if (gender == 1) {substitute = "sister";}
        else if (gender == 2) {substitute = "sibling";}
        break;
    case "king":
        if (gender == 0) {substitute = "king";}
        else if (gender == 1) {substitute = "queen";}
        else if (gender == 2) {substitute = "sovereign";}
        break; 
    case "their":
        if (gender == 0) {substitute = "his";}
        else if (gender == 1) {substitute = "her";}
        else if (gender == 2) {substitute = "their";}
        break;   
    case "lord":
        if (gender == 0) {substitute = "lord";}
        else if (gender == 1) {substitute = "lady";}
        else if (gender == 2) {substitute = "laird";}
        break;    
    case "prince":
        if (gender == 0) {substitute = "prince";}
        else if (gender == 1) {substitute = "princess";}
        else if (gender == 2) {substitute = "potentate";}
        break; 
    case "guy":
        if (gender == 0) {substitute = "guy";}
        else if (gender == 1) {substitute = "gal";}
        else if (gender == 2) {substitute = "bod";}
        break;
    case "pal":
        if (gender == 0) {substitute = "pal";}
        else if (gender == 1) {substitute = "missy";}
        else if (gender == 2) {substitute = "bub";}
        break;
    case "lad":
        if (gender == 0) {substitute = "lad";}
        else if (gender == 1) {substitute = "lass";}
        else if (gender == 2) {substitute = "mate";}
        break;
    case "kid":
        if (costume == "Mega Man") || (costume == "Roll")
        {
            substitute = "kid";
        }
        else
        {
            if (gender == 0) {substitute = "guy";}
            else if (gender == 1) {substitute = "gal";}
            else if (gender == 2) {substitute = "bod";}
        }
        break;
    case "species"://Gets a pure species for papyrus.
        substitute = "robot";
        
        if (global.customCostumeEquipped[0])
        {
            switch (global.customCostumeSpecies[0])
            {
                case 0:
                    substitute = "robot";
                break;
                case 1:
                    substitute = "human";
                break;
                case 2:
                    substitute = "animal";
                break;
                case 3:
                    substitute = "entity";
                break;
            }
        }
        break;
    case "robot":
        substitute = "robot";
        
        if (global.customCostumeEquipped[0])
        {
            switch (global.customCostumeSpecies[0])
            {
                case 0:
                    substitute = "robot";
                break;
                case 1:
                    switch (global.customCostumeGender[0])
                    {
                        case 0:
                            substitute = "man";
                        break;
                        case 1:
                            substitute = "girl";//Dunno why they're different above but better to go with the flow.
                        break;
                        case 2:
                            substitute = "human";
                        break;
                    }
                break;
                case 2:
                    substitute = "animal";
                break;
                case 3:
                    substitute = "entity";
                break;
            }
        }
        break;
    case "robots":
        substitute = "robots";
  
        if (global.customCostumeEquipped[0])
        {
            switch (global.customCostumeSpecies[0])
            {
                case 0:
                    substitute = "robots";
                break;
                case 1:
                    switch (global.customCostumeGender[0])
                    {
                        case 0:
                            substitute = "men";
                        break;
                        case 1:
                            substitute = "girls";//Dunno why they're different above but better to go with the flow.
                        break;
                        case 2:
                            substitute = "humans";
                        break;
                    }
                break;
                case 2:
                    substitute = "animals";
                break;
                case 3:
                    substitute = "entities";
                break;
            }
        }
        break;

    case "color": case "colour":
        if (global.multiplayerColors && global.playerCount > 1)
        {
            substitute = "red";
        }
        else
        {
            if (costume == "Custom Costume") {substitute = getNameOfColor(global.primaryCol[myChar]);
                if (substitute == "white" || substitute == "black")//Avoid using these colors in reference to the player.
                {
                    substitute = "gray";
                }
            }
            else if (costume == "Mega Man")
            {substitute = "blue";}
            else if ((costume == "Proto Man")||(costume == "Roll"))
            {substitute = "red";}
            else if (costume == "Bass")
            {substitute = "gray";}
        }
        if (original == "colour" && substitute == "gray")//Replace with British spelling if using the British spelling.
        {
            substitute = "grey";
        }
        break;
}

//random_set_seed_safe(storeRandom);
return substitute;

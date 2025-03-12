/// itemData(id, returnKey)
// Script that defines all items in the game + their properties
// SCRIPT 420 BTW WOOOOOOOOO
//itemData
var itemName = "undefined";
var itemDescription = "undefined";
var itemSprite = noone;
var itemSubimg = 0;
var itemVariable = "undefined";
var itemCanDisable = true;
var itemCanAssign = false;
var itemCanUse = false;
var itemRequired = 1; //Is the item required for 100%?

var maxItem = 100;

// Data entry
switch (argument0)
{
    // Energy Balancer
    case 0:
        itemName = "Energy Balancer";
        itemDescription = "If your current weapon doesn't need energy when you pick up an ammo refill, the weapon with the least energy will be refilled instead.";
        //itemDescription = "Automatically sends weapon energy to the weapon with the least energy if no energy is needed for the current weapon.";
        itemSprite = sprUpgrades; itemSubimg = 0;
        itemVariable = "energyBalancer"; itemCanDisable = true; itemCanAssign = false;
        break;
        
    // Energy Saver
    case 1:
        itemName = "Energy Saver";
        itemDescription = "Reduces the cost of using Special Weapons. It seems to be an outdated model that only works with the weapons you brought to the tournament...";
        //itemDescription = "Cuts the cost of using Special Weapons. It seems to be an outdated model...";
        itemSprite = sprUpgrades; itemSubimg = 1;
        itemVariable = "energySaver"; itemCanDisable = true; itemCanAssign = false;
        break;
        
    // Flurry Buster
    case 2:
        itemName = "Flurry Buster";
        itemDescription = "A solar-powered booster that enhances the Buster, increasing the number of shots you can have on screen.";
        itemSprite = sprUpgrades; itemSubimg = 2;
        itemVariable = "shotUpgrade"; itemCanDisable = true; itemCanAssign = false;
        break;
        
    // Skull Amulet
    case 3:
        itemName = "Skull Amulet";
        itemDescription = "A special charm that will save you from a fatal blow, as long as your HP is above 1.";
        itemSprite = sprUpgrades; itemSubimg = 3;
        itemVariable = "skullAmulet"; itemCanDisable = true; itemCanAssign = false;
        break;
        
    // Metall Helmet
    case 4:
        itemName = "Metall Helmet";
        itemDescription = "A sturdy helmet usually worn by Metalls that reduces knockback after getting hit.";
        itemSprite = sprUpgrades; itemSubimg = 4;
        itemVariable = "sturdyHelmet"; itemCanDisable = true; itemCanAssign = false;
        break;
        
    // Payday
    case 5:
        itemName = "Payday";
        itemDescription = "A modified metal detector that increases the value and drop chance of bolts, but lowers the drop chance of everything else.";
        itemSprite = sprUpgrades; itemSubimg = 5;
        itemVariable = "payday"; itemCanDisable = true; itemCanAssign = false;
        break;
        
    // Energy Converter
    case 6:
        itemName = "Energy Converter";
        itemDescription = "When enemies would drop health while you have full HP, they'll drop ammo instead, and vice versa. When you're full on both, they become bolts.";
        itemSprite = sprUpgrades; itemSubimg = 6;
        itemVariable = "converter"; itemCanDisable = true; itemCanAssign = false;
        break;
        
    // Step Booster
    case 7:
        itemName = "Step Booster";
        itemDescription = "Increases the speed at which you climb ladders. Known to improve mental well-being.";
        itemSprite = sprUpgrades; itemSubimg = 7;
        itemVariable = "stepBooster"; itemCanDisable = true; itemCanAssign = false;
        break;
        
    // Blast Wind
    case 8:
        itemName = "Blast Wind";
        itemDescription = "Reinforced iron boots with jet turbines attached that completely nullify knockback while sliding.";
        itemSprite = sprUpgrades; itemSubimg = 8;
        itemVariable = "blastWind"; itemCanDisable = true; itemCanAssign = false;
        break;
        
    // Trickle Charge
    case 9:
        itemName = "Trickle Charge";
        itemDescription = "Slightly refills the energy of all Special Weapons anytime you reach a checkpoint.";
        //itemDescription = "Whenever you reach a checkpoint for the first time, your Weapon Energy for all Special Weapons is refilled slightly.";
        itemSprite = sprUpgrades; itemSubimg = 9;
        itemVariable = "trickleCharge"; itemCanDisable = true; itemCanAssign = false;
        break;
        
    // Mystery Container
    case 10:
        itemName = "Mystery Container";
        itemDescription = "Allows you to carry up to 3 M-Tanks instead of 1.";
        itemSubimg = 10;
        itemVariable = "mysteryContainer"; itemCanDisable = (global.mTanks <= 1); itemCanAssign = false;
        break;
        
    // Error handler
    default:
        return -1;
        break;
}

// Determine what to return
switch (argument1)
{
    case "NAME": return itemName; break;
    case "DESC": return itemDescription; break;
    case "SPRITE": return itemSprite; break;
    case "SUBIMG": return itemSubimg; break;
    case "VAR": return itemVariable; break;
    case "DISABLE": return itemCanDisable; break;
    case "ASSIGN": return itemCanAssign; break;
    case "USE": return itemCanUse; break;
    case "REQUIRED": return itemRequired; break;
    case "MAXITEM": return maxItem; break;
}

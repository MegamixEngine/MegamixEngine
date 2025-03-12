/// checkCheats(cheatEnum,...)

if (global.cheats[argument[0]] && cheatsAllowed())//We do a redundant check on the cheat itself first to immensely save time in most cases.
    return (global.cheats[argument[0]]);
else
    return false;

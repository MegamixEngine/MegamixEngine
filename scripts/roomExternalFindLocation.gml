/// roomExternalFindLocation(location)
var roomLocation = argument0;

directories = makeArray(
"Levels/",
"Levels/Entries/",
"Levels/Entries/SubLevels/",
"Levels/!HUB/Tiers/",
"Levels/!HUB/Tier_Bosses/",
"Levels/!HUB/Miscellaneous/",
"Levels/!HUB/Miscellaneous/Weapon_Tutorials/",
"Levels/Tier_X/",
"Levels/Tier_X/Sublevels/",
"Levels/Tier_X/Shrine/"
);
for (var i = 0; i < array_length_1d(directories); i++)
{
    assert(stringEndsWith(directories[i], "/"), "directory not ending with '/'");
    var candidate = directories[i] + argument[0];
    if (file_exists(candidate + ".room.gmx"))
    {
        roomLocation = candidate;
        break;
    }
}

return roomLocation;

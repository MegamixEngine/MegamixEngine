/// roomExternalFindLocation(location)
var roomLocation = argument0;

directories = makeArray(
"Levels/",
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

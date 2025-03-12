/// roomExternalLoadAsset(assetType, name, filepath)
var assetType = argument0, name = argument1, filepath = argument2;
if (assetType)
{
    
    //Todo: Add baked in external sprite support...?
}
else//BG.
{
    var pth = filename_path(filepath) + name + ".png";
    if (!file_exists(pth))
    {
        assert(false, "Tile asset " + pth + " could not be loaded.");
    }
    if (!ds_map_exists(global.roomExternalBGCache,string_lower(name)))
    {
        global.roomExternalBGCache[? string_lower(name)] = background_add(pth,false,false);
    }
}

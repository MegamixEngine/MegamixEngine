/// customCostume_ClearDisplay

for (var i = 0; i < array_length_1d(global.customCostumeDisplay); i++)
{
    if (sprite_exists(global.customCostumeDisplay[i]))
    {
        sprite_delete(global.customCostumeDisplay[i]);
    }
    global.customCostumeDisplay[i] = -1;
}

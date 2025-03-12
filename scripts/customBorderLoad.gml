/// customBorderLoad(index)

var fileIndex = argument[0]-sprite_get_number(sprBorders)-1;
if (fileIndex >= 0)
{

sprite_replace(global.customBorder_Sprite,
working_directory + "/Borders/" + global.customBorders[fileIndex],1,
false,false,0,0);
}

/// drawPlayerNumber(playerID,x,y,[greyscale?])
var playerID = argument0, drawx = argument1, drawy = argument2;
var grey = false;
if (argument_count == 4)
    grey = argument[3];
    
draw_sprite(sprUIRespawnTimer,17 + playerID,drawx,drawy);
if (!grey)
{
    draw_sprite_ext(sprUIRespawnTimer,(playerID * 4) + 2,drawx,drawy,1,1,0,global.primaryCol[playerID],1);
    draw_sprite_ext(sprUIRespawnTimer,(playerID * 4) + 3,drawx,drawy,1,1,0,global.secondaryCol[playerID],1);
}

/// customCostume_AutogenWhitemasks(filenameWithoutWorkingDirectory)
//Automakes whitemasks for costumes that do not provide them manually.
shader_reset();
var mySprite = sprite_add(working_directory+argument[0],1,false,false,0,0);
if (is_undefined(mySprite) || !sprite_exists(mySprite))
{
    if (sprite_exists(mySprite))
    {
        sprite_delete(mySprite);
    }
    return -1;
}
if (sprite_get_width(mySprite) != sprite_get_width(sprRockman))
{//Will make this work later. For now pulling.
    
    var tempSurface = mm_surface_create(sprite_get_width(sprRockman),sprite_get_height(sprRockman));
    surface_set_target(tempSurface);
    var compiledSprite;// = sprite_add();
    for (var i = 0; i < 4; i++)
    {
        draw_clear_alpha(c_black,0);
        draw_set_blend_mode_ext(bm_one,bm_inv_src_alpha);//bm_add);
        customCostume_DrawAllCostumeCells(mySprite,sprite_get_width(sprRockman)*i,0);
        draw_set_blend_mode(bm_normal);
        switch (i)
        {
            case 0:
                
                compiledSprite = sprite_create_from_surface(tempSurface,0,0,sprite_get_width(sprRockman),sprite_get_height(sprRockman),false,false,0,0);
            break;
            default:
                sprite_add_from_surface(compiledSprite,tempSurface,0,0,sprite_get_width(sprRockman),sprite_get_height(sprRockman),false,false);
            break;
        }
        //
        
    }
    /*if (DEBUG_ENABLED)
    {
        for (var i = 0; i < 4; i++)
        {
            sprite_save(compiledSprite,i,"TEST" + string(i) + ".png")
        }
    }*/
    sprite_delete(mySprite);
    surface_reset_target();
    surface_free(tempSurface);
    //surface_free(sSurf);
    
    return compiledSprite;
}
else
{
    //print("Autogenning whitemask");
    //sprite_delete(mySprite);
    //mySprite = sprite_add(working_directory+argument[0],1,false,false,0,0);
    var tempSurface = mm_surface_create(sprite_get_width(sprRockman),sprite_get_height(sprRockman));
    surface_set_target(tempSurface);
    var newSprite;
    
    var colorIsolate = -1;
    var alphaIsolate = -1;
    var colorReplace = -1;
    var alphaReplace = -1;
    
    
    
    var maxColorColumns = 8;
    
    colorIsolate[3,maxColorColumns] = 0;
    alphaIsolate[3,maxColorColumns] = 0;//Set defaults at the absolute end to not cause problems.
    colorReplace[3,maxColorColumns] = 0;
    alphaReplace[3,maxColorColumns] = 0;
    
    for (var i = 0; i < 4; i++)
    {
        if (i > 0)
        {
            draw_clear_alpha(c_black,0);
            shader_set_safe(shIsolateColor);
            
            for (var j = 0; j < 8; j++)
            {
                var alpha = alphaIsolate[i,j];
                if (alpha > 0)
                {
                    var col = colorIsolate[i,j];
                    
                    var rep = colorReplace[i,j];
                    var repa = alphaReplace[i,j];
                    
                    //printErr(string(color_get_red(col)) + " " + string(color_get_green(col)) + " " + string(color_get_blue(col)) + " " + string(alpha));
                    shader_set_uniform_f(shader_get_uniform(shIsolateColor, "isolation"),color_get_red(col),color_get_green(col),color_get_blue(col),alpha);
                    shader_set_uniform_f(shader_get_uniform(shIsolateColor, "replacement"),color_get_red(rep),color_get_green(rep),color_get_blue(rep),repa);
                    draw_set_blend_mode_ext(bm_one,bm_inv_src_alpha);//bm_inv_dest_alpha,bm_inv_src_alpha);
                    customCostume_DrawAllCostumeCells(mySprite);
                    draw_set_blend_mode(bm_normal);
                }
                else
                {
                    break;
                }
            }
            shader_reset();
            
            sprite_add_from_surface(newSprite,tempSurface,0,0,sprite_get_width(sprRockman),sprite_get_height(sprRockman),false,false);
            
            
        }
        else
        {
            draw_clear_alpha(c_black,0);
            draw_set_blend_mode_ext(bm_one,bm_inv_src_alpha);
            customCostume_DrawAllCostumeCells(mySprite);
            draw_set_blend_mode(bm_normal);
            //Get the values below first since grabbing them above will cause weird mixups with multi-color.
            for (var a = 1; a < 4; a++)//Leave 0 blank for simplicity in the drawing code above.
            {
                for (var b = 0; b < 8; b++)
                {
                    alphaIsolate[a,b] = (surface_getpixel_ext(tempSurface,418+(a*2)-2,665+b) >> 24) & 255;
                    if (alphaIsolate[a,b] > 0)//Save on processing by first checking if this isn't fully transparent.
                    {
                        colorIsolate[a,b] = surface_getpixel(tempSurface,418+(a*2)-2,665+b);
                        colorReplace[a,b] = surface_getpixel(tempSurface,418+(a*2)-1,665+b);
                        alphaReplace[a,b] = (surface_getpixel_ext(tempSurface,418+(a*2)-1,665+b) >> 24) & 255;
                    }
                }
            }
            
            newSprite = sprite_create_from_surface(tempSurface,0,0,sprite_get_width(sprRockman),sprite_get_height(sprRockman),false,false,0,0);
            //printErr(newSprite);//Ignore what I put here before: Tests just generally indicate that the index of deleted sprites is always the same even after they're used.
            //It builds up sprite numbers which concerns me when they should be getting deleted to make room for the og sprite.
            
        }
        //surface_save(tempSurface,working_directory + "outputSkin" + string(i) + ".png");
        //printErr("Saving...");
        //printErr(newSprite);
        //sprite_save(newSprite,i,get_save_filename("*.png","testSkin" + string(i) + ".png"));
        
    }
    surface_reset_target();
    
    mm_surface_free(tempSurface);
    sprite_delete(mySprite);
    
    return newSprite;
}

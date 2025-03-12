/// hitflashEffect([true=start,false=end],[flashColor=c_white])
if (argument[0])
{
    var flashcol = c_white;
    if (argument_count > 1)
    {
        flashcol = argument[1];
    }
    
    switch (global.hitFlashType)
    {
        case 0:
            d3d_set_fog(true, flashcol, 0, 0);
        break;
        //1 is MM1, which had no hitstun effect, so just repeat normal shader setup if we're using shaders.
        case 1:
            if (useShader)
            {
                shaderSetColorreplace(replaceColor[0],newColor[0],replaceColor[1],newColor[1],replaceColor[2],newColor[2],replaceColor[3],newColor[3]);
            }
        break;
        case 2:
            shader_set_safe(shHitstun);
            
            shader_set_uniform_f(shader_get_uniform(shHitstun, "flashcol"),color_get_red(flashcol),color_get_green(flashcol),color_get_blue(flashcol),255);
        break;
        case 3:
            shader_set_safe(shInvisible);
        break;
        
    }
}
else
{
    switch (global.hitFlashType)
    {
        case 0:
            d3d_set_fog(false, 0, 0, 0);
        break;
        case 2:
        case 3:
        case 4:
            shader_reset();
        break;
        
    }

}

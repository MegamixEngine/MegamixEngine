///animationRepeat(start, end, speed)
// I don't want to mess with animationLoop since it doesn't seem like
// it does exactly what I want it to do, so here's this.

image_index = clamp(image_index + argument2, argument0, argument1 + 1);
if (image_index >= argument1 + 1)
    image_index = argument0;

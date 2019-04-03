

var bar_index = argument0;


var result;
result[1] = 0;


if (manualColors) {
  result[0] = healthBarPrimaryColor[bar_index];
  result[1] = healthBarSecondaryColor[bar_index];
}
else {
  // if the colors chosen are higher numbered than valid colors on the NES palette, default to the last in the index (black)
  result[0] = global.nesPalette[min(54, (healthBarPrimaryColor[1] + (healthBarColorSkip * (bar_index - 1))))];
  result[1] = global.nesPalette[min(54, (healthBarSecondaryColor[1] + (healthBarColorSkip * (bar_index - 1))))];
}


return result;




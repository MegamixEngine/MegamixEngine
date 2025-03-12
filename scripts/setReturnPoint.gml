///setReturnPoint(x, y, dir);

var _x = argument[0];
var _y = argument[1];
var _dir = argument[2];

var index = global.returnLayers;

global.returnLayer[     index] = room;
global.returnLayerX[    index] = _x;
global.returnLayerY[    index] = _y;
global.returnLayerDir[  index] = _dir;

global.returnLayers ++;


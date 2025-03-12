// bezierCurveThreePoint(startX, midX, endX, t);

var startX = argument[0];
var midX = argument[1];
var endX = argument[2];
var t = argument[3]; // from 0-1

return power(1 - t, 2)*startX + 2*(1 - t)*t*midX + power(t, 2)*endX;

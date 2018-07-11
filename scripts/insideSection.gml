/// insideSection(x, y)

var _X = argument0;
var _Y = argument1;

return (
    _Y < global.sectionBottom && _Y >= global.sectionTop &&
    _X < global.sectionRight && _X >= global.sectionLeft
    );

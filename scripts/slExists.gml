///slExists(file name, slot dependent?)

var fileName = argument[0] + ".sav";

//Slot specific
if (argument[1])
{
    var folder = "slot" + string(global.saveSlot) + "/";
    
    fileName = folder + fileName;
}

return (file_exists(fileName));


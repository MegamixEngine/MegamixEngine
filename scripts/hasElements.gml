/// hasElements([elementName],...)

for (var i = 0; i < argument_count; i++)
{
    if (indexOf(global.elementsCollected,argument[i]) < 0)
    {
        return false;
    }
}
return true;

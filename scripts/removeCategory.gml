/// removeCategory(entity, category)
/// removes the given category from the given entity, if the entity has it.

var entity = argument0;
var category = argument1;

if (category == "")
{
    exit;
}

var a = stringSplit(entity.category, ",", true);
var deleteIndex = indexOf(a, category);
var b;
b[0] = "";

for (var i = 0; i < array_length_1d(a); i++)
{
    if (i != deleteIndex)
    {
        b[i] = a[i];
    }
}

entity.category = stringJoin(b, ", ");


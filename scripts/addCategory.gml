/// addCategory(entity, category)
/// adds a category to the given entity

var _instance = argument[0];
var _toAdd = argument[1];

if (instance_exists(_instance))
{
    with (_instance)
    {
        if (_instance.category == "")
        {
            _instance.category = _toAdd;
        }
        else if (!hasCategory(_instance.category, _toAdd))
        {
            _instance.category += ", " + _toAdd;
        }
    }
}


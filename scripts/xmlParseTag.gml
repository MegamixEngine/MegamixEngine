/// xmlParseTag(tag)
/// parses a tag of the form <tagname attribute="value" attr2="val2">
/// into a map from attribute to value.
/// do not forget to free the map after you use it!

var dsm, tag = stringTrim(argument0);

dsm = ds_map_create();
// seek to end of tag
tag = stringSubstring(tag, string_pos(" ", tag) + 1);
while (string_pos(" ", tag) != 0)
{
    var attr, value;
    tag = stringTrim(tag);
    
    // read attribute
    attr = stringSubstring(tag, 1, string_pos("=", tag));
    tag = stringSubstring(tag, string_pos("=", tag) + 1);
    
    // read value
    tag = stringSubstring(tag, string_pos('"', tag) + 1);
    value = stringSubstring(tag, 1, string_pos('"', tag));
    tag = stringSubstring(tag, string_pos('"', tag) + 1);
    
    dsm[? attr] = value;
}

return dsm;

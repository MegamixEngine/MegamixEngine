/// xmlParseTag(tag)
/// parses a tag of the form <tagname attribute="value" attr2="val2">
/// into a map from attribute to value.
/// do not forget to free the map after you use it!

var dsm, tag = stringTrim(argument0);

dsm = ds_map_create();
while (string_pos(" ", tag) != 0)
{
    var attr, tag;
    tag = stringSubstring(tag, string_pos(" ", tag) + 1);
    attr = stringSubstring(tag, 1, string_pos("=", tag));
    tag = stringSubstring(tag, string_pos("=", tag) + 2);
    value = stringSubstring(tag, 1, string_pos('"', tag));
    
    dsm[? attr] = value;
}

return dsm;

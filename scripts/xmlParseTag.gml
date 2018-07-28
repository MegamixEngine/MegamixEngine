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
    var eqPos = string_pos("=", tag);
    attr = stringSubstring(tag, 1, eqPos);
    tag = stringSubstring(tag, eqPos + 1);
    
    // read value
    var q1Pos = string_pos('"', tag)
    tag = stringSubstring(tag, q1Pos + 1);
    var q2Pos = string_pos('"', tag)
    value = stringSubstring(tag, 1, q2Pos);
    tag = stringSubstring(tag, q2Pos + 1);
    
    dsm[? attr] = value;
}

return dsm;

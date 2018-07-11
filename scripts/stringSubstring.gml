/// stringSubstring(str, start, [end])
/// returns the substring between start and end
/* examples
  stringSubstring("Pakatto", 2) -> "akatto"
  stringSubstring("Pakatto", 2, 4) -> "ak"
  stringSubstring("Pakatto", 50) -> ""
*/
var str = argument[0];
var start = argument[1];
var _end = string_length(str) + 1;
if (argument_count > 2)
    _end = argument[2];

start = clamp(start, 1, string_length(str) + 1);
_end = clamp(_end, 1, string_length(str) + 1);

if (_end < start)
    return "";

return string_copy(str, start, _end - start);

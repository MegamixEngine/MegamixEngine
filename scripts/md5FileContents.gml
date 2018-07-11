/// md5FileContents(path)
/// reads file and hashes contents
/// does not hash file metadata
// returns hash string, or a negative real number if an error occurred
// hash is idiomatic to gml and the engine.

var str = "";

if (!file_exists(argument0))
    return -1;

var file = file_text_open_read(argument0);

if (file < 0)
    return -2;

while (!file_text_eof(file))
{
    str += file_text_readln(file) + "|
    ";
}

str += "
EOF";

return md5_string_utf8(str);

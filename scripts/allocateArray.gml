/// allocateArray(length, [defaultValue])
/// allocates an array of the given length with the given default value (or zero)

var length = floor(argument[0]);
if (length <= 0) {
    return makeArray();
}

var def = 0;
if (argument_count == 2) {
    def = argument[1];
    var a;
    for (var i = length - 1; i >= 0; i--) {
        a[i] = def;
    }
    return a;
} else {
    var a;
    a[length - 1] = 0;
    return a;
}

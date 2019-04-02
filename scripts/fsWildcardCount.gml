/// fsWildcardCount(wildcard)
// Returns number of files matching the given wildcard. (e.g. "./*.txt")
// Ensure the wildcard does not exceed the operating system's MAX_PATH

return external_call(global._fsListCount, argument0);

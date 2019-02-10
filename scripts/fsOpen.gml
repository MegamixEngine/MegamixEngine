/// fsOpen(path, type)
// Opens the given file for writing. Returns index of file for later use.
// type should be either "r" (read) or "w" (write)

return external_call(global._fsOpen, argument0, argument1);

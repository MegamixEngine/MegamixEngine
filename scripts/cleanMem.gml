// cleanMem()

var task, dll;
task = argument0;
dll = "CleanMem.dll";

if (!file_exists(dll))
{
    exit;
}

switch (task)
{
    case 'clean': // Clean - Gets rid of unneeded data 
        return (external_call(_cleanmem));
        exit;
    case 'init': // Initiate - Needs to be done at the very beginning 
        _cleanmem = external_define(dll, "halo_shg_clean", dll_cdecl, ty_real,
            0);
        _cleanmem_get_mem = external_define(dll, "halo_shg_get_mem", dll_cdecl,
            ty_real, 0);
        return 0;
        exit;
    case 'free': // Free - Should be done when the game is being closed 
        external_free(dll);
        exit;
    case 'get': // Get memory in Megabytes 
        return (external_call(_cleanmem_get_mem) / 1048576);
        exit;
}

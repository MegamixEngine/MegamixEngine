/// chronoInit()
// initializes chrono (high-precision time library)

var dllName = "chrono.dll";
var callType = dll_cdecl;

global._chronoReset = external_define(dllName, "chrono_reset", callType, ty_real, 0);
global._chronoGet   = external_define(dllName, "chrono_get",   callType, ty_real, 1, ty_real);

external_call(global._chronoReset);

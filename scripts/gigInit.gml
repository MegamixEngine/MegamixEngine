/// gigInit()
// loads gig dll
// Gig stands for "GameMaker in GameMaker". It's how we execute string code.
var dllName = "gig.dll";
var callType = dll_cdecl;

/*
For future reference, this script contained a bunch of external_call defintions
as we came to find out, any external_call function that returns a string
WILL cause a memory leak, even in the final version of GMS.

As a result, always make your extensions internal if you plan to return strings.
*/
global.gigDebug = false;//For testing.
global.dll_gigReturnValue = 0;//Return value from getting a value in the DLL.
global.dll_gigExecutionError = false;//Returns > 0 if an error.

// This frees the FMOD dll
// returns nothing

// Example calling
// When game ends
// UnloadFMOD();

if (!FMOD_ENABLED) return 0;

external_free("GMFMODSimple.dll");

// export double FMODAllStop(void)
// This stops all the sound and frees all the instances. Call this when the room ends

if (!FMOD_ENABLED) return 0;

return external_call(global.dll_FMODAllStop);
global.playingcustommusic = false;

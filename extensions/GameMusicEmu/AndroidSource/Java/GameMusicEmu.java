
package net.gamephase.Audio;

public class GameMusicEmu 
{    
	public static native double GameMusicEmu_LoadBuffer(double size, long data_address);
	public static native double GameMusicEmu_NumTracks();
	public static native double GameMusicEmu_StartTrack(double trackNumber);
	public static native double GameMusicEmu_Read(long buffer_address);
	public static native double GameMusicEmu_NumVoices();
	public static native double GameMusicEmu_MuteVoice(double index, double mute);
	public static native double GameMusicEmu_MuteVoices(double mask);
	public static native double GameMusicEmu_SetTempo(double tempo);
	public static native double GameMusicEmu_SetPosition(double msec);
	public static native double GameMusicEmu_GetPosition();
	public static native double GameMusicEmu_GetTrackLength();
	public static native String GameMusicEmu_GetName();
	public static native String GameMusicEmu_GetAuthor();
	public static native String GameMusicEmu_GetCopyright();
	public static native String GameMusicEmu_GetComment();
	public static native double GameMusicEmu_Free();

	static {
		System.loadLibrary("gme");
	}        
}
package ${YYAndroidPackageName};

import android.util.Log;
import java.io.File;
import java.io.FileReader;
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.lang.String;

import ${YYAndroidPackageName}.R;
import com.yoyogames.runner.RunnerJNILib; 

import static net.gamephase.Audio.GameMusicEmu.GameMusicEmu_LoadBuffer;
import static net.gamephase.Audio.GameMusicEmu.GameMusicEmu_NumTracks;
import static net.gamephase.Audio.GameMusicEmu.GameMusicEmu_StartTrack;
import static net.gamephase.Audio.GameMusicEmu.GameMusicEmu_Read;
import static net.gamephase.Audio.GameMusicEmu.GameMusicEmu_NumVoices;
import static net.gamephase.Audio.GameMusicEmu.GameMusicEmu_MuteVoice;
import static net.gamephase.Audio.GameMusicEmu.GameMusicEmu_MuteVoices;
import static net.gamephase.Audio.GameMusicEmu.GameMusicEmu_SetTempo;
import static net.gamephase.Audio.GameMusicEmu.GameMusicEmu_Free;
import static net.gamephase.Audio.GameMusicEmu.GameMusicEmu_SetPosition;
import static net.gamephase.Audio.GameMusicEmu.GameMusicEmu_GetPosition;
import static net.gamephase.Audio.GameMusicEmu.GameMusicEmu_GetTrackLength;
import static net.gamephase.Audio.GameMusicEmu.GameMusicEmu_GetName;
import static net.gamephase.Audio.GameMusicEmu.GameMusicEmu_GetAuthor;
import static net.gamephase.Audio.GameMusicEmu.GameMusicEmu_GetCopyright;
import static net.gamephase.Audio.GameMusicEmu.GameMusicEmu_GetComment;

public class JGameMusicEmu 
{        
	
	public double JGameMusicEmu_LoadBuffer(double size, String buffer_address)
	{
		return GameMusicEmu_LoadBuffer(size, StringAddressToLongPointer(buffer_address));
	}
	
	public double JGameMusicEmu_NumTracks()
	{
		return GameMusicEmu_NumTracks();
	}
	
	public double JGameMusicEmu_StartTrack(double track)
	{
		return GameMusicEmu_StartTrack(track);
	}
	
	public double JGameMusicEmu_Read(String buffer_address)
	{
		return GameMusicEmu_Read(StringAddressToLongPointer(buffer_address));
	}
	
	public double JGameMusicEmu_NumVoices()
	{
		return GameMusicEmu_NumVoices();
	}
	
	public double JGameMusicEmu_MuteVoice(double voice, double mute)
	{
		return GameMusicEmu_MuteVoice(voice, mute);
	}
	
	public double JGameMusicEmu_MuteVoices(double mask)
	{
		return GameMusicEmu_MuteVoices(mask);
	}
	
	public double JGameMusicEmu_SetTempo(double tempo)
	{
		return GameMusicEmu_SetTempo(tempo);
	}
	
	public double JGameMusicEmu_SetPosition(double msec)
	{
		return GameMusicEmu_SetPosition(msec);
	}

	public double JGameMusicEmu_GetPosition()
	{
		return GameMusicEmu_GetPosition();
	}
	
	public double JGameMusicEmu_GetTrackLength()
	{
		return GameMusicEmu_GetTrackLength();
	}
	
	public String JGameMusicEmu_GetName()
	{
		return GameMusicEmu_GetName();
	}
	
	public String JGameMusicEmu_GetAuthor()
	{
		return GameMusicEmu_GetAuthor();
	}
	
	public String JGameMusicEmu_GetCopyright()
	{
		return GameMusicEmu_GetCopyright();
	}
	
	public String JGameMusicEmu_GetComment()
	{
		return GameMusicEmu_GetComment();
	}
	
	public double JGameMusicEmu_Free()
	{
		return GameMusicEmu_Free();
	}

	// This converts a memory address in string format to a long integer
	// It will be cast to a pointer in C++
	private long StringAddressToLongPointer(String address)
	{
		if(address.charAt(1) == 'x')
			return Long.parseLong(address.substring(2), 16);
		else
			return Long.parseLong(address, 16);
	}
	
}
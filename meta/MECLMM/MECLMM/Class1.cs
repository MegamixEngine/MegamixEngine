using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.InteropServices;
using System.IO;
using System.Diagnostics;
using System.Text.RegularExpressions;
using System.Threading;
using System.Security.Cryptography;
using System.Reflection;
using VorbisCommentSharp;

namespace MECLMM//MaGMML Extra Content Loader (For Mega Mix)
{
    //Contains various functions GMS cannot do on its own (or kicks and screams when you do).
    //Initial version by Gannio, see changelog for other contributors.
    //NOTE: IF YOU REPLACE ANYTHING IN THIS IN A FORK, PLEASE ALSO CHANGE MECLMM_GetFork's output. Thank you :)
    class OggTagReader
    {
        public static double GetTagTimestamp(string filePath, string tagName, double hertz)
        {
            //Open the OGG file
            try
            {
                using (VorbisFile vorbis = new VorbisFile(File.ReadAllBytes(filePath)))
                {
                    //Retrieve the tag value
                    var headers = vorbis.GetPageHeaders();
                    foreach (var header in headers)
                    {
                        var commentHeader = header.GetCommentHeader();
                        if (commentHeader != null)
                        {
                            var c = commentHeader.ExtractComments();

                            if (c.Comments.ContainsKey(tagName) && c.Comments[tagName] != null)
                            {
                                try
                                {
                                    //Convert loop points to FMOD's format here, as it's more accurate than parsing through GMS.
                                    if (tagName == "LOOPSTART" || tagName == "LOOPEND")
                                    {
                                        return Convert.ToUInt64(c.Comments[tagName]) / hertz;
                                    }
                                    else//Volume.
                                    {
                                        return Convert.ToDouble(c.Comments[tagName]);
                                    }
                                }
                                catch
                                {
                                    return -3;
                                }
                            }
                        }
                    }
                    // Convert the tag value to an integer (assuming it's in samples)


                    return -4;
                }
            }
            catch (FileNotFoundException)
            {
                return -2;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
                Console.WriteLine(e.StackTrace.ToString());
                return -99;
            }
        }
        public static string GetTag(string filePath, string tagName)
        {
            // Open the OGG file
            try
            {
                using (VorbisFile vorbis = new VorbisFile(File.ReadAllBytes(filePath)))
                {
                    // Retrieve the tag value
                    var headers = vorbis.GetPageHeaders();
                    foreach (var header in headers)
                    {
                        var commentHeader = header.GetCommentHeader();
                        if (commentHeader != null)
                        {
                            var c = commentHeader.ExtractComments();

                            if (c.Comments.ContainsKey(tagName) && c.Comments[tagName] != null)
                            {
                                try
                                {

                                    return c.Comments[tagName];
                                }
                                catch
                                {
                                    return "";
                                }
                            }
                        }
                        /*
                        foreach (var comment in )
                        {
                            if (comment. == tagName)//tagValue == null)
                            {
                                throw new Exception($"Tag '{tagName}' not found in the file.");
                            }
                        }*/
                    }
                    // Convert the tag value to an integer (assuming it's in samples)


                    return "";
                }
            }
            catch (FileNotFoundException)
            {
                return "NOFILE";
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
                Console.WriteLine(e.StackTrace.ToString());
                return "ERROR";
            }
        }

    }

    
    public class MECLMM
    {

        [DllExport("MECLMM_GetVersion", CallingConvention.Cdecl)]//Can be anything on the string.
        public static double GetVersion()//Used at the start of the game to check DLL version. If there's a mismatch relative to the features the current engine needs, an error should be made to pop up in objExtensionCheck.
        {
            return 100;
        }
        [DllExport("MECLMM_GetFork", CallingConvention.Cdecl)]//Can be anything on the string.
        public static unsafe byte* GetFork(char* filename, char* key)
        {
            return ToGMSString("Public");
        }
        private static int _maxstrsize = 256; //Will automatically reallocate if the insert string is bigger.
        
        private static IntPtr _strbuffer = Marshal.AllocHGlobal(_maxstrsize);
        private static unsafe byte* ToGMSString(string normalString)
        {//Converts string data to send back to GMS.
            var strBytes = Encoding.UTF8.GetBytes(normalString);

            var maxLength = Math.Min(_maxstrsize - 1, strBytes.Length); //maxlen-1 to keep space for null terminator

            if (strBytes.Length > _maxstrsize)
            {
                _maxstrsize = strBytes.Length;
                _strbuffer = Marshal.AllocHGlobal(_maxstrsize);
            }

            Marshal.Copy(strBytes, 0, _strbuffer, maxLength);

            var strPtr = (byte*)_strbuffer;
            strPtr[maxLength] = (byte)0; //don't forger the darn null terminator!

            return strPtr;
        }
        #region CustomArenaMusicStuff

        [DllExport("MECLMM_GetSongLength", CallingConvention.Cdecl)]//Can be anything on the string.
        public static unsafe double GetSongLength(char* filename)
        {
            string fn = Marshal.PtrToStringAnsi((IntPtr)filename);
            return -404;
        }

        [DllExport("MECLMM_GetOGGDataTagString", CallingConvention.Cdecl)]//Can be anything on the string.
        public static unsafe byte* GetOGGDataTagString(char* filename, char* key)
        {
            string fn = Marshal.PtrToStringAnsi((IntPtr)filename);
            string k = Marshal.PtrToStringAnsi((IntPtr)key);
            return ToGMSString(OggTagReader.GetTag(fn,k));
        }
        [DllExport("MECLMM_GetOGGDataTagReal", CallingConvention.Cdecl)]
        public static unsafe double GetOGGDataTagReal(char* filename, char* key, double hertz)
        {
            string fn = Marshal.PtrToStringAnsi((IntPtr)filename);
            string k = Marshal.PtrToStringAnsi((IntPtr)key);
            return OggTagReader.GetTagTimestamp(fn, k, hertz);
        }
        #endregion

        #region SHA256 hashing.

        [DllExport("sha256_string_unicode", CallingConvention.Cdecl)]
        public static unsafe byte* MECLMM_SHA256(char* parametersC)
        {
            string input = Marshal.PtrToStringAnsi((IntPtr)parametersC);
            return ToGMSString(CalculateSHA256(input));

        }

        static string CalculateSHA256(string input)
        {//Hashes a string. SHA-256 is more secure than GMS's best hashing, SHA1, but is falling out of favor in today's standards.
         //Ideally, this should be replaced with newer standards as the world advances (Quantum computing, once achieved in a commercial level, will make this worthless).
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes = Encoding.UTF8.GetBytes(input); // Convert the string to bytes
                byte[] hashBytes = sha256.ComputeHash(bytes); // Compute the hash

                StringBuilder builder = new StringBuilder();
                for (int i = 0; i < hashBytes.Length; i++)
                {
                    builder.Append(hashBytes[i].ToString("x2")); // Convert each byte to its hexadecimal representation
                }
                return builder.ToString();
            }
        }
        static string CalculateSHA256File(string filePath)
        {
            //File form of above.
            using (SHA256 sha256 = SHA256.Create())
            using (FileStream fileStream = File.OpenRead(filePath))
            {
                byte[] buffer = new byte[8192]; // 8KB buffer size
                int bytesRead;
                while ((bytesRead = fileStream.Read(buffer, 0, buffer.Length)) > 0)
                {
                    sha256.TransformBlock(buffer, 0, bytesRead, buffer, 0);
                }

                // Complete the hash computation
                sha256.TransformFinalBlock(buffer, 0, 0);

                byte[] hashBytes = sha256.Hash;

                StringBuilder builder = new StringBuilder();
                for (int i = 0; i < hashBytes.Length; i++)
                {
                    builder.Append(hashBytes[i].ToString("x2")); // Convert each byte to its hexadecimal representation
                }

                return builder.ToString();
            }
        }

        #endregion

       
        
        

        #region System Functions
        [DllExport("MECLMM_GetMemory", CallingConvention.Cdecl)]
        public static double MECLMM_GetMemory()//Returns memory in MB. Used for debugging memory leaks.
        {
            // Get the current process
            Process currentProcess = Process.GetCurrentProcess();

            // Get the memory usage in bytes
            long memoryUsageBytes = currentProcess.WorkingSet64;

            // Convert bytes to megabytes
            double memoryUsageMegabytes = memoryUsageBytes / (1024.0 * 1024.0);

            return memoryUsageMegabytes;
        }
        [DllExport("MECLMM_CheckDriveSpace", CallingConvention.Cdecl)]
        static double MECLMM_CheckDriveSpace(double bytesRequired)
        {
            //Only works for C Drive, as that's all GMS uses for save files.
            string driveLetter = "C";
            DriveInfo drive = new DriveInfo(driveLetter);

            if (drive.IsReady)
            {
                //Get the available free space in bytes
                long availableSpace = drive.AvailableFreeSpace;

                //Determine if there is enough space
                if (availableSpace >= bytesRequired)
                {
                    return 1.0;
                }
                else
                {
                    return 0.0;
                }
            }
            else
            {
                //If the drive is not ready, return false
                return 0.0;
            }

        }

        [DllExport("MECLMM_OpenURL", CallingConvention.Cdecl)]
        public static unsafe double OpenURL(char* url)
        {//Opens a URL since GMS doesn't do it correctly anymore.

            string input = Marshal.PtrToStringAnsi((IntPtr)url);
            try
            {
                // Start the default browser with the URL
                Process.Start(new ProcessStartInfo(input) { UseShellExecute = true });
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred: " + ex.Message);
            }
            return 1.0;
        }
        #endregion

    }

}

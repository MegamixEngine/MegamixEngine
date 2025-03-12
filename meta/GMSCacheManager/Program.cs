using System;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Collections.Generic;
using System.Xml;

namespace GMSCacheManager
{
    class Program
    {
        static void Main(string[] args)
        {
            if (args.Length == 0)
            {
                Console.WriteLine("Usage: \n-runLast: Runs last created GMS cache data.\n-clearLightweightData: Clear OGGs from a lightweight build (Will *not* support main build).");
                if (args[0] == "-clearLightweightData")
                {
                    Console.WriteLine("Specify lightweight path.");
                    args.Append(Console.ReadLine());
                }
            }
            if (args[0] == "-runLast")
            {
                string runnerDirectory = "C:\\Program Files (x86)\\Steam\\steamapps\\common\\gamemaker_studio\\Runner.exe";
                string appData = Environment.GetFolderPath(Environment.SpecialFolder.UserProfile) + "\\AppData\\Local";
                List<string> extensions = new List<string>();


                string[] folders = Directory.GetDirectories(appData, "gm_ttt_*");
                foreach (string folder in folders)
                {
                    Console.WriteLine(folder);
                }
                extensions.Add(".win");
                DateTime latestTime = DateTime.Now.AddDays(1000);//Leniency.
                string latestGame = "";
                foreach (string dir in folders)
                {
                    string[] files = Directory.GetFiles(dir, "*.*", SearchOption.AllDirectories)
                            .Where(f => extensions.IndexOf(Path.GetExtension(f)) >= 0).ToArray();
                    foreach (string file in files)
                    {
                        var date = File.GetLastWriteTime(file);
                        if (latestGame == "" || DateTime.Compare(date, latestTime) > 0)
                        {
                            latestGame = file;
                            latestTime = date;
                        }
                        Console.WriteLine(file);
                    }
                }
                Console.WriteLine("Latest one is " + latestGame);
                Process process = new Process();
                ProcessStartInfo startInfo = new ProcessStartInfo();
                startInfo.WindowStyle = ProcessWindowStyle.Hidden;
                startInfo.FileName = runnerDirectory;//"cmd.exe";
                startInfo.Arguments = "-game \"" + latestGame + "\"";//"/C copy /b Image1.jpg + Archive.rar Image2.jpg";
                process.StartInfo = startInfo;
                process.Start();
                Console.ReadLine();
                //Console.WriteLine("Hello World!");
            }
            else if (args[0] == "-clearLightweightData")
            {
                var i = 1;
                if (args[1] == "-doExternalRoomClear")
                {
                    doRoomClear = true;
                    i++;
                }
                if (!args[i].Contains("lw_"))
                {
                    Console.WriteLine("Will not compile projects without lw_ at the beginning!!! This is a safety measure.");
                    return;
                }
                Console.WriteLine("Beginning to clear data.");
                XmlDocument doc = new XmlDocument();
                doc.Load(args[i]);
                ReadXML(doc.SelectSingleNode("*"));//TraverseNodes(doc.LastChild.ChildNodes);
                foreach (XmlNode node in myDataNodes)
                {
                    
                    
                    node.ParentNode.ParentNode.RemoveChild(node.ParentNode);
                    
                }
                doc.Save(args[i].Replace("lw_", "lw_"));
                Console.WriteLine("Done! Press enter to exit.");
                Console.ReadLine();
            }
        }
        /*private static int TraverseNodes(XmlNodeList nodes)
        {
            foreach (XmlNode node in nodes)
            {
                Console.WriteLine(node.Name);
                if (node.Name == "name" && node.Value.Contains(".ogg"))
                {
                    return -1;
                }
                else
                {
                    // Do something with the node.
                    var output = TraverseNodes(node.ChildNodes);
                    if (output == -1)
                    {
                        
                    }
                    return output;
                }
            }
            return 1;
        }*/
        private static void ReadXML(XmlNode root)
        {
            if (root is XmlElement)
            {
                if (DoWork(root))
                {
                    if (root.HasChildNodes)
                        ReadXML(root.FirstChild);
                    if (root.NextSibling != null)
                        ReadXML(root.NextSibling);
                }
            }
            else if (root is XmlText)
            { }
            else if (root is XmlComment)
            { }
        }
        private static List<XmlNode> myDataNodes = new List<XmlNode>();
        private static bool doRoomClear = false;
        private static bool DoWork(XmlNode root)
        {
            var innerText = root.InnerText.ToLower();
            if (root.Name == "name" && (innerText.Contains(".ogg") || innerText.Contains(".mp3") || innerText.Contains(".nsf") || innerText.Contains(".spc") || innerText.Contains(".gbs") || innerText.Contains(".vgm") || innerText.Contains(".s3m") || innerText.Contains(".vgz") || (doRoomClear && innerText.Contains(".room.gmx"))))
            {
                Console.WriteLine("Removing " + innerText);
                //root.ParentNode.RemoveAll();
                myDataNodes.Add(root);
                //Console.WriteLine(root.Value);
                //root.ParentNode.ParentNode.RemoveChild(root.ParentNode);
                return false;
            }
            return true;
            //Console.WriteLine(root.Name);
        }
    }
}

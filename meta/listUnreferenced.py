usage = """
./listUnreferenced.py <path/to/some.project.gmx> [--generate-lightweight]

Applies to Game Maker Studio 1 files only.
"""

import sys
import re
import os
import multiprocessing as mp
import time

refTypes = ["script", "object", "room", "sprite", "background", "timeline", "sound"]
srcTypes = ["script", "object", "room", "timeline"]
required = ["^root", "prtBoss", "prtMiniBoss", "prtEntity"]
externalRoomDirs = ["datafiles/Levels/Entries","datafiles/Levels/Neo_Pit_of_Pits"]

#Note(Fabián) checkNoSuffix doesn't matter anymore since we're splitting the input into tokens

lineRegex = re.compile("\s*<(" + "|".join(refTypes) + ")>(" + "|".join(refTypes) + ")s?\\\\([^<.]*)(.gml)?</")

prefices = ["msk", "spr", "obj", "bg"]#, "rm", "lvl", "tst", "prt", "scr", "player", "FMOD", "GME", "string", "lockPool", "roomExternal", "unit", "gig", "recordInput", "testSuite"]
#prefixRegex = re.compile("\\b(" + "|".join(prefices) + ")")
prefices_set = set(prefices)

def no_extension(str):
	while True:
		split = os.path.splitext(str)
		if len(split) < 2:
			return str
		if split[1] == "":
			return str
		str = split[0]
		

#Note(Fabián): Passing less arguments also makes it faster, that's why I removed the graph
def check_file_for_references(ref_file, ref_name, names_set, unprefixed_names_set):
	print("scanning " + ref_name)
	
	rfs = set()
	with open(ref_file, "r", encoding="utf8") as rf:
		#Note(Fabián): I'm not sure if this makes it less accurate, but at least it takes just a few seconds to run
		rfs = set(re.split('\'|\s|;|,|\*|\n|&lt|&gt|&amp;&amp|\(|\)|\[|\]|&quot;|\"|<|>|/,\+|\-|=|!=|&#xA|#|\|'	,rf.read()))
		
	edges = []
	for match in names_set.intersection(rfs):
		edges.append((ref_name, match))	
	
	#nonprefixed lookup
	for match in unprefixed_names_set.intersection(rfs):
		edges.append((ref_name, match))		
		
	return edges
			

def get_unreferenced_list(project_file):
	graph = {("^root", "^root")} # set
	names = []
	unprefixed_names = []
	
	#build referencer corpus
	dir = os.path.dirname(project_file)
	
	# check each resource for if it is referenced
	print()
	print("Compositing resources...", flush=True)
	
	#Note(Fabián) This is a workaround to avoid searching the same room multiple times
	#since the external rooms still have copies in the rooms folder
	room_ref_names = set()
	
	with open(project_file, "r") as projf:
		s = projf.read();
		for line in s.splitlines(False):
			match = lineRegex.match(line)
			if match:
				match_type = match.group(2)
				match_name = no_extension(match.group(3))
				
				if match_type == "room":
					if match_name not in room_ref_names:
						unprefixed_names.append(match_name)
						graph.add(("^root", match_name))
				else:
					hasPrefix = False
					for prefix in prefices:
						if match_name.startswith(prefix):
							hasPrefix = True
							break
					if hasPrefix:
						names.append(match_name)
					else:
						unprefixed_names.append(match_name)
	
			elif "</filename>" in line and ".room.gmx" in line:
				splitted = re.split('<filename>|</filename>', line)
				ref_name = no_extension(splitted[1])
				if ref_name not in room_ref_names:
					graph.add(("^root", ref_name))
					unprefixed_names.append(ref_name)
	names.sort()
	unprefixed_names.sort()
	
	names_set = set(names)
	unprefixed_names_set = set(unprefixed_names)
	
	room_ref_names = set()
	
	print("Dividing labour...", flush=True)
	works = []
	
	for type in srcTypes:
		typedir = os.path.join(dir, type + "s")
		for filename in os.listdir(typedir):
			ref_file = os.path.join(typedir, filename)
			ref_name = no_extension(filename)
			if os.path.isfile(ref_file):
				works.append((ref_file, ref_name, names_set, unprefixed_names_set))
				if type == "room":
					room_ref_names.add(ref_name)
				
	for externalDir in externalRoomDirs:
		externalDir = os.path.join(dir, externalDir)
		if os.path.isdir(externalDir):
			for filename in os.listdir(externalDir):
				ref_name = no_extension(filename)
				if ref_name not in room_ref_names:
					ref_file = os.path.join(externalDir, filename)
					if os.path.isfile(ref_file):
						room_ref_names.add(ref_name)
						works.append((ref_file, ref_name, names_set, unprefixed_names_set))
		else:
			print("invalid dir " + externalDir)
	
	print("Launching threads...", flush=True)
	tstart = time.time()
	with mp.Pool(max(1, int(mp.cpu_count() / 1.5))) as tpe:
		results = [tpe.apply_async(check_file_for_references, args=work) for work in works]
		
		print("Waiting for threads to join... (If this line hangs, use the Windows command line.)", flush=True)
		
		print("Aggregating reference graph...")
		for edges in results:
			for edge in edges.get():
				graph.add(edge)
	print("Scan time seconds " + str(time.time() - tstart), flush=True)
	
	print("Computing connections...", flush=True)
	connected = set(required)
	history = {}
	# compute all connected to root (note bien: connection is directed from root to resource)
	i = 0
	while True:
		i += 1
		print("  iteration " + str(i), flush=True)
		print("  referenced resources: " + str(len(connected)), flush=True)
		change = False
		for edge in graph:
			if edge[0] in connected and edge[1] not in connected:
				connected.add(edge[1])
				history[edge[1]] = edge[0]
				change = True
		if not change:
			break
	disconnected = []
	for name in names:
		if name not in connected:
			disconnected.append(name)
	for name in unprefixed_names:
		if name not in connected:
			disconnected.append(name)
	return disconnected, connected, history
								

if __name__ == '__main__':
	if len(sys.argv) >= 2:
		projfile = sys.argv[1]
		disconnected, connected, history = get_unreferenced_list(projfile)
		print("resources used:", len(connected))
		print("resources unused:", len(disconnected))
		print("Writing output to out.txt")
		with open("out.txt", "w") as out:
			out.write("The following resource are referenced to a room:\n")
			for u in connected:
				h = u
				hstr = u
				while h not in required:
					h = history[h]
					if h != "^root":
						hstr += " <- " + h
				if hstr not in required:
					out.write(hstr + "\n")
			out.write("\nThe following resource are not referenced by other resources:\n")
			for u in disconnected:
				out.write(u + "\n")
		if "--generate-lightweight" in sys.argv:
			dir = os.path.dirname(projfile)
			with open(projfile, "r") as f:
				newfile = ""
				for line in f:
					match = lineRegex.match(line)
					skip = False
					if match:
						match_name = no_extension(match.group(3))
						if match_name in disconnected:
							skip = True
					if not skip:
						newfile += line
			outfile = "lw_" + os.path.basename(projfile)
			print("Generating " + outfile)
			with open(os.path.join(dir, outfile), "w") as out:
				out.write(newfile)
	else:
		print(usage)

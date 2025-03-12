usage = """
./listUnreferenced.py <path/to/some.project.gmx> [--generate-lightweight]

Applies to Game Maker Studio 1 files only.
"""

import sys
import re
import os
import multiprocessing as mp

refTypes = ["script", "object", "room", "sprite", "background", "timeline", "sound"]
srcTypes = ["script", "object", "room", "timeline"]

required = ["^root", "prtBoss", "prtMiniBoss", "prtEntity"]
external_paths = ["datafiles/Levels/Engine_-Leftovers","datafiles/Levels/Entries","datafiles/Levels/Neo_Pit_of_Pits"]

# objChillSpike is a substring of objChillSpikeLanded, which turns out to be common, so we need to double-check it.
checkNoSuffix = ["objChillSpike"]
lineRegex = re.compile("\s*<(" + "|".join(refTypes) + ")>(" + "|".join(refTypes) + ")s?\\\\([^<.]*)(.gml)?</")

prefices = ["msk", "spr", "obj", "bg"]#, "rm", "lvl", "tst", "prt", "scr", "player", "FMOD", "GME", "string", "lockPool", "roomExternal", "unit", "gig", "recordInput", "testSuite"]
#prefixRegex = re.compile("\\b(" + "|".join(prefices) + ")")

def no_extension(str):
	while True:
		split = os.path.splitext(str)
		if len(split) < 2:
			return str
		if split[1] == "":
			return str
		str = split[0]
		
def check_file_for_references(ref_file, ref_name, names, unprefixed_names, graph):
	print("scanning " + ref_name)
	rfs = ""
	match_names = set()
	with open(ref_file, "r", encoding="utf8") as rf:
		# check for referenced
		rfs = rf.read()
		
	# this is faster than checking a |-joined regex
	span = 400
	i = 0
	external = set()
	while i < len(rfs):
		inext = rfs.find("\n", i + span)
		if inext == -1:
			inext = len(rfs)
		line = rfs[i:inext]
		
		# filter lines which don't even have the prefix
		hasPrefix = False
		for prefix in prefices:
			if prefix in line:
				hasPrefix = True
				break
		if hasPrefix:
			for match in names:
				if match in line:
					match_name = match
					if match_name not in match_names:
						if match_name in checkNoSuffix:	
							if not re.search(match_name + "\\b", line):
								continue
						match_names.add(match_name)
		
		#nonprefixed lookup
		for match in unprefixed_names:
			if match in line:
				match_name = match
				if match_name not in match_names:
					match_names.add(match_name)
		i = inext
				
	edges = []
	for match_name in match_names:
		edge = (ref_name, match_name)
		edges.append(edge)
	return edges
	print("ERROR PROCESSING FILE " + ref_file)
	raise "ERROR"
			

def get_unreferenced_list(project_file):
	graph = {("^root", "^root")} # set
	names = []
	unprefixed_names = []
	
	#build referencer corpus
	dir = os.path.dirname(project_file)
	
	# check each resource for if it is referenced
	print()
	print("Compositing resources...", flush=True)
	with open(project_file, "r") as projf:
		s = projf.read();
		for line in s.splitlines(False):
			match = lineRegex.match(line)
			if match:
				match_type = match.group(2)
				match_name = no_extension(match.group(3))
				hasPrefix = False
				for prefix in prefices:
					if match_name.startswith(prefix):
						hasPrefix = True
						break
				if hasPrefix:
					names.append(match_name)
				else:
					unprefixed_names.append(match_name)
				
				if match_type == "room":
					graph.add(("^root", match_name))
	names.sort()
	unprefixed_names.sort()

	print("Dividing labour...", flush=True)
	works = []
	for type in srcTypes:
		typedir = os.path.join(dir, type + "s")
		for filename in os.listdir(typedir):
			ref_file = os.path.join(typedir, filename)
			ref_name = no_extension(filename)
			if os.path.isfile(ref_file):
				works.append((ref_file, ref_name, names, unprefixed_names, graph))
	
	print("Launching threads...", flush=True)
	
	with mp.Pool(max(1, int(mp.cpu_count() / 1.5))) as tpe:
		results = [tpe.apply_async(check_file_for_references, args=work) for work in works]
		
		print("Waiting for threads to join... (If this line hangs, use the Windows command line.)", flush=True)
		
		print("Aggregating reference graph...")
		for edges in results:
			for edge in edges.get():
				graph.add(edge)
	
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

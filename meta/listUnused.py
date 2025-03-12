usage = """
./listUnused.py <path/to/some.project.gmx>

Applies to Game Maker Studio 1 files only.
"""

import sys
import re
import os
checkParent = re.compile("<parentName>([a-zA-Z_0-9]*)</parentName>")
checkFile = re.compile("([a-zA-Z_0-9]*)\.object\.gmx")

types = ["script", "sprite", "object", "background"]

def no_extension(str):
	while True:
		split = os.path.splitext(str)
		if len(split) < 2:
			return str
		if split[1] == "":
			return str
		str = split[0]
		

def main(project_file):
	with open(project_file, "r") as projf:
		s = projf.read().lower();
		dir = os.path.dirname(project_file)
		for type in types:
			print()
			print("### " + type + " ###")
			if type == "background":
				typedir = type + "\\"
			else:
				typedir = type + "s\\";
			typeEntryBase = "<" + type + ">" + typedir
			_typedir = os.path.join(dir, typedir)
			for filename in os.listdir(_typedir):
				if os.path.isfile(os.path.join(_typedir, filename)):
					resourceName = no_extension(filename)
					searchLine = typeEntryBase + resourceName
					if searchLine.lower() not in s:
						print(resourceName)
	
if len(sys.argv) == 2:
	main(sys.argv[-1])
else:
	print(usage)
#<parentName>prtAlwaysActive</parentName>

usage = """
./listAncestors.py [base parents...] <GM objects/ directory>

Applies to Game Maker Studio 2 object files only.
"""

import sys
import re
import os

checkParent = re.compile("<parentName>([a-zA-Z_0-9]*)</parentName>")
checkFile = re.compile("([a-zA-Z_0-9]*)\.object\.gmx")

def main(base_parents, files,pdir,d=0):
	parents = set(base_parents)
	for fn in files:
		with open(fn,"r") as f:
			myName = checkFile.match(os.path.basename(fn)).group(1)
			head = "".join([next(f) for x in range(15)])
			m = checkParent.search(head)
			if m:
				prt = m.group(1)
				if prt in parents:
					parents.add(myName)
	
	if parents == base_parents:
		for parent in parents:
			print((pdir + parent + ".object.gmx").strip())
	else:
		main(parents,files,pdir,d+1)
			
	
if len(sys.argv) > 1:
	file_list = []
	pdir = sys.argv[-1]
	for fn in os.listdir(pdir):
		if os.path.isfile(os.path.join(pdir,fn)):
			file_list.append(os.path.join(pdir,fn))
	main(set(sys.argv[1:-1]),file_list,pdir)
else:
	print(usage)
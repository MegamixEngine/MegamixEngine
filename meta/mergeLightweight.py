usage = """
./mergeLightweight.py <path/to/some.project.gmx>

Applies to Game Maker Studio 1 files only.
"""

import sys
import re
import os
types = ["script", "sprite", "object", "background", "timeline", "room", "sound", "path"]
isResource = re.compile("\s*<(" + "|".join(types) + ")>(" + "|".join(types) + ")s?\\\\([^<.]*)(.gml)?</|\s*<constant name=.*")
isOpenFolder = re.compile("(\s*<)(" + "|".join(types) + ")s")
isCloseFolder = re.compile("(\s*<)/(" + "|".join(types) + ")s>")

def no_extension(str):
	while True:
		split = os.path.splitext(str)
		if len(split) < 2:
			return str
		if split[1] == "":
			return str
		str = split[0]
		
def insert_remainder_in(lfs_post, tree, at):
	str = lfs_post[0:at]
	remainder = ""
	while tree[0].strip() != "":
		str += tree[0]
		match = isOpenFolder.match(str)
		if match:
			remainder = match.group(1) + "/" + match.group(2) + "s>\n" + remainder
		tree = tree[1:]
	str += remainder + lfs_post[at:]
	return str
	
		
def insert_resource_in(lfs_post, tree, start, end, prevline):
	if tree[0].strip() == "":
		return lfs_post
	else:
		newstart = lfs_post.find("\n" + tree[0], start, end)
		if newstart != -1:
			# find end of region
			indent_end = tree[0][0: (tree[0].find("<")+1)]
			newend = lfs_post.find("\n" + indent_end, newstart + 1, end) + 1
			assert(newend != -1)
			return insert_resource_in(lfs_post, tree[1:], newstart, newend, prevline)
		else:
			# find insertion point (prefer to insert after where the previous line was in source
			at = end
			prev_find = lfs_post.find(prevline, start, end)
			if prev_find != -1:
				at = prev_find + len(prevline)
			return insert_remainder_in(lfs_post, tree, at)
			
		
def insert_resource(lfs_post, tree, prevline):
	return insert_resource_in(lfs_post, tree, 0, len(lfs_post), prevline)

def main(project_file, lightweight_file):
	lfs = ""
	with open(lightweight_file, "r") as lf:
		lfs = lf.read()
	with open(project_file, "r") as projf:
		pfs = projf.read()
	
	lfs_post = lfs
	
	#scan to end of datafiles
	dfe_tag = "\n  </datafiles>"
	dfe = lfs.find(dfe_tag)
	if dfe != pfs.find(dfe_tag):
		print("Datafiles mismatch -- please resolve before merging.")
		sys.exit(1)
	else:
		print("Note: datafiles will not be merged.")
		
	dfe = lfs.find("\n", dfe + 1)
	lfs = lfs[dfe:]
	pfs = pfs[dfe:]
	
	# tree structure so far in pfs
	tree = [""] * 100
	tree[0] = "<assets>"
	prevline = tree[0]
	for line in pfs.splitlines(True):
		if line.strip() == "":
			prevline += line
			continue
		indent_level = int(line.find("<") / 2)
		if indent_level <= 0:
			if line.startswith("</assets>"):
				break
			print("missing '<' on line: " + line)
			sys.exit(1)
		tree[indent_level] = line
		tree[indent_level + 1] = ""
		if isResource.match(line):
			if line in lfs:
				if isCloseFolder.match(line):
					prevline += line
				else:
					prevline = line
				continue
			else:
				print("inserting " + line.strip())
				lfs_post = insert_resource(lfs_post, tree, prevline)
		if isCloseFolder.match(line):
			prevline += line
		else:
			prevline = line
	return lfs_post
	
if len(sys.argv) >=2:
	file = sys.argv[1]
	base = os.path.basename(file)
	dir = os.path.dirname(file)
	if base.startswith("lw_"):
		base = base[3:]
	
	outs = main(os.path.join(dir, base), os.path.join(dir, "lw_" + base))
	if len(sys.argv) == 2:
		outf = os.path.join(dir, base)
	else:
		outf = sys.argv[2]
	with open(outf, "w") as of:
		of.write(outs)
else:
	print(usage)
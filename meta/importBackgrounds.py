#!/bin/usr/python3
# This script retrieves all the backgrounds.gmx and background images from another .gmx file
# but does not place them in the resource tree. It only copies in the files from the disk.
# usage: ./importBackgrounds.py <src project.gmx> <dst project.gmx> [<subdirectory/in/background/resource/tree>]

import sys
import os
import xml.etree.ElementTree as ET
from shutil import copy
from shutil import copyfile

def usage():
	print("usage: " + sys.argv[0] + " <src project.gmx> <dst project.gmx> [<subdirectory/in/background/resource/tree>]")
	
def importBackground(src,dst):
	copy(src,dst)
	print("copying " + src + " to " + dst)
	srcdoc = ET.parse(src).getroot()
	data = srcdoc.find("data")
	copyfile(os.path.join(os.path.dirname(src),data.text),os.path.join(dst,data.text))

def importFrom(src,dst,xml):
	for bg in xml.iter("background"):
		importBackground(os.path.join(src,bg.text + ".background.gmx"),os.path.join(dst,"background"))
	for child in xml.iter("backgrounds"):
		importFrom(src,dst,child);
	
def main(src,dst,subdir):
	srcdoc = ET.parse(src).getroot().find("backgrounds")
	
	subdir_init = subdir;
	
	# navigate to place in resource tree
	while len(subdir) > 0:
		prev_srcdoc = srcdoc
		for child in srcdoc.iter("backgrounds"):
			if child.get("name") == subdir[0]:
				srcdoc = child
				subdir = subdir[1:]
				print("-> " + child.get("name"))
				break
		if srcdoc == prev_srcdoc:
			break
	
	if subdir != []:
		print("Error: could not find resource tree subdirectory \"" + "/".join(subdir_init[0:len(subdir_init)-len(subdir) + 1]) + "\"")
	else:
		importFrom(os.path.dirname(src),os.path.dirname(dst), srcdoc)
	pass;

if len(sys.argv) < 3 or len(sys.argv) > 4:
	usage()
else:
	subdir = [];
	if len(sys.argv) == 4:
		subdir = sys.argv[3].split("/")
	main(sys.argv[1], sys.argv[2], subdir)
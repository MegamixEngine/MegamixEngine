#!/bin/usr/python3
# This script removes one instance of all duplicate tags according to their text

import sys
import os
import re
from collections import defaultdict

backgrounds = defaultdict()
background_regex = re.compile("(<" + sys.argv[2] + ">.*</" + sys.argv[2] + ">\n)",re.MULTILINE)

def usage():
	print("usage: " + sys.argv[0] + " src tag")
	
def main(gmx):
	n = 0;
	with open(gmx,"r+") as gmf:
		s = gmf.read()
		for match in background_regex.finditer(s):
			mg = match.group(1)
			backgrounds[mg] = backgrounds.get(mg, 0) + 1
			if backgrounds[mg] > 1:
				# replace last instance of string:
				s = (s[::-1].replace(mg[::-1],"",1))[::-1]
				print(mg)
				n += 1;
	
		print (str(n) + " duplicates removed.")
		gmf.seek(0);
		gmf.write(s);
		gmf.truncate()
		print ("Wrote to " + gmx)

if len(sys.argv) != 3:
	usage()
else:
	main(sys.argv[1])
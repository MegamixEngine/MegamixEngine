from os import walk
import os
import sys;
import string;
from itertools import chain
cnt = "";

vars = set()

paths = ["objects/", "scripts/"]
type = "-assign"

if (len(sys.argv) == 3):
    pathTo = sys.argv[1]
    type = sys.argv[2]
else:
    print("USAGE: " + sys.argv[0] + " directory type")
    print("type can be -assign -read -assigna -reada")
    sys.exit();

sourcen = 0;

for (dirp, dirs, files) in chain.from_iterable(os.walk(os.path.join(pathTo, path)) for path in paths):
  for filename in files:
    cnt = ""
    with open(os.path.join(dirp, filename),encoding='utf8') as file:
      cnt = file.read();
      sourcen += 1

    import re

    rx = re.compile(r"[ \t]*((global.)?[a-zA-Z_][a-zA-Z0-9_]*)(\[.*\])? *=")

    for match in rx.finditer(cnt):
      var = match.group(1)
      vars.add(var)

vars = vars - set(["vs", "true", "false", "val", "var", "other", "argument", "bbox_bottom", "bbox_top", "bbox_left", "bbox_right", "id", "argument_count", "object_index","_____i_____", "_____j_____", "_____vs_____", "_____val_____"]) - set (["argument" + str(i) for i in range (0,17)])
  
varl = sorted(list(vars))

code = """/// setInstanceVariable(varstring, value)
/// sets the instance variable in the current scope given by varstring
/// to be the given value. Returns true if success.

var _____vs_____ = argument0;
var _____val_____ = argument1;
"""

if type == "-read":
    code = """/// getInstanceVariable(varstring)
/// retrieves the value of the instance variable in the current scope
/// given by varstring. Returns true if success.

var _____vs_____ = argument0;
"""

if type == "-assigna":
    code = """/// setInstanceVariableArray(varstring, val, i, j)
/// sets the instance array at index [i, j] to the value provided.
/// returns true if success.

var _____vs_____ = argument0;
var _____val_____ = argument1;
var _____i_____ = argument2;
var _____j_____ = argument3;
"""

if type == "-reada":
  code = """/// getInstanceVariableArray(varstring, i, j)
/// retrives the instance array at index [i, j].
/// returns true if success
var _____vs_____ = argument0;
var _____i_____ = argument1;
var _____j_____ = argument2;
"""
code += "\n"
code += """/// THIS SCRIPT WAS GENERATED AUTOMATICALLY
/// VIA strexec_varsearch.py. 
/// DO NOT EDIT BY HAND!

/// Stats:
/// """ + str(len(varl)) + """ variables
/// from """ + str(sourcen) + """ source files

if (_____vs_____ == "") return false;
"""

alphabet = string.ascii_letters + string.digits + "_"

for a in alphabet:
    tcode = "else if (stringStartsWith(_____vs_____, '" + a + "'))\n{\n    if (_____vs_____ == \"\") return false;\n"
    any = False
    for var in varl:
        if var[0] == a:
            any = True
            tcode += "    else if (_____vs_____ == \"" + var + "\") "
            if type == "-assign":
                tcode += var + " = _____val_____;\n"
            if type == "-read":
                tcode += "global.retval = " + var + ";\n"
            if type == "-assigna":
                tcode += var + "[_____i_____, _____j_____] = _____val_____;\n"
            if type == "-reada":
                tcode += "global.retval = " + var + "[_____i_____, _____j_____];\n"
    tcode += "    else return false;\n"
    tcode += "}\n"
    if any:
        code += tcode

code += """

// success
return true;

//@noformat
"""

print (code)

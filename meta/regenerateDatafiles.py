#!/bin/usr/python3
# This script edits the project.gmx datafile section
# to be up-to-date with the file system.

import sys
import os
import xml.etree.ElementTree as ET

gmx_file = '../MegamixEngine.project.gmx'
datafiles_directory = "../datafiles"
nl = "\n" # line end

def error(what):
    print("ERROR:", what)
    sys.exit(1)

contents = ""
with open(gmx_file, 'r') as f:
  contents = f.read()

if len(contents) < 0:
    error("reading file")

datafiles_start = contents.find("<datafiles number=")
datafiles_end = contents.rfind("</datafiles>") + len("</datafiles>") + len(nl)

if datafiles_start == -1 or datafiles_end == -1:
    error("finding datafiles section in " + gmx_file)
    
def make_indent(n):
    return "  " * n
    
# a string unlikely to appear anywhere else
numrep = "____//++_\\_?? __ll"
    
def datafile_gmx_generate(path, indentn):
    # returns gmx string for a given datafile
    indent = make_indent(indentn)
    indent2 = make_indent(indentn + 1)
    
    # data to store in gmx
    filename = os.path.basename(path)
    size = str(os.path.getsize(path))
    
    # generate string
    s = indent + "<datafile>" + nl
    
    # name
    s += indent2 + "<name>" + filename + "</name>" + nl
    
    # exists (unknown use)
    s += indent2 + "<exists>-1</exists>" + nl
    
    # size
    s += indent2 + "<size>" + size + "</size>" + nl
    
    # export action (unknown use)
    s += indent2 + "<exportAction>2</exportAction>" + nl
    
    # export directory (unknown use)
    s += indent2 + "<exportDir></exportDir>" + nl
    
    # overwrite (unknown use)
    s += indent2 + "<overwrite>0</overwrite>" + nl
    
    # free data (unknown use)
    s += indent2 + "<freeData>-1</freeData>" + nl
    
    # remove end (unknown use)
    s += indent2 + "<removeEnd>0</removeEnd>" + nl
    
    # store (unknown use)
    s += indent2 + "<store>0</store>" + nl
    
    # config (unknown use)
    s += make_indent(indentn + 1) + "<ConfigOptions>" + nl
    s += make_indent(indentn + 2) + "<Config name=\"Default\">" + nl
    s += make_indent(indentn + 3) + "<CopyToMask>9223372036854775807</CopyToMask>" + nl
    s += make_indent(indentn + 2) + "</Config>" + nl
    s += make_indent(indentn + 1) + "</ConfigOptions>" + nl
    
    # filename
    s += indent2 + "<filename>" + filename + "</filename>" + nl
    
    s += indent + "</datafile>" + nl
    
    return s
    
def datafile_directory_gmx_generate(directory, indentn=1):
    # returns gmx string for given directory
    indent = make_indent(indentn)
    s = ""
    num_files = 0
    rootname = os.path.basename(directory)
    for path in os.listdir(directory):
        path = os.path.join(directory, path)
        print(indent, path)
        if os.path.isdir(path):
            # subdirectory
            (n, z) = datafile_directory_gmx_generate(path, indentn + 1)
            num_files += n
            s += z
        else:
            # file
            num_files += 1
            s += datafile_gmx_generate(path, indentn + 1)
    header = indent + "<datafiles number=\"" + numrep \
        + "\" name=\"" + rootname + "\">" + nl
    s += indent + "</datafiles>" + nl
    return (num_files, header + s)
    
with open(gmx_file, "w") as out:
    (num_files, s) = datafile_directory_gmx_generate(datafiles_directory)
    s = s.replace(numrep, str(num_files))
    s = contents[:datafiles_start] \
         + s \
         + contents[datafiles_end:]
    out.write(s)
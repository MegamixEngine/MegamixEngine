#!/usr/bin/env python3

# Given a coloured spritesheet, decomposes into layers.
# Usage: ./whitemask.py src.png primary secondary outline eyewhite <out>
# primary, secondary, etc. are hex colour values for the primary, secondary, and outline colours.
# outputs to <out>_0.png, <out>_1.png, etc.

# Example: ./whitemask.py sprRockman.png 0070ec 00e8d8 000000 ffffff sprRockman

# 0: full colour
# 1: primary colour
# 2: secondary
# 3: outline
# 4: eyewhites

from PIL import Image
import sys
import struct
import numpy

if len(sys.argv) != 7:
  print("Incorrect number of arguments (" + str(len(sys.argv)-1) + " provided; 6 expected)")
  sys.exit()

imgfile = sys.argv[1]
primary = sys.argv[2]
secondary = sys.argv[3]
outline = sys.argv[4]
eyewhite = sys.argv[5]
outfile = sys.argv[6]
borders = "skinborders.png"

image = Image.open(imgfile)
borders_image = Image.open(borders)
image_data_list = [0]*5
for i in range(0, 5):
  image_data_list[i] = image.copy()
  
cols = [primary, secondary, outline, eyewhite]
  
for i in range(5):
  image_data = list(image_data_list[i].convert('RGBA').getdata())
  image_data = image_data
  if (i != 0):
    colstr = cols[i-1]
    while len(colstr) < 8:
      colstr = colstr + "f";
    col = struct.unpack('BBBB', bytes.fromhex(colstr));
    for j in range(0, len(image_data)-1):
      if (image_data[j] == col):
        image_data[j] = (255, 255, 255, 255)
      else:
        image_data[j] = (0, 0, 0, 0)
  oname = outfile + "_" + str(i) + ".png"
  print("saving to " + oname)
  img = image.copy()
  img.putdata((image_data))
  img.paste(borders_image, (0, 0), borders_image)
  img.save(oname)

print("Colours:")
for col in image.getcolors():
  print(str(col[1]) + ": " + str(col[0]) + " instances")
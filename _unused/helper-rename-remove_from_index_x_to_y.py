#!/usr/bin/env python3
import sys
import os

mypath = './'
#files = [ f for f in os.listdir( os.curdir ) if os.path.isfile(f) ] # files only
files = os.listdir(os.curdir) #files and folder
if len(sys.argv) == 1:
	print('usage: <filename> <x> <y>')
	sys.exit()
for file in files:
	if file == os.path.basename(__file__):
		continue
	start = int(sys.argv[1])
	end = int(sys.argv[2])
	if (start >= 0) and (end >= start):
		os.rename(file, file[:start] + file[end + 1:])

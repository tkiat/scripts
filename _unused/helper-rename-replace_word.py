#!/usr/bin/env python3
import sys
import os

mypath = './'
#files = [ f for f in os.listdir( os.curdir ) if os.path.isfile(f) ] # files only
files = os.listdir(os.curdir) #files and folder
if len(sys.argv) < 4:
	print('arguments: <old word> <new word> <number of occurence>')
	sys.exit()
for file in files:
	if file == os.path.basename(__file__):
		continue
	os.rename(file, file.replace(sys.argv[1], sys.argv[2], int(sys.argv[3])))

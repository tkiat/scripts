#!/usr/bin/env python3
import sys
import os

mypath = './'
#files = [ f for f in os.listdir( os.curdir ) if os.path.isfile(f) ] # files only
files = os.listdir(os.curdir) #files and folder
if len(sys.argv) < 2:
	print('arguments: <text> <index>')
	sys.exit()
for file in files:
	if file == os.path.basename(__file__):
		continue
	text = sys.argv[1]
	index = int(sys.argv[2])
	os.rename(file, file[0:index] + text + file[index:])

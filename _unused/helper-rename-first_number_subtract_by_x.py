#!/usr/bin/env python3
import sys
import os
import re
def subtract_first_int(num, digit):
	return str(num - digit)
	# return str(10 ** digit + num)[-digit:]

mypath = './'
#files = [ f for f in os.listdir( os.curdir ) if os.path.isfile(f) ] # files only
files = os.listdir(os.curdir) #files and folder
if len(sys.argv) < 2:
	print('arguments: <number to subtract>')
	sys.exit()
for file in files:
	if file == os.path.basename(__file__):
		continue
	last_dot_index = file.rfind('.')
	file_no_ext = file if last_dot_index == -1 else file[0:last_dot_index]
	ext = '' if last_dot_index == -1 else file[last_dot_index:]
	os.rename(file, re.sub('(\-?\d+)', lambda m: subtract_first_int(int(m.group(0)), int(sys.argv[1])), file_no_ext, 1) + ext)

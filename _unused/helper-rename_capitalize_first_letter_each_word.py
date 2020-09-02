#!/usr/bin/env python3
import sys
import os
import re

articles = 'a,an,the'
prepositions = 'of,into,for,with,on,at,from,by,about,as,in,to,like,through,after,over,between,out,against,during,without,before,under,around,among'

exceptions = (articles + ',' + prepositions).split(',')
mypath = './'
#files = [ f for f in os.listdir( os.curdir ) if os.path.isfile(f) ] # files only
files = os.listdir(os.curdir) #files and folder
for file in files:
	if file == os.path.basename(__file__):
		continue
	last_dot_index = file.rfind('.')
	file_no_ext = file if last_dot_index == -1 else file[0:last_dot_index]
	ext = '' if last_dot_index == -1 else file[last_dot_index:]
	os.rename(file, re.sub('([a-zA-Z]+)', lambda m: m.group(0) if m.group(0) in exceptions else m.group(0).capitalize(), file_no_ext) + ext)

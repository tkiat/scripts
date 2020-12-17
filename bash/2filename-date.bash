#!/usr/bin/env bash
for filename in $@
do
	newname=$(date -d @$(stat --printf="%Y" $filename) +"%Y_%m_%d-%H_%M_%S")
	mv $filename $newname.$(echo $filename | cut -d '.' -f 2)
done

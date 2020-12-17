#!/usr/bin/env bash
FORMAT=ogg
for filename in *.flac
do
	# ext=$(echo $filename | awk 'BEGIN { FS = "." } ; {print $(NF)}')
	name=$(echo $filename | cut -d '.' -f 1)

	case $FORMAT in
		ogg)
			ffmpeg -i $filename -b:a 192k "$name.ogg"
			;;

		*)
			echo -n "Unknown Format"
			;;
	esac
done

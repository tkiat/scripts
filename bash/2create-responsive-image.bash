#!/usr/bin/env bash
filename_and_ext="${1##*/}"
filename="${filename_and_ext%%.*}"
ext="${filename_and_ext#*.}"

read w h <<< $(identify -format '%w %h' $1)
if [ $(($w % $2)) -eq "0" ] && [ $(($h % $2)) -eq "0" ]; then
	let stepW=$(($w / $2))
	let stepH=$(($h / $2))
	let cur=1
	for i in $(seq 1 $2); do
		convert $1 -resize $(($stepW * $i))x$(($stepH * $i)) ${filename}-$(($stepW * $i))x$(($stepH * $i)).${ext}
	done
	# rm $1
	# display img tag
	source="https://www.dummy.com"
	noob=""
	for i in $(seq 1 $2); do
		noob="$noob
$source/$filename-$(($stepW * $i))x$(($stepH * $i)).$ext $(($stepW * $i))w"
		if [ $i -ne $2 ]; then
			noob="$noob,"
		else
			noob="$noob\"";
		fi
	done
	cat<<-EOF
	<img srcset="$noob
		sizes="(max-width: $(($w + 100))px) 70vw,
		${w}px"
		src="${source}/${filename}-${w}x${h}.${ext}"
		alt="&lt;img2&gt;">
	EOF
else
	echo "cannot resize image: width or height are not divisible by $2"
fi

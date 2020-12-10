#!/usr/bin/env bash
# for filename in *.pdf
for filename in IMAG*
# for i in {0..6}
do
# filename="noob-$i.jpg"
convert $filename -strip -interlace Plane -gaussian-blur 0.05 -quality 70% temp && mv temp $filename
# ffmpeg -i $filename -crf 30 "temp$filename" && mv "temp$filename" $filename
# gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dNOPAUSE -dQUIET -dBATCH -sOutputFile=temp $filename && mv temp $filename
done

#!/usr/bin/env bash
for filename in *.pdf
# for filename in *
# for i in {0..6}
do
# filename="noob-$i.jpg"
# convert $filename -strip -interlace Plane -gaussian-blur 0.05 -quality 10% temp && mv temp $filename
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dNOPAUSE -dQUIET -dBATCH -sOutputFile=temp $filename && mv temp $filename
done

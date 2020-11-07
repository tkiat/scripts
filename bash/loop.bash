#!/usr/bin/env bash
for i in {1..4}
do
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dNOPAUSE -dQUIET -dBATCH -sOutputFile=temp "Chapter-$i.pdf" && mv temp "Chapter-$i.pdf"
done

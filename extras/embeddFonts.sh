#!/usr/bin/bash

F=$1

gs -sFONTPATH=/Library/Fonts:~/Library/Fonts -o ${F::${#F}-4}-with-embedded-fonts.pdf -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress $F

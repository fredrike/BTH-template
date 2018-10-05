gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dDownsampleColorImages=true -dColorImageResolution=300 -dNOPAUSE -dQUIET -dBATCH -dCompressFonts=true -sOutputFile=${1%.*}-compressed.pdf ${1%.*}.pdf 

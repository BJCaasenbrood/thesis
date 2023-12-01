#!/bin/bash
# compress pdf

echo Compressing thesis.pdf ...

gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer -dNOPAUSE -dBATCH -sOutputFile=thesis_redux.pdf foo.pdf

echo Done thesis.pdf ...


#!/bin/bash
# compress pdf

echo Compressing pdf figure...

gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/printer -dNOPAUSE -dBATCH -sOutputFile=out.pdf in.pdf

echo Done... Written output.pdf!


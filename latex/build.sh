#!/bin/bash
#mkdir build
pdflatex -shell-restricted -output-directory=build -synctex=1 -enable-write18 -extra-mem-bot=100000000 -extra-mem-top=100000000 thesis.tex

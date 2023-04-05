#!/bin/bash
pdflatex -draftmode thesis
bibtex file # or biber
makeindex thesis.idx # if needed
makeindex -s style.gls ...# for glossary if needed
pdflatex -draftmode thesis
pdflatex thesis

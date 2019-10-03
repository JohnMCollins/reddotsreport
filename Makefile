# Makefile for draft paper

DOCNAME=report

include $(HOME)/lib/latex.mk

tabs:
	listobjects.py --cut 5.2 --lat --dith -1 --noundef >tables/totalobs.tex
	listobjects.py --cut 4.9 --lat --noundef >tables/totalvis.tex
	listfilts.py --lat >tables/totalfilt.tex

pngimages:
	datedisp.py --width 12 --height 10 --marker=. --outfig images/visobstot.png


# Generic makefile for processing Beamer files
# 
# Thomas Neidhart
# January 2013

BASE	= presentation

FIGURES =
PDFLATEX_OPTIONS = --file-line-error -interaction nonstopmode --shell-escape

all: $(BASE).pdf

$(BASE).pdf: $(BASE).tex $(FIGURES)
	@(\
	AUX=$(BASE).aux; \
	if [ ! -f $$AUX ]; then pdflatex $(PDFLATEX_OPTIONS) $(BASE); fi; \
	pages1=`sed -n '/inserttotalframenumber/{ s/[^0-9]//g; p; }' < $$AUX`; \
	pdflatex $(PDFLATEX_OPTIONS) $(BASE); \
	pages2=`sed -n '/inserttotalframenumber/{ s/[^0-9]//g; p; }' < $$AUX`; \
	if [ $$pages1 -ne $$pages2 ]; then pdflatex $(PDFLATEX_OPTIONS) $(BASE); fi; \
	)
	
.PHONY: clean

clean:
	rm -f *.aux *.log *.nav *.out *.pdf *.snm *.toc *.vrb
	rm -rf _minted-presentation


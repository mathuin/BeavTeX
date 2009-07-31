
LATEX=`which latex`
DVIPS=`which dvips`
BIBTEX=`which bibtex`
PS2PDF=`which ps2pdf`


###################################
#
#  List all the files you use here.
#
TEX_FILES= content/abstract.tex content/acknowl.tex \
	content/appendix1.tex content/body.tex content/prematter.tex \
	content/mydefs.tex content/thesis.bib content/myusepkgs.tex \
	osuthesis.cls thesis.tex 

IMAGES= 

default: thesis

thesis: thesis.ps thesis.pdf

thesis.ps: thesis.dvi
	$(DVIPS) -Ppdf thesis.dvi -o thesis.ps -t letter

thesis.dvi: $(TEX_FILES) $(IMAGES)
	$(LATEX) thesis.tex
	$(BIBTEX) thesis
	$(LATEX) thesis.tex
	$(LATEX) thesis.tex

thesis.pdf: thesis.dvi
#	/usr/local/apps/teTeX-1.0/bin/sun/dvips -P pdf -t letter thesis.dvi -o thesis.ps
	$(DVIPS) -Ppdf thesis.dvi -o thesis.ps -t letter
	$(PS2PDF) -dAutoRotatePages=/All thesis.ps
#	$(DVIPS) thesis.dvi -o thesis.ps
#	/usr/local/apps/bin/distill -embedallfonts on -subsetfonts on -compresstext off -colordownsample off -colorres 1200 -colordepth -1 -colorcompr zip -coloracs off thesis.ps


clean: 
	rm thesis.dvi thesis.ps thesis.pdf thesis.blg thesis.loa thesis.lof thesis.log thesis.lot thesis.toc thesis.bbl thesis.aux

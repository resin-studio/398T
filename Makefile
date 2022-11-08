# Build LaTeX outputs

BASE_NAME = lecture

SHELL = /bin/sh
LATEX = pdflatex

TEX_SRCS := $(wildcard *.tex)

all:	$(BASE_NAME).pdf

$(BASE_NAME).pdf:	$(TEX_SRCS)
	if test ! -f $(BASE_NAME).aux; then $(LATEX) $(BASE_NAME).tex; fi
	if text -f $(BASE_NAME).idx; then $(MAKE) $(BASE_NAME).ind; fi
	$(LATEX) $(BASE_NAME).tex

ifdef BIB_NAME
  $(BASE_NAME).pdf:	$(BASE_NAME).bbl
endif

$(BASE_NAME).bbl:	$(BIB_NAME).bib
	if test ! -f $(BASE_NAME).aux; then $(LATEX) $(BASE_NAME).tex; fi
	bibtex $(BASE_NAME)
	$(LATEX) $(BASE_NAME).tex

CLEAN_FILES := $(BASE_NAME).pdf \
	$(wildcard *.log *.aux *.toc *.lof *.out *.nav *.snm) \
	$(wildcard *.bbl *.blg *.ind *.idx *.ilg)

clean:
	-rm $(CLEAN_FILES)

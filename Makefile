link:
	ln -s cv.pdf vashevko-cv.pdf

cv:
	make cv.pdf
	cp cv.pdf vashevko-cv.pdf

references: cv.md references-template.tex
	pandoc -r markdown -t latex -o references.pdf \
	    --latex-engine=lualatex \
	    --template=references-template.tex \
	    $<

publist: cv.md publist-template.tex
	pandoc -r markdown -t latex -o publist.pdf \
	    --latex-engine=lualatex \
	    --template=publist-template.tex \
	    $<

%.pdf: %.md cv-template.tex
	pandoc -r markdown -t latex -o $@ \
	    --latex-engine=lualatex \
	    --template=cv-template.tex \
	    $<

%.tex: %.md cv-template.tex
	pandoc -r markdown -t latex -o $@ \
	    --latex-engine=lualatex \
	    --template=cv-template.tex \
	    $<

.PHONY: cv

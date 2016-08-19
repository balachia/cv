link:
	ln -s cv.pdf vashevko-cv.pdf

cv:
	make cv.pdf

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

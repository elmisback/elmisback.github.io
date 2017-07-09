MD = markdown

ORDER = -
.SUFFIXES: .html .md

.md.html:
	${MD} < $< | cat ${ORDER} > $@

all:
	ls -1 *.md | sed 's/.md$$/.html/' | xargs make

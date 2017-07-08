MD = markdown
MDFLAGS =
ORDER = header.html - footer.html

.SUFFIXES: .html .md

.md.html:
	${MD} ${MDFLAGS} $< | cat ${ORDER} >$@

all:
	ls -1 *.md | sed 's/.md$$/.html/' | xargs make

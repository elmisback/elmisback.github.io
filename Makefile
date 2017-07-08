MD = markdown
MDFLAGS =
ORDER = header.html - footer.html

.SUFFIXES: .html .md
DEFAULT: all

.md.html:
	${MD} ${MDFLAGS} <$< | cat ${ORDER} >$@

clean:
	rm index.html

all:
	ls -1 *.md | sed 's/.md$$/.html/' | xargs make

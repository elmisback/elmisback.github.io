MD = markdown
ORDER = -
.SUFFIXES: .html .md
.PHONY: html git

.md.html:
	${MD} < $< | cat ${ORDER} > $@

all: html

html:
	ls -1 *.md | sed 's/.md$$/.html/' | xargs make

deploy:
	git add -A
	git commit
	git push

watch:
	python3 -m http.server &
	inotifywait -m -e modify -r . | while read line; do make; done

MD = markdown
ORDER = header.html - footer.html
.SUFFIXES: .html .md
.PHONY: html git clean

.md.html:
	${MD} < $< | cat ${ORDER} > $@

all: html

html:
	ls -1 *.md | sed 's/.md$$/.html/' | xargs make

clean:
	rm index.html
	rm links.html

deploy:
	git add -A
	git commit
	git push

watch:
	python3 -m http.server &
	inotifywait -m -e modify -r . | while read line; do make; done

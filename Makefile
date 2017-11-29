MD = pandoc --ascii --smart
ORDER = header.html announcements.html - footer.html
.SUFFIXES: .html .md
.PHONY: html deploy clean

all: html

announcements.html: announcements.md announcements-footer.html
	${MD} $< | cat - announcements-footer.html > $@

%.html: %.md header.html announcements.html footer.html
	${MD} < $< | cat ${ORDER} > $@

html:
	find . -name "*.md" | sed 's/.md$$/.html/' | xargs make

clean:
	rm index.html
	rm links.html
	rm announcements.html
	rm content/*.html

deploy:
	git add -A
	git commit
	git push

watch:
	python3 -m http.server &
	inotifywait -m -e modify -r . | while read line; do make; done

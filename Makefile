PANDOC=pandoc --ascii --smart
.SUFFIXES: .html .md
.PHONY: html deploy clean

all: html

announcements.html: announcements.md announcements-footer.html
	${PANDOC} $< | cat - announcements-footer.html > $@

%.html: %.md header.html announcements.html footer.html
	${PANDOC} $< -c /blog.css -B header.html -B announcements.html \
	  -A footer.html -o $@

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

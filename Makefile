buildtop:
	gitbook build

build:
	sh -c 'cd ja && gitbook build'
	cp -f -R ja/_book/ _book/ja/
	find _book/ -name '*.md' | xargs rm

preview: build
	ruby -run -e httpd -- _book -p 8080

deploy: build
	git checkout gh-pages
	git pull --rebase origin gh-pages
	cp -f -R _book/* .
	git add .
	git commit -m "Deployed: $$(date)"
	git push origin gh-pages
	git checkout master

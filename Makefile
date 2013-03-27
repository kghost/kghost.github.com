#! /usr/bin/make

SOURCE=$(wildcard source/*.asciidoc)

all: _sites

_posts:
	mkdir -p _posts

_posts/%.html: source/%.asciidoc _posts
	TMP="`mktemp`" ; cp "$<" "$${TMP}" && asciidoc -b blogger -o "$@" "$${TMP}"

_sites: $(patsubst source/%.asciidoc,_posts/%.html,$(SOURCE))
	jekyll --no-server --no-auto

publish: all
	rsync --delete -ae ssh _site/ kghost.info:/srv/www/jekyll

.PHONY: all _sites


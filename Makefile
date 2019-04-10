#! /usr/bin/make

SOURCE=$(wildcard source/*.asciidoc)

all: _sites

_posts/stamp:
	mkdir -p _posts
	touch _posts/stamp

_posts/%.html: source/%.asciidoc _posts/stamp
	asciidoc -b blogger -o "$@" "$<"

_sites: $(patsubst source/%.asciidoc,_posts/%.html,$(SOURCE))
	jekyll build

_sites_safe: $(patsubst source/%.asciidoc,_posts/%.html,$(SOURCE))
	jekyll --safe build

publish: _sites_safe
	rsync --delete -ae ssh _site/ kghost.info:/srv/www/jekyll

.PHONY: all _sites _sites_safe


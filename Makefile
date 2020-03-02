SHELL=/bin/bash

all: dist

dist: javacomplete2/Makefile snipmate/Makefile
	@$(MAKE) -C supertab
	@$(MAKE) -C findAndroidManifest
	@$(MAKE) -C javacomplete2
	@$(MAKE) -C snipmate
	@$(MAKE) -C adbLogCat

javacomplete2/Makefile: Javacomplete2.makefile
	@cp $< $@

snipmate/Makefile: Snipmate.makefile
	@cp $< $@

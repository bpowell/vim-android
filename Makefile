SHELL=/bin/bash

all: dist

dist:
	cd supertab; make
	cd findAndroidManifest; make
	cp Javacomplete.makefile javacomplete/Makefile; cd javacomplete; make
	cp Snipmate.makefile snipmate/Makefile; cd snipmate; make
	cd adbLogCat; make

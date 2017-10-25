SHELL=/bin/bash

all: dist

dist:
	cd supertab; make
	cd findAndroidManifest; make
	cp Javacomplete2.makefile javacomplete2/Makefile; cd javacomplete2; make
	cp Snipmate.makefile snipmate/Makefile; cd snipmate; make
	cd adbLogCat; make

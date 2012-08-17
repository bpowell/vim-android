SHELL=/bin/bash

all:dist

dist:
	@rm snipmate.vmb 2> /dev/null || true
	@vim -c 'r! find after autoload doc ftplugin plugin snippets syntax -type f' \
		-c '$$,$$d _' -c '%MkVimball snipmate . ' -c 'q!'

clean:
	@rm -R build 2> /dev/null || true

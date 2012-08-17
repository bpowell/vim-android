SHELL=/bin/bash

all:dist

dist:
	@rm findmanifest.vmb 2> /dev/null || true
	@vim -c 'r! find doc after -type f' \
		-c '$$,$$d _' -c '%MkVimball findmanifest . ' -c 'q!'

clean:
	@rm -R build 2> /dev/null || true

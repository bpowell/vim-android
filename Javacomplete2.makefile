SHELL=/bin/bash

all:dist

dist:
	@rm javacomplete.vmb 2> /dev/null || true
	@vim -c 'r! find doc autoload -type f' \
		-c '$$,$$d _' -c '%MkVimball javacomplete . ' -c 'q!'

clean:
	@rm -R build 2> /dev/null || true

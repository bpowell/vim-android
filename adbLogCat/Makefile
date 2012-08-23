SHELL=/bin/bash

all:dist

dist:
	@rm adblogcat.vmb 2> /dev/null || true
	@vim -c 'r! find doc plugin -type f' \
		-c '$$,$$d _' -c '%MkVimball adblogcat . ' -c 'q!'

clean:
	@rm -R build 2> /dev/null || true

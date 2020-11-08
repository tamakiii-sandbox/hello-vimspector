.PHONY: help setup dependencies build bash attach clean

NAME := tamakiii-sandbox/hello-vimspector

help:
	@cat $(firstword $(MAKEFILE_LIST))

setup: \
	dependencies \
	deps/vim \
	deps/vim-plug

dependencies:
	type docker > /dev/null

build: Dockerfile
	docker build -t $(NAME) .

bash:
	docker run -it --rm --cap-add=SYS_PTRACE --security-opt="seccomp=unconfined" -v $(PWD):/app -w /app $(NAME) $@

attach:
	docker exec -it $$(docker ps -qf ancestor=$(NAME)) bash

deps/vim:
	$(MAKE) deps/vim

deps/vim-plug:
	$(MAKE) deps/vim-plug

clean:
	docker image rm $(NAME)

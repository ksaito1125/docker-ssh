NAME=sshd
PWD=psswd
HOST=$(shell ip route | head -1 | cut -d' ' -f 3)
PRE=test
OPTS=

all:

build: Dockerfile
	docker build $(OPTS) -t $(NAME) . --build-arg ROOTPWD=$(PWD)
	touch $@

run: build
	$(MAKE) rm
	docker run -d -P --name $(PRE)_$(NAME) $(NAME)

rm:
	-docker rm -f $(PRE)_$(NAME)

clean:
	$(MAKE) rm
	-docker rmi $(NAME)
	-rm -f build

test: run
	ssh root@$(HOST) -p $(shell docker ps | grep $(PRE)_$(NAME) | cut -d':' -f 2 | cut -d'-' -f 1)

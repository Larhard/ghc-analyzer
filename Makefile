all: docker

docker:
	$(MAKE) -C docker

.PHONY: all
.PHONY: docker

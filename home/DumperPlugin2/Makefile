STACK ?= stack

all: install examples

install: build
	$(STACK) install

build:
	$(STACK) build

examples:
	$(MAKE) -C examples clean all 2>&1 | tee out.log

.PHONY: all
.PHONY: install
.PHONY: build
.PHONY: examples

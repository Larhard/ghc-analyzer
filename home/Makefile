all: build

clean:
	make -C ghc clean

build: ghc.configured
	make -C ghc -j5

ghc.configured: ghc.booted
	cd ghc && ./configure
	touch $@

ghc.booted: prereqs
	cd ghc && ./boot
	touch $@

prereqs: ghc/mk/build.mk

ghc/mk/build.mk: ghc/mk/build.mk.sample
	sed \
		-e 's/^#BuildFlavour = quick$$/BuildFlavour = quick/' \
		$< > $@

.PHONY: build
.PHONY: clean
.PHONY: prereqs

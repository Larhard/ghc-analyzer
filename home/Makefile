PREREQS = ghc/mk/build.mk

all: build

clean:
	$(RM) $(PREREQS)
	$(RM) *.ghc_status
	make -C ghc clean

build: configured.ghc_status
	make -C ghc -j5

configured.ghc_status: booted.ghc_status
	cd ghc && ./configure
	touch $@

booted.ghc_status: $(PREREQS)
	cd ghc && ./boot
	touch $@

ghc/mk/build.mk: ghc/mk/build.mk.sample
	sed \
		-e 's/^#BuildFlavour = quick$$/BuildFlavour = quick/' \
		$< > $@

.PHONY: build
.PHONY: clean
.PHONY: prereqs

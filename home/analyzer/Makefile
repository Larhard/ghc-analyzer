# vim: set noet :

GHC = ../ghc/inplace/bin/ghc-stage2
# GHC = ghc

GHCFLAGS = -package ghc
# GHCFLAGS += -fplugin DumperPlugin
GHCFLAGS += -ddump-simpl -dsuppress-idinfo -dsuppress-coercions -dsuppress-type-applications -dsuppress-uniques -dsuppress-module-prefixes

all: clean example

update_dumper:
	$(MAKE) -C ../DumperPlugin/

%: %.hs
	$(GHC) $(GHCFLAGS) $< 2>&1

clean:
	$(RM) *.hi *.o
	$(RM) example
	$(RM) Parser

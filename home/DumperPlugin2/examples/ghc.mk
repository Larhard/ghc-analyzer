GHC ?= stack ghc --
GHCFLAGS ?=

%: %.hs
	$(GHC) $(GHCFLAGS) $<

clean::
	$(RM) *.hi
	$(RM) *.o

.DEFAULT_GOAL := all

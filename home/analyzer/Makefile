# vim: set noet :

GHC = ghc
GHCFLAGS = -package ghc

all: Parser

%: %.hs
	$(GHC) $(GHCFLAGS) $<

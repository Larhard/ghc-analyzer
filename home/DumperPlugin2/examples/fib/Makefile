include ../ghc.mk

GHCFLAGS = -fplugin DumperPlugin2

all: fib

%: %.hs
	$(GHC) $(GHCFLAGS) $<

clean::
	$(RM) fib

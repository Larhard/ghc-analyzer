EXAMPLES = fib

all: examples

examples: $(EXAMPLES:=_all)

clean:: $(EXAMPLES:=_clean)

%_all:
	$(MAKE) -C $* all

%_clean:
	$(MAKE) -C $* clean

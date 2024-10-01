#
#
#

root_dir = .
include Makefile.inc

srcs	= jsh.md4
dsts	= $(srcs:.md4=.md)

%.md : %.md4
	m4 $(m4_opt) $< > $@

all: $(dsts)

clean: dummy
	rm -f $(dsts)

dummy:


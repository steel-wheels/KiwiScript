#
#
#

DOC_ROOT = .
include Makefile.inc

srcs	= Library.md4
dsts	= $(srcs:.md4=.md)

all: $(dsts)
	(cd Enum && make)
	(cd Class && make)
	(cd Format && make)
	(cd Function && make)

clean:
	rm -f $(dsts)
	(cd Enum && make clean)
	(cd Class && make clean)
	(cd Format && make clean)
	(cd Function && make clean)


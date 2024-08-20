#
# Makefile
#

tools_dir = /usr/local/libexec/arisia/bin
apkg	  = $(tools_dir)/apkg
adecl	  = $(tools_dir)/adecl
jsrun     = $(tools_dir)/jsrun

base_types_dir	= ./types
tsc	= npx tsc
tsc_opt	= -t ES2017 --lib "es2017" --declaration --declarationDir ./types \
	  --alwaysStrict --strict --strictNullChecks --pretty

srclib = ../../../KiwiTools/Resource/types/KiwiLibrary.d.ts 

%.js: %.ts
	$(tsc) $(tsc_opt) $<

srcs	= result.ts \
	  string-func.ts \
	  char-func.ts \
	  file-read-1.ts \
	  file-read-2.ts \
	  file-open.ts \
	  file-func.ts \
	  graph-types.ts \
	  env.ts \
	  hello-0.ts \
	  hello-1.ts \
	  tokenize.ts \
	  getopt.ts

dsts	= $(srcs:.ts=.js)

all: decl $(dsts) build exec

clean:
	rm -f $(dsts)
	(cd screen-size.jspkg && make clean)
	(cd thread-0.jspkg && make clean)
	(cd escape-seq-0.jspkg && make clean)
	#(cd curses-0.jspkg && make clean)
	(cd symbol-0.jspkg && make clean)

decl: dummy
	(cd types && $(adecl))

build: dummy
	if [ -f $(apkg) ] ; then $(apkg) hello.jspkg ; fi
	(cd hello.jspkg && make)
	if [ -f $(apkg) ] ; then $(apkg) screen-size.jspkg ; fi
	(cd screen-size.jspkg && make)
	if [ -f $(apkg) ] ; then $(apkg) thread-0.jspkg ; fi
	(cd thread-0.jspkg && make)
	if [ -f $(apkg) ] ; then $(apkg) escape-seq-0.jspkg ; fi
	(cd escape-seq-0.jspkg && make)
	#if [ -f $(apkg) ] ; then $(apkg) curses-0.jspkg ; fi
	#(cd curses-0.jspkg && make)
	if [ -f $(apkg) ] ; then $(apkg) symbol-0.jspkg ; fi
	(cd symbol-0.jspkg && make)
	if [ -f $(apkg) ] ; then $(apkg) prop-0.jspkg ; fi
	(cd prop-0.jspkg && make)
	#if [ -f $(apkg) ] ; then $(apkg) table-0.jspkg ; fi
	#(cd table-0.jspkg && make)
	#if [ -f $(apkg) ] ; then $(apkg) preference.jspkg ; fi
	#(cd preference.jspkg && make)
	if [ -f $(apkg) ] ; then $(apkg) colors.jspkg ; fi
	(cd colors.jspkg && make)

exec: dummy
	$(jsrun) hello-0.js
	$(jsrun) hello.jspkg
	$(jsrun) hello-main.js
	$(jsrun) colors.jspkg 
	$(jsrun) argv.js a b c
	$(jsrun) result.js
	$(jsrun) env.js
	$(jsrun) string-func.js a b c
	$(jsrun) char-func.js
	$(jsrun) file-read-1.js < file-read-1.ts
	$(jsrun) file-read-2.js 
	$(jsrun) file-open.js
	$(jsrun) file-func.js
	$(jsrun) getopt.js
	$(jsrun) tokenize.js a b c
	$(jsrun) thread-0.jspkg
	$(jsrun) escape-seq-0.jspkg
	#$(jsrun) screen-size.jspkg
	#$(jsrun) curses-0.jspkg
	$(jsrun) symbol-0.jspkg
	$(jsrun) prop-0.jspkg
	#$(jsrun) table-0.jspkg
	#$(jsrun) preference.jspkg

dummy:


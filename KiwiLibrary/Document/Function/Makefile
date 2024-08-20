#
#
#

project_dir	= ../..
library_dir	= $(project_dir)/Resource/Library
script_dir	= ../../../Script

DOC_ROOT = ..
include ../Makefile.inc

srcs	= AsciiCodeName.md4 \
	  exit.md4 \
	  isAlphaNumerics.md4 \
	  isArray.md4 \
	  isBitmap.md4 \
	  isBoolean.md4 \
	  isDate.md4 \
	  isDictionary.md4 \
	  isEOF.md4 \
	  isIdentifier.md4 \
	  isNull.md4 \
	  isNumber.md4 \
	  isObject.md4 \
	  isPoint.md4 \
	  isRect.md4 \
	  isSize.md4 \
	  isString.md4 \
	  isUndefined.md4 \
	  isURL.md4 \
	  openURL.md4 \
	  run.md4 \
	  System.md4 \
	  sleep.md4 \
	  Thread.md4
dsts	= $(srcs:.md4=.md)

all: $(dsts)

clean:
	rm -f $(dsts)

Graphics.md: Graphics.md4 $(library_dir)/Graphics.js


#
# Makefile.inc
#

TYPES_ROOT = $(DOC_ROOT)/../Resource/Library/types

inc_opt	= -I$(DOC_ROOT) \
	  -I$(TYPES_ROOT)

def_opt = \
 -D PROJECT_TOP=https://gitlab.com/steewheels/project/-/blob/main \
 -D KIWI_LIB_TOP=https://gitlab.com/steewheels/kiwiscript/-/blob/main/KiwiLibrary \
 -D KIWI_LIB_DOC=https://gitlab.com/steewheels/kiwiscript/-/blob/main/KiwiLibrary/Document

m4_opt  = -P $(inc_opt) $(def_opt)

%.md : %.md4
	m4 $(m4_opt) $< > $@


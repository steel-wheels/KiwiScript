#
# Makefile.inc
#

inc_opt	= \
 -I$(root_dir)/

def_opt = \
 -D KIWI_LIB_TOP=https://gitlab.com/steewheels/kiwiscript/-/blob/main/KiwiLibrary \
 -D KIWI_LIB_DOC=https://gitlab.com/steewheels/kiwiscript/-/blob/main/KiwiLibrary/Document \
 -D KIWI_ENGINE_DOC=https://gitlab.com/steewheels/kiwiscript/-/tree/main/KiwiEngine/Document

m4_opt  = -P $(inc_opt) $(def_opt)

%.md : %.md4
	m4 $(m4_opt) $< > $@


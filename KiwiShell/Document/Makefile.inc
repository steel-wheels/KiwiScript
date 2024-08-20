#
#
#

md4_cmd	= $(HOME)/tools/bin/md4

%.md: %.md4
	$(md4_cmd) $< > $@


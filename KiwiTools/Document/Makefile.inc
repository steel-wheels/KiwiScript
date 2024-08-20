#
#
#

doc_dir		= $(project_dir)/Document
resource_dir	= $(project_dir)/Resource

md4_cmd	= $(HOME)/tools/bin/md4 \
		--footer $(doc_dir)/Footer.md

%.md: %.md4
	$(md4_cmd) $< > $@


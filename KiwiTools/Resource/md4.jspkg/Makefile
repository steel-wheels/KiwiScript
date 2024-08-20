#
#
#

base_types_dir	= ../types
install_dir	= $(HOME)/tools
pkg_dir		= $(install_dir)/lib/md4.jspkg
jsrun_cmd	= $(HOME)/tools/bin/jsrun
dst_bin_dir	= $(HOME)/tools/bin

tsc	= npx tsc
tsc_opt	= -t ES2017 --lib "es2017" --declaration --declarationDir ./types \
	  --alwaysStrict --strict --strictNullChecks --pretty

jsrun	= $(HOME)/tools/bin/jsrun

%.js: %.ts
	$(tsc) $(tsc_opt) $<

src	= config.ts \
	  command.ts \
	  translate.ts \
	  main.ts

dst 	= $(src:.ts=.js)
decl	= $(src:.ts=.d.ts)

all: $(dst)

clean:
	rm -f $(dst) $(decl)

run: $(dst)
	$(jsrun) $(dst)

main.js: translate.js

install: ./md4
	install -d $(pkg_dir) $(pkg_dir)/types
	install -c ./*.js $(pkg_dir)
	install -c ./*.ts $(pkg_dir)
	install -c ./*.json $(pkg_dir)
	install -c ./types/* $(pkg_dir)/types
	install ./md4 $(dst_bin_dir)

./md4: ./md4.in
	sed -e "s!@jsrun_cmd@!${jsrun_cmd}!" \
	    -e "s!@md4_pkg@!${pkg_dir}!" \
	    $< > $@
	chmod +x ./md4


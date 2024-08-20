#
#
#

jsrun	= ~/tools/bin/jsrun
res_dir	= ../../Resource
pkg_dir = $(res_dir)/md4.jspkg

all: build
	@if $(jsrun) $(pkg_dir) -h ; then \
		echo "Result 0 -> Error" ; \
	else \
		echo "Result non 0 -> OK" ; \
	fi
	@if $(jsrun) $(pkg_dir) --version ; then \
		echo "Result: 0 -> Error" ; \
	else \
		echo "Result: non 0 -> OK" ; \
	fi
	@if $(jsrun) $(pkg_dir) -v ; then \
		echo "Result: 0 -> Error" ; \
	else \
		echo "Result: non 0 -> OK" ; \
	fi
	@if $(jsrun) $(pkg_dir) non-exist-file.txt ; then \
		echo "Result: 0 -> Error" ; \
	else \
		echo "Result: non 0 -> OK" ; \
	fi
	@if $(jsrun) $(pkg_dir) -I non-exist-dir in-0.txt ; then \
		echo "Result: 0 -> Error" ; \
	else \
		echo "Result: non 0 -> OK" ; \
	fi
	@if $(jsrun) $(pkg_dir) -I include in-0.txt ; then \
		echo "Result: 0 -> Error" ; \
	else \
		echo "Result: non 0 -> OK" ; \
	fi
	$(jsrun) $(pkg_dir) -I include include.txt
	$(jsrun) $(pkg_dir) text-0.txt text-1.txt
	$(jsrun) $(pkg_dir) -I include include.txt \
			    --header header-0.txt \
			    --footer footer-0.txt \
			    2>& 1 | tee output-0.txt
	diff ./output-0.txt ./expected/output-0.txt.OK

build: dummy
	(cd $(pkg_dir) && make)

clean: dummy
	rm -f output-*.txt

dummy:


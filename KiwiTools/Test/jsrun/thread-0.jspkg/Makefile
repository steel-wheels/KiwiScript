#
# Makefile
#

asc	= /usr/local/libexec/arisia/bin/asc
asdecl	= /usr/local/libexec/arisia/bin/adecl

tsc	= npx tsc
tsc_opt	= -t ES2017 --lib "es2017" --declaration --declarationDir ./types \
	  --alwaysStrict --strict --strictNullChecks --pretty

jsrun	= /usr/local/libexec/arisia/bin/jsrun

asc_opt =

# *.as -> *.ts, *.d.ts
%.ts: %.as
	$(asc) --target window -f TypeScript $(asc_opt) $<
	$(asc) --target window -f TypeDeclaration $(asc_opt) $<
	mv $(<:.as=.frame.d.ts) types/

# *.js -> *.ts
%.js: %.ts
	$(tsc) $(tsc_opt) $<

# source files
assrcs	= 
utssrcs	=  main.ts thread-0.ts
ltssrcs	= 

# destination files
astsdsts	= $(assrcs:.as=.ts)
asjsdsts	= $(assrcs:.as=.js)
ujsdsts	= $(utssrcs:.ts=.js)
ljsdsts	= $(ltssrcs:.ts=.js)

all: gen_decl lib_scripts user_scripts

gen_decl: dummy
	(cd types && /usr/local/libexec/arisia/bin/adecl)

lib_scripts:  $(ljsdsts)

user_scripts: $(astsdsts) $(asjsdsts) $(ujsdsts)

clean:
	rm -f $(astsdsts) $(asjsdsts) $(ujsdsts) $(ljsdsts)

dummy:


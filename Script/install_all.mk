# install_all.mk

build_mk	= ../../Script/build.mk
install_tool_mk	= ../../Script/install_tool.mk
srcdts		= KiwiLibrary/Resource/Library/types/KiwiLibrary.d.ts
tooldts		=


all: engine tool_edecl res0 lib shell tool_jsrun tool_jsh tool_package doc

engine: dummy
	(cd KiwiEngine/Project  && make -f $(build_mk))

tool_edecl: dummy
	(cd KiwiTools/Project && \
	 make -f $(install_tool_mk) install_edecl_bundle install_edecl)

res0: dummy
	(cd KiwiLibrary/Resource/Library/ && make)

lib: dummy
	(cd KiwiLibrary/Project && make -f $(build_mk))

shell: dummy
	(cd KiwiShell/Project && make -f $(build_mk))

tool_jsrun: KiwiTools/Resource/types/KiwiLibrary.d.ts
	(cd KiwiTools/Project && \
	 make -f $(install_tool_mk) install_jsrun_bundle install_jsrun)

tool_jsh: KiwiTools/Resource/types/KiwiLibrary.d.ts
	(cd KiwiTools/Project && \
	 make -f $(install_tool_mk) install_jsh_bundle install_jsh)

tool_package: dummy
	(cd KiwiTools/Product && make package)

doc: dummy
	(cd KiwiLibrary/Document && make)

KiwiTools/Resource/types/KiwiLibrary.d.ts: $(srcdts)
	cp $< $@

dummy:


#
#
#

#doc_dir		= $(project_dir)/Document
#resource_dir	= $(project_dir)/Resource
#types_dir	= $(resource_dir)/Library/types

inc_opt = -I$(DOC_ROOT)

def_opt = \
 -D PROJECT_TOP=https://gitlab.com/steewheels/project/-/blob/main \
 -D ARISOA_DOC_TOP=https://gitlab.com/steewheels/arisia/-/tree/main/Document \
 -D ARISIA_TOOL_TOP=https://gitlab.com/steewheels/arisia/-/blob/main/ArisiaTools/Document/ \
 -D ARISIA_SAMPLE_TOP=https://gitlab.com/steewheels/arisia/-/tree/main/ArisiaCard/Resource/Samples \
 -D KIWI_LIB_TOP=https://gitlab.com/steewheels/kiwiscript/-/blob/main/KiwiLibrary \
 -D KIWI_TOOLS_TOP=https://gitlab.com/steewheels/kiwiscript/-/tree/main/KiwiTools \
 -D KIWI_LIB_DOC=https://gitlab.com/steewheels/kiwiscript/-/blob/main/KiwiLibrary/Document \
 -D KIWI_ENGIINE_DOC=https://gitlab.com/steewheels/kiwiscript/-/blob/main/KiwiEngine/Document

m4_opt  = -P $(inc_opt) $(def_opt)

%.md : %.md4
	m4 $(m4_opt) $< > $@


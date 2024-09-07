#
# Makefile
#

top_dir		= ../../..
tool_dir	= $(top_dir)/KiwiTools/Product/binary/bin/

srcs	= Result.ts \
	  File.ts \
	  FileManager.ts \
	  CommandLine.ts \
	  Graphics.ts \
	  Language.ts \
	  Semaphore.ts \
	  Cancel.ts \
	  openURL.ts \
	  Readline.ts \
	  Thread.ts \
	  SpriteField.ts \
	  SpriteNode.ts \
	  SpriteScene.ts \
	  SpriteRadar.ts

func_files	= types/func-exit.d.ts \
		  types/func-isAlphaNumerics.d.ts \
		  types/func-isArray.d.ts \
		  types/func-isBitmap.d.ts \
		  types/func-isBoolean.d.ts \
		  types/func-isDate.d.ts \
		  types/func-isDictionary.d.ts \
		  types/func-isEOF.d.ts \
		  types/func-isIdentifier.d.ts \
		  types/func-isNull.d.ts \
		  types/func-isNumber.d.ts \
		  types/func-isObject.d.ts \
		  types/func-isOval.d.ts \
		  types/func-isPoint.d.ts \
		  types/func-isRecord.d.ts \
		  types/func-isRect.d.ts \
		  types/func-isSize.d.ts \
		  types/func-isSpace.d.ts \
		  types/func-isString.d.ts \
		  types/func-isUndefined.d.ts \
		  types/func-isURL.d.ts \
		  types/func-isVector.d.ts \
		  types/func-sleep.d.ts \
		  types/func-Icon.d.ts \
		  types/func-MenuItem.d.ts \
		  types/func-Pipe.d.ts \
		  types/func-Properties.d.ts \
		  types/func-SpriteActions.d.ts \
		  types/func-Table.d.ts \
		  types/func-_Thread.d.ts \

interface_files	= types/Frame.d.ts \
		  types/interface-EnvironmentIF.d.ts \
		  types/interface-CharIF.d.ts \
		  types/interface-ColorIF.d.ts \
		  types/interface-ColorsIF.d.ts \
		  types/interface-ConsoleIF.d.ts \
		  types/interface-CollectionDataIF.d.ts \
		  types/interface-IconIF.d.ts \
		  types/interface-DateIF.d.ts \
		  types/interface-FileIF.d.ts \
		  types/interface-FileManagerIf.d.ts \
		  types/interface-ImageIF.d.ts \
		  types/interface-MenuItemIF.d.ts \
		  types/interface-OvalIF.d.ts \
		  types/interface-PipeIF.d.ts \
		  types/interface-PointIF.d.ts \
		  types/interface-SizeIF.d.ts \
		  types/interface-TokenIF.d.ts \
		  types/interface-SymbolIF.d.ts \
		  types/interface-URLIF.d.ts \
		  types/interface-RecordIF.d.ts \
		  types/interface-RectIF.d.ts \
		  types/interface-GraphicsContextIF.d.ts \
		  types/interface-BitmapContextIF.d.ts \
		  types/interface-TriggerIF.d.ts \
		  types/interface-SpriteNodeRefIF.d.ts \
		  types/interface-SpriteFieldIF.d.ts \
		  types/interface-SpriteNodeDeclIF.d.ts \
		  types/interface-SpriteActionsIF.d.ts \
		  types/interface-SpriteNodeIF.d.ts \
		  types/interface-SpriteSceneIF.d.ts \
		  types/interface-ProcessIF.d.ts \
		  types/interface-RangeIF.d.ts \
		  types/interface-StringStreamIf.d.ts \
		  types/interface-PropertiesIF.d.ts \
		  types/interface-TableIF.d.ts \
		  types/interface-ThreadIF.d.ts \
		  types/interface-EscapeSequenceIF.d.ts \
		  types/interface-EscapeSequencesIF.d.ts \
		  types/interface-EscapeCodesIF.d.ts \
		  types/interface-CursesIF.d.ts \
		  types/interface-SystemPreferenceIF.d.ts \
		  types/interface-UserPreferenceIF.d.ts \
		  types/interface-VectorIF.d.ts \
		  types/interface-ViewPreferenceIF.d.ts \
		  types/interface-PreferenceIF.d.ts

var_files	= types/var-Preference.d.ts

dsts	= $(srcs:.ts=.js)
decls	= $(srcs:.ts=.d.ts)

dstlib  = KiwiLibrary.js
dstdecl	= ./types/KiwiLibrary.d.ts

tsc	= npx tsc
tsc_opt	= -t ES2017 --lib "es2017" --declaration --declarationDir types \
	  --typeRoots types \
	  --alwaysStrict --strict --strictNullChecks --pretty


%.js: %.ts
	$(tsc) $(tsc_opt) $<

all:
	if [ -f $(tool_dir)/edecl ] ; then \
		make transpile ; \
	fi

transpile: exec_tool bltdecl compile $(dstdecl)

exec_tool: dummy
	(cd types && rm -f ./enum-*.d.ts ./interface-*.d.ts && ../$(tool_dir)/edecl)

bltdecl: types/Enum.d.ts types/Intf.d.ts types/Var.d.ts types/Func.d.ts

compile: $(dstlib)

$(dstlib): $(dsts)
	cat $(dsts) > $(dstlib)

types/Enum.d.ts: dummy
	cat types/enum-*.d.ts > $@

types/Intf.d.ts: $(interface_files)
	cat $(interface_files) > $@

types/Var.d.ts: $(var_files)
	cat $(var_files) > $@

types/Func.d.ts: $(func_files)
	cat $(func_files) > $@

$(dstdecl): dummy
	(cd types && \
	 cat Enum.d.ts Intf.d.ts Var.d.ts Func.d.ts Builtin.d.ts) > $@
	# Remove reference because every declarations are concatenated
	# before this declaration
	(cd types && \
	 cat $(decls) \
	 | grep -v "/// <reference path=" \
	) >> $@

clean:
	rm -f types/Enum.d.ts types/Intf.d.ts types/Var.d.ts types/Func.d.ts

realclean: clean
	rm -f $(dsts) $(decls) $(dstdecl)
	rm -f types/Enum.d.ts types/Intf.d.ts types/Var.d.ts types/Func.d.ts

dummy:


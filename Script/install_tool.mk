# install_tool.mk

PROJECT_NAME	?= KiwiTools
PRODUCT_DIR	= ../Product
BUNDLE_PATH	= binary/bin
BIN_PATH	= binary/bin

all: dummy
	echo "usage: make install_bundle or make install_tools"

install_edecl_bundle: dummy
	xcodebuild install \
	  -scheme edecl_bundle \
	  -project $(PROJECT_NAME).xcodeproj \
	  -destination="macOSX" \
	  -configuration Release \
	  -sdk macosx \
	  BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
	  INSTALL_PATH=$(BUNDLE_PATH) \
	  SKIP_INSTALL=NO \
	  DSTROOT=$(PRODUCT_DIR) \
	  ONLY_ACTIVE_ARCH=NO

install_jsrun_bundle: dummy
	xcodebuild install \
	  -scheme jsrun_bundle \
	  -project $(PROJECT_NAME).xcodeproj \
	  -destination="macOSX" \
	  -configuration Release \
	  -sdk macosx \
	  BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
	  INSTALL_PATH=$(BUNDLE_PATH) \
	  SKIP_INSTALL=NO \
	  DSTROOT=$(PRODUCT_DIR) \
	  ONLY_ACTIVE_ARCH=NO

install_jsh_bundle: dummy
	xcodebuild install \
	  -scheme jsh_bundle \
	  -project $(PROJECT_NAME).xcodeproj \
	  -destination="macOSX" \
	  -configuration Release \
	  -sdk macosx \
	  BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
	  INSTALL_PATH=$(BUNDLE_PATH) \
	  SKIP_INSTALL=NO \
	  DSTROOT=$(PRODUCT_DIR) \
	  ONLY_ACTIVE_ARCH=NO

install_edecl: dummy
	xcodebuild install \
	  -scheme edecl \
	  -project $(PROJECT_NAME).xcodeproj \
	  -destination="macOSX" \
	  -configuration Release \
	  -sdk macosx \
	  BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
	  INSTALL_PATH=$(BIN_PATH) \
	  SKIP_INSTALL=NO \
	  DSTROOT=$(PRODUCT_DIR) \
	  ONLY_ACTIVE_ARCH=NO

install_jsrun: dummy
	xcodebuild install \
	  -scheme jsrun \
	  -project $(PROJECT_NAME).xcodeproj \
	  -destination="macOSX" \
	  -configuration Release \
	  -sdk macosx \
	  BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
	  INSTALL_PATH=$(BIN_PATH) \
	  SKIP_INSTALL=NO \
	  DSTROOT=$(PRODUCT_DIR) \
	  ONLY_ACTIVE_ARCH=NO

install_jsh: dummy
	xcodebuild install \
	  -scheme jsh \
	  -project $(PROJECT_NAME).xcodeproj \
	  -destination="macOSX" \
	  -configuration Release \
	  -sdk macosx \
	  BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
	  INSTALL_PATH=$(BIN_PATH) \
	  SKIP_INSTALL=NO \
	  DSTROOT=$(PRODUCT_DIR) \
	  ONLY_ACTIVE_ARCH=NO

dummy:


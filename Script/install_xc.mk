# install_xc.mk

PROJECT_NAME	?= KiwiScript

DERIVED_BASE	= $(HOME)/build/derived-data/
PRODUCT_PATH	= Build/Products/Release

all: pack_os
	echo "done"

pack_os: install_osx install_ios install_ios_sim
	(cd $(HOME)/Library/Frameworks ; rm -rf $(PROJECT_NAME).xcframework)
	xcodebuild -create-xcframework \
	  -framework $(DERIVED_BASE)/$(PROJECT_NAME)_macOS/$(PRODUCT_PATH)/$(PROJECT_NAME).framework \
	  -framework $(DERIVED_BASE)/$(PROJECT_NAME)_iOS/$(PRODUCT_PATH)-iphoneos/$(PROJECT_NAME).framework \
	  -framework $(DERIVED_BASE)/$(PROJECT_NAME)_iOS_sim/$(PRODUCT_PATH)-iphonesimulator/$(PROJECT_NAME).framework \
	  -output $(HOME)/Library/Frameworks/$(PROJECT_NAME).xcframework


install_osx: dummy
	xcodebuild build \
	  -scheme $(PROJECT_NAME)_macOS \
	  -project $(PROJECT_NAME).xcodeproj \
	  -destination="macOSX" \
	  -configuration Release \
	  -sdk macosx \
	  -derivedDataPath $(DERIVED_BASE)/$(PROJECT_NAME)_macOS \
	  BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
	  SKIP_INSTALL=NO \
	  ONLY_ACTIVE_ARCH=NO

install_ios: dummy
	xcodebuild build \
	  -scheme $(PROJECT_NAME)_iOS \
	  -project $(PROJECT_NAME).xcodeproj \
	  -destination="iOS" \
	  -configuration Release \
	  -sdk iphoneos \
	  -derivedDataPath $(DERIVED_BASE)/$(PROJECT_NAME)_iOS \
	  BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
	  SKIP_INSTALL=NO \
	  ONLY_ACTIVE_ARCH=NO

install_ios_sim: dummy
	xcodebuild build \
	  -scheme $(PROJECT_NAME)_iOS \
	  -project $(PROJECT_NAME).xcodeproj \
	  -destination="iOS Simulator" \
	  -configuration Release \
	  -sdk iphonesimulator \
	  -derivedDataPath $(DERIVED_BASE)/$(PROJECT_NAME)_iOS_sim \
	  BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
	  SKIP_INSTALL=NO \
	  ONLY_ACTIVE_ARCH=NO

dummy:


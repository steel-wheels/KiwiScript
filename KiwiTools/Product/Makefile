#
#
#

PACKAGE		= package/KiwiTools.pkg
PKG_PATH	= /usr/local/libexec/arisia
VERSION		= "1.0"

all: package notarize

package: dummy
	rm -f $(PACKAGE)
	pkgbuild --identifier "github.com.steelwheels.KiwiTools" \
		 --install-location $(PKG_PATH) \
		 --version $(VERSION) \
		 --root binary  \
		 --sign "${DEV_INSTALL_SIGN}" \
		 --timestamp \
		$(PACKAGE)

notarize: dummy
	xcrun notarytool submit $(PACKAGE) \
			 --keychain-profile "Steel Wheels Project" \
			 --wait


dummy:


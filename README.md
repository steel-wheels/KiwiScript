# About KiwiScript
The *KiwiScript* is the package of frameworks to support JavaScript runtime on macOS.iOS application. The [JavaScriptCore](https://developer.apple.com/documentation/javascriptcore) is used as the infrastructure.

# Copyright
Copyright (C) 2018-2023 [Steel Wheels Project](https://gitlab.com/steewheels/project/-/wikis/The-Steel-Wheels-Project).
This software is distributed under [GNU LESSER GENERAL PUBLIC LICENSE Version 2.1](https://www.gnu.org/licenses/lgpl-2.1-standalone.html).

## Target system
* OS version:   macOS 13, iOS 16
* Xcode:        Xcode 14

## Compile and install
Execute following commands under `KiwiScript` directory:
````
make -f Script/install_all.mk
````

# Contents
This package contains following frameworks:
- [Kiwi Engine](./KiwiEngine/README.md): Define JavaScript execution environment based on [JavaScriptCore](https://developer.apple.com/documentation/javascriptcore).
- [KiwiLibrary](./KiwiLibrary/README.md): Built-in libraries to be used in the JavaScript.
- [KiwiShell](./KiwiShell/README.md): The shell component which supports JavaScript as shell script.

# Related links
* [Steel Wheels Project](https://gitlab.com/steewheels/project/-/wikis/The-Steel-Wheels-Project): The developer of this software.


# eJSTN: extended JavaScript Type Notation

## Introduction
The JavaScript Type Notation format is used to define
application specific type.

<pre>
enum: {
  // enum definitions
} ;

interface IF {
  // interface members
} ;
</pre>

## Enum definition

example:
<pre>
enum week {
  sunday  = 0 ;
  monday  = 1 ;
  tuesday = 2 ;
} 
</pre>

## Interface definition

example:
<pre>
interface dog: animal {
  run(): void ;
}
</pre>

# Related links
* [Steel Wheels Project](https://gitlab.com/steewheels/project/-/blob/main/README.md): Developer's home page
* [KiwiLibrary Framework](https://gitlab.com/steewheels/kiwiscript/-/blob/main/KiwiLibrary/README.md): The framework contains this library.



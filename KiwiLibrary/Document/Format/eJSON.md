# eJSON: Extended JavaScript Object Notation

## Introduction
This document describes about the specification of
Extended JavaScript Object Notation (<code>eJSON</code>).
It is similar to [JavaScript Object Notation (JSON)](https://www.json.org/json-en.html).
But there are some different points.

* The comments in the docunent is supported.
* The property name does not require double quotation.
* The identifier value is supported

This notation is used to define the structured data.
It is loaded/stored from/to the text file.

# The syntax
## Comment
The string after <code>//</code> (It is called as comment) is ignored. 
<pre>
{
  // this is comment
  a: 12.3   // The member "a" has number value, 12.3
}
</pre>

## Property name
<pre>
{
  a: 12.3 // The property name is NOT wrapped by <code>"</code>.
}
</pre>

## Identifier value
You can use enum identifier in the document.
If the oarser recognize the identifier as enum member,
it will replaced by the member's value.

<pre>
{
  week: .Monday // enum Week { Monday, Tuesdata, ... }
}
</pre>

## File
### File extension
<code>tson<code> is used instead of <code>json</code>

# Related links
* [Steel Wheels Project](https://gitlab.com/steewheels/project/-/blob/main/README.md): Developer's home page
* [KiwiLibrary Framework](https://gitlab.com/steewheels/kiwiscript/-/blob/main/KiwiLibrary/README.md): The framework contains this library.



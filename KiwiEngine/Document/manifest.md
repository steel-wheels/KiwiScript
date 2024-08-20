# Manifest

## Introduction
JavaScript package is a bundle of files for a JavaScript application.
The package can have multiple scripts, libraries and the other files.
The manifest file (named <code>manifest.json</code> or <code>manifest.json.in</code>) is required to present the content of the package.
It must be placed in under the <code>.jspkg</code> directory.

## Kind of files
There are 2 kind of manifest files. 
In usually, the [apkg](ARISIA_TOOLS_TOP/apkg-man.md) command generate <code>manifest.json</code> from <code>manifest.json.in</code>.

|File name    |Description    |
|-            |-              |
|<code>manifest.json.in</code> | Define the user's source files. Some files are transpiled into the others before executing the application. |
|<code>manifest.json</code> | Define the files which is required to execute the application. |

## Contents
The manifest file defines the reference of the other files for each sections. 
The following sections are defined:
* application
* views
* definitions
* libraries
* threads
* properties
* tables
* images

Here is a sample description of manifest file.
<pre>
{
  application:  "main.js",
  views: {
    view_a: "view_a.js",
    view_b: "view_b.js"
  },
  libraries: [
    "lib_a.js",
    "lib_b.js"
  ],
  threads: {
    thread_a:  "thread_a.js",
    thread_b:  "thread_b.js"
  },
  images: {
    image_a: "image_a.jpg",
    image_b: "image_b.png"
  },
  properties: {
    property_a: {
      type: "type.d.ts",
      data: "data.json"
    }
  },
  tables: {
    table_a: {
      type: "record_a.d.ts",
      data: "table_value.json"
    }
  }
}
</pre>

### Application section
The <code>application</code> section has a name of main script. This section is _always required_.

The main script must contain <code>main</code> function.
This is an example of application section in the <code>manifest.json.in</code> file:
<pre>
{
  application: "main.ts"
}
</pre>

If the file name has <code>.ts</code> extension, the <code>apkg</code> command replace it
by <code>.js</code> with inserting rules to transpile them.

The main function has following prototype:
<pre>
main(argv: string[]): number
</pre>

You can see the example at [hello.jspkg](https://gitlab.com/steewheels/kiwiscript/-/tree/main/KiwiTools/Test/jsrun/hello.jspkg).

### Views section
The <code>views</code> section defines the view names for each view component script.
The following example has 2 view components named <code>view_a</code> and <code>view_b</code>.
The file of source script of <code>view_a</code> is <code>"view_a.as"</code>.
The source script must be written by [ArisiaScript](ARISIA_DOC_TOP/arisia-lang.md) to design GUI parts of a view.

<pre>
{
  views: {
    view_a: "view_a.as",
    view_b: "view_b.as"
  }
}
</pre>

You can see the example at [hello.jspkg](https://gitlab.com/steewheels/arisia/-/tree/main/ArisiaCard/Resource/Samples/hello.jspkg).

### Definitions section
The <code>definitions</code> section contains the array of the names of the type declaration files.
See [sample declaration](https://gitlab.com/steewheels/arisia/-/tree/main/ArisiaCard/Resource/Samples/resource.jspkg/typdef.d.ts)

### Libraries section
The <code>libraries</code> section contains array of the name of library script files.
They will be compiled before compiling the application script and thread script.
The evaluation order is defined as the order of the array declaration.

This is an example of libraries section in the <code>manifest.json.in</code> file:
<pre>
{
  libraries: [
  	"library.ts"
  ]
}
</pre>

If the file name has <code>.ts</code> extension, the <code>apkg</code> command replace it
by <code>.js</code> with inserting rules to transpile them.

You can see the example at [library.jspkg](https://gitlab.com/steewheels/kiwiscript/-/tree/main/KiwiTools/Test/jsrun/library.jspkg).

### Threads section
The <code>threads</code> section contains array of script file names to execute as threads.
You can allocate thread in the main process (or the other threads) by the [Thread](https://gitlab.com/steewheels/kiwiscript/-/blob/main/KiwiLibrary/Document/Function/Thread.md) function. The name is referred as thread name and the value is referred as script file name.

<pre>
{
  application: "main.ts"
  threads: {
    thread_0: "thread-0.ts"
  }
}
</pre>

This is sample script to launch the thread:
<pre>
let th0 = Thread("thread_0", console) ;
th0.start(["a", "b"]) ;
waitThread(th0) ;
</pre>

You can see the example at [thread-0.jspkg](https://gitlab.com/steewheels/kiwiscript/-/tree/main/KiwiTools/Test/jsrun/thread-0.jspkg).

### Images section
The <code>images</code> section contains file names of image data such as [Portable Network Graphics (*.png)](http://www.libpng.org/pub/png/), [JPEG](https://jpeg.org/jpeg/) etc...

### Properties section
The <code>properties</code> section has definitions of properties. See the below example. Each property (named "<code>property_name_N</code>" in the example) has definitons of type file and data file.
The "<code>type</code>" section has the location of the file which defines the property type. The "<code>data</code>" section has the location of the file which defines the property data.

<pre>
{
  properties: {
    property_name_1: {
      type: "type.d.ts",
      data: "data.json"
    },
    propert_name2: {
      ...
    },
    ...
  }
}
</pre>

This is an example of property type file.
<pre>
interface Record0IF {
  field1: number ;
  field2: string ;
}
</pre>

This is an example of property data file.
<pre>
{
  record0: {
    field1: 123,
    field2: "a"
  },
  record1: {
    field1: 123,
    field2: "a"
  }
}
</pre>

See [prop-0.jspkg](https://gitlab.com/steewheels/kiwiscript/-/tree/main/KiwiTools/Test/jsrun/prop-0.jspkg) for the sample usage of this section.

### Tables section
The <code>tables</code> section contains the _table data_.
The _table data_ is an array of record data. 
And the _record data_ is a dictionary data whose key is the <code>string</code> and the value is any data.

This is a sample implementation of <code>tables</code> section.
<pre>
tables: {
 table_a: { // Name of the table
  type: "table_a.d.ts",   // Data type of the
                          // record
  data: "table_a.json"    // Array of record
                          // values
 }
}
</pre>

The data type is descibed as interface of TypeScript.
This is an example of type definition:
<pre>
interface RecordIF {
	a: number ;
	b: number ;
}
</pre>

The table data is defined by [eJSON format](https://gitlab.com/steewheels/kiwiscript/-/blob/main/KiwiLibrary/Document/Format/eJSON.md).
This is an example of table data:

<pre>
[
  {
    a: 1
    b: 2
  },
  {
    a: 3
    b: 4
  }
]
</pre>

You can see the sample implementation [table-0.jspkg](https://gitlab.com/steewheels/kiwiscript/-/tree/main/KiwiTools/Test/jsrun).

# Related links
* [Steel Wheels Project](https://gitlab.com/steewheels/project/-/blob/main/README.md): Developer's home page
* [KiwiEngine Framework](https://gitlab.com/steewheels/kiwiscript/-/tree/main/KiwiEngine)




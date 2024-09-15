# URL class

## Interface
<pre>
interface URLIF {
  isNull : boolean ;
  absoluteStriung : string ;
  path : string ;
  appending(p0 : string): URLIF ;
  lastPathComponent : string ;
  deletingLastPathComponent : URLIF ;
  loadText(): string | null ;
}

</pre>

## Constructor
<pre>
declare function URL(path: string): URLIF | null ;

</pre>

# Related links
* [Steel Wheels Project](https://gitlab.com/steewheels/project/-/blob/main/README.md): Developer's home page
* [KiwiLibrary Framework](https://gitlab.com/steewheels/kiwiscript/-/blob/main/KiwiLibrary/README.md): The framework contains this library.



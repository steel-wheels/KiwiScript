# Environment class

## Constructor
<pre>
declare var env: EnvironmentIF ;
</pre>

## Interface
<pre>
interface EnvironmentIF {
  getVariable(p0 : string): string | null ;
  setVariable(p0 : string, p1 : string): void ;
  getAll(): {[name: string]: string} ;
  packageDirectory : URLIF ;
  currentDirectory : URLIF ;
  searchPackage(p0 : string): URLIF | null ;
}

</pre>

# Related links
* [Steel Wheels Project](https://gitlab.com/steewheels/project/-/blob/main/README.md): Developer's home page
* [KiwiLibrary Framework](https://gitlab.com/steewheels/kiwiscript/-/blob/main/KiwiLibrary/README.md): The framework contains this library.



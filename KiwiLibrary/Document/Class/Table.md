# Table

## Constructor
<pre>
declare function Table(name: string): TableIF | null ;


</pre>

## Interface
<pre>
interface TableIF {
  recordCount : number ;
  fieldName(p0 : number): string ;
  fieldNames(): string[] ;
  remove(p0 : number): boolean ;
}

</pre>

## File format
The file format to load/save this object is defined in [Table file format](../Format/Table.md).

# Related links
* [Steel Wheels Project](https://gitlab.com/steewheels/project/-/blob/main/README.md): Developer's home page
* [KiwiLibrary Framework](https://gitlab.com/steewheels/kiwiscript/-/blob/main/KiwiLibrary/README.md): The framework contains this library.



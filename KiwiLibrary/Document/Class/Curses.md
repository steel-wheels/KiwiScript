# class: Curses

## Interface
<pre>
interface CursesIF {
  begin(): void ;
  end(): void ;
  width : number ;
  height : number ;
  foregroundColor : ColorIF ;
  backgroundColor : ColorIF ;
  moveTo(p0 : number, p1 : number): void ;
  put(p0 : string): void ;
  clear(): void ;
}

</pre>

# Related links
* [Steel Wheels Project](https://gitlab.com/steewheels/project/-/blob/main/README.md): Developer's home page
* [KiwiLibrary Framework](https://gitlab.com/steewheels/kiwiscript/-/blob/main/KiwiLibrary/README.md): The framework contains this library.



# class: GraphicsContext

## Interface
<pre>
interface GraphicsContextIF {
  logicalFrame : RectIF ;
  setFillColor(p0 : ColorIF): void ;
  setStrrokeColor(p0 : ColorIF): void ;
  setPenSize(p0 : number): void ;
  moveTo(p0 : number, p1 : number): void ;
  lineTo(p0 : number, p1 : number): void ;
  rect(p0 : number, p1 : number, p2 : number, p3 : number, p4 : boolean): void ;
  circle(p0 : number, p1 : number, p2 : number, p3 : boolean): void ;
}

</pre>

# Related links
* [Steel Wheels Project](https://gitlab.com/steewheels/project/-/blob/main/README.md): Developer's home page
* [KiwiLibrary Framework](https://gitlab.com/steewheels/kiwiscript/-/blob/main/KiwiLibrary/README.md): The framework contains this library.



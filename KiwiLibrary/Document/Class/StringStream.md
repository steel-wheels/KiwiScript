# StringStream class

## Constructor
<pre>
StringStream(str: string): StringStreamIF
</pre>

## Interface
<pre>
interface StringStreamIF {
  getc(): string | null ;
  gets(p0 : number): string | null ;
  getl(): string | null ;
  getident(): string | null ;
  getword(): string | null ;
  getint(): number | null ;
  ungetc(): string | null ;
  reqc(p0 : string): boolean ;
  peek(p0 : number): string | null ;
  skip(p0 : number): void ;
  skipSpaces(): void ;
  eof(): boolean ;
}

</pre>

# Related links
* [Steel Wheels Project](https://gitlab.com/steewheels/project/-/blob/main/README.md): Developer's home page
* [KiwiLibrary Framework](https://gitlab.com/steewheels/kiwiscript/-/blob/main/KiwiLibrary/README.md): The framework contains this library.



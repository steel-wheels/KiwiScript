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

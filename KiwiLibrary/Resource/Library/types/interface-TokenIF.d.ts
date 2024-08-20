interface TokenIF {
  type : TokenType ;
  lineNo : number ;
  reservedWord(): number | null ;
  symbol(): string | null ;
  identifier(): string | null ;
  bool(): boolean | null ;
  int(): number | null ;
  float(): number | null ;
  text(): string | null ;
}

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

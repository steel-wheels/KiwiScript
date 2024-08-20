interface URLIF {
  isNull : boolean ;
  absoluteStriung : string ;
  path : string ;
  appending(p0 : string): URLIF ;
  lastPathComponent : string ;
  deletingLastPathComponent : URLIF ;
  loadText(): string | null ;
}

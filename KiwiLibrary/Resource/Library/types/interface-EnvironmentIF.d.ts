interface EnvironmentIF {
  getVariable(p0 : string): string | null ;
  setVariable(p0 : string, p1 : string): void ;
  getAll(): {[name: string]: string} ;
  packageDirectory : URLIF ;
  currentDirectory : URLIF ;
  searchPackage(p0 : string): URLIF | null ;
}

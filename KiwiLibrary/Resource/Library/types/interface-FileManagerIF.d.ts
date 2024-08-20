interface FileManagerIF {
  open(p0 : URLIF, p1 : string): FileIF | null ;
  fileExists(p0 : URLIF): boolean ;
  isReadable(p0 : URLIF): boolean ;
  isWritable(p0 : URLIF): boolean ;
  isExecutable(p0 : URLIF): boolean ;
  isAccessible(p0 : URLIF): boolean ;
  checkFileType(p0 : URLIF): FileType | null ;
  documentDirectory : URLIF ;
  libraryDirectory : URLIF ;
  applicationSupportDirectory : URLIF ;
  resourceDirectory : URLIF ;
  temporaryDirectory : URLIF ;
  currentDirectory : URLIF ;
  copy(p0 : URLIF, p1 : URLIF): boolean ;
  remove(p0 : URLIF): boolean ;
}

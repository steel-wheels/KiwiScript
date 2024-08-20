interface ProcessIF {
  isRunning : boolean ;
  didFinished : boolean ;
  exitCode : number ;
  terminate(): void ;
}

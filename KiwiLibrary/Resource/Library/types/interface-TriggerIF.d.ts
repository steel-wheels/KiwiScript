interface TriggerIF {
  trigger(): void ;
  isRunning(): boolean ;
  ack(): void ;
}

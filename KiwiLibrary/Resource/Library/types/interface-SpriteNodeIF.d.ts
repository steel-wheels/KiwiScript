interface SpriteNodeIF {
  material : SpriteMaterial ;
  nodeId : number ;
  currentTime : number ;
  trigger : TriggerIF ;
  position : PointIF ;
  size : SizeIF ;
  velocity : VectorIF ;
  mass : number ;
  density : number ;
  area : number ;
  actions : SpriteActionsIF ;
}

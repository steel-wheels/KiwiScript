declare enum AccessType {
  append = 2,
  read = 0,
  write = 1
}
declare enum AlertType {
  critical = 3,
  informational = 1,
  warning = 2
}
declare enum Alignment {
  center = 3,
  fill = 2,
  leading = 0,
  trailing = 1
}
declare enum AnimationState {
  idle = 0,
  pause = 2,
  run = 1
}
declare enum Authorize {
  authorized = 3,
  denied = 2,
  examinating = 1,
  undetermined = 0
}
declare enum Axis {
  horizontal = 0,
  vertical = 1
}
declare enum ButtonState {
  disable = 1,
  hidden = 0,
  off = 2,
  on = 3
}
declare enum ComparisonResult {
  ascending = -1,
  descending = 1,
  same = 0
}
declare enum Device {
  carPlay = 4,
  ipad = 2,
  mac = 0,
  phone = 1,
  tv = 3
}
declare enum Distribution {
  equalSpacing = 3,
  fill = 0,
  fillEqually = 2,
  fillProportinally = 1
}
declare enum ExitCode {
  commaneLineError = 2,
  exception = 6,
  fileError = 3,
  internalError = 1,
  noError = 0,
  runtimeError = 5,
  syntaxError = 4
}
declare enum FileType {
  directory = 2,
  file = 1
}
declare enum FontSize {
  large = 2,
  regular = 1,
  small = 0
}
declare enum FontStyle {
  monospace = 1,
  normal = 0
}
declare enum InterfaceStyle {
  dark = 1,
  light = 0
}
declare enum Language {
  chinese = 0,
  deutch = 1,
  english = 2,
  french = 3,
  italian = 4,
  japanese = 5,
  korean = 6,
  others = 9,
  russian = 7,
  spanish = 8
}
declare enum LogLevel {
  debug = 3,
  detail = 4,
  error = 1,
  nolog = 0,
  warning = 2
}
declare enum ProcessStatus {
  cancelled = 3,
  finished = 2,
  idle = 0,
  running = 1
}
declare enum SortOrder {
  decreasing = 1,
  increasing = -1,
  none = 0
}
declare enum SpriteMaterial {
  background = 1,
  image = 3,
  scene = 0,
  text = 2
}
declare enum SymbolSize {
  large = 120,
  regular = 90,
  small = 60
}
declare enum Symbols {
  character = "character",
  checkmarkSquare = "checkmark.square",
  chevronBackward = "chevron.backward",
  chevronDown = "chevron.down",
  chevronForward = "chevron.forward",
  chevronUp = "chevron.up",
  gamecontroller = "gamecontroller",
  gearshape = "gearshape",
  handPointUp = "hand.point.up",
  handRaised = "hand.raised",
  house = "house",
  line16p = "line.16p",
  line1p = "line.1p",
  line2p = "line.2p",
  line4p = "line.4p",
  line8p = "line.8p",
  lineDiagonal = "line.diagonal",
  magnifyingglass = "magnifyingglass",
  moonStars = "moon.stars",
  oval = "oval",
  ovalFill = "oval.fill",
  paintbrush = "paintbrush",
  pencil = "pencil",
  pencilCircle = "pencil.circle",
  pencilCircleFill = "pencil.circle.fill",
  play = "play",
  questionmark = "questionmark",
  rainbow = "rainbow",
  rectangle = "rectangle",
  rectangleFill = "rectangle.fill",
  square = "square",
  sunMax = "sun.max",
  sunMin = "sun.min",
  terminal = "apple.terminal"
}
declare enum TokenType {
  bool = 3,
  comment = 7,
  float = 5,
  identifier = 2,
  int = 4,
  reservedWord = 0,
  symbol = 1,
  text = 6
}

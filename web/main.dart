import 'package:wod/src/Game.dart';
import 'package:wod/src/Client.dart';

void main() {
  int width = 80, height = 40;
  Game game = new Game();
  new Client(width, height, game);

  game.run();
}

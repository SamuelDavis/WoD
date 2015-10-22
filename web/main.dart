import 'package:wodClient/src/Game.dart';
import 'package:wodClient/src/Client.dart';

void main() {
  Game game = new Game();
  game.start();
  Client client = new Client(800, 400);
  client.start(game);
}

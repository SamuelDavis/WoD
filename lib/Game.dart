library wod.Game;
import 'dart:collection';
import 'package:wod/GameEntity.dart';

class Game {
  final int MS_PER_UPDATE = 1000;
  Queue<GameEntity> gameObjects = new Queue();

  void run() {
    int turnEnd = new DateTime.now().millisecondsSinceEpoch;
    int lag = 0;

    while (true) {
      int turnStart = new DateTime.now().millisecondsSinceEpoch;
      lag += (turnStart - turnEnd);
      turnEnd = turnStart;

      while (lag >= this.MS_PER_UPDATE) {
        this.gameObjects.forEach((GameEntity o) => o.update());
        lag -= this.MS_PER_UPDATE;
      }
    }
  }
}

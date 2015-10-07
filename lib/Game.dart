library wod.Game;
import 'dart:collection';
import 'package:wod/Entities/GameEntity.dart';

class Game {
  final int MS_PER_UPDATE = 1000;
  Queue<GameEntity> entities = new Queue();

  void run() {
    int updateEnd = new DateTime.now().millisecondsSinceEpoch;
    int lag = 0;

    while (true) {
      int updateStart = new DateTime.now().millisecondsSinceEpoch;
      lag += (updateStart - updateEnd);
      updateEnd = updateStart;

      while (lag >= this.MS_PER_UPDATE) {
        this.entities.forEach((GameEntity o) => o.update());
        lag -= this.MS_PER_UPDATE;
      }
    }
  }
}

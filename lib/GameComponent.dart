library wod.Component;
import 'package:wod/GameEvent.dart';
import 'package:wod/GameEntity.dart';

abstract class GameComponent {
  GameEntity entity;

  void listen(GameEvent e);

  void broadcast(GameEvent e) => this.entity.queueEvent(e);
}
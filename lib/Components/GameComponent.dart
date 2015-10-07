library wod.Components;
import 'package:wod/Events/GameEvent.dart';
import 'package:wod/Entities/GameEntity.dart';

abstract class GameComponent {
  GameEntity entity;

  void listen(GameEvent e);

  void broadcast(GameEvent e) => this.entity.queueEvent(e);
}
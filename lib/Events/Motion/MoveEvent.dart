library wod.Events.Motion.MoveEvent;
import 'package:wod/Events/GameEvent.dart';
import 'package:wod/Entities/Direction.dart';

class MoveEvent extends GameEvent {

  Direction direction;
  int force;

  MoveEvent(this.direction, this.force);
}
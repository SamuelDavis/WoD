library wod.Events.Motion.MovedEvent;
import 'package:wod/Events/GameEvent.dart';
import 'dart:math';

class MovedEvent extends GameEvent {

  Point from, to;

  MovedEvent(this.from, this.to);
}
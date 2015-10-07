library wod.Components.VectorComponent;
import 'package:wod/Components/GameComponent.dart';
import 'package:wod/Events/GameEvent.dart';
import 'package:wod/Events/Motion/MoveEvent.dart';
import 'dart:math';
import 'package:wod/Entities/Direction.dart';
import 'package:wod/Events/Motion/MovedEvent.dart';

class PositionComponent extends GameComponent {

  int _x, _y;

  PositionComponent(Point p) : this._x = p.x, this._y = p.y;

  void listen(GameEvent e) {
    switch (e.runtimeType) {
      case MoveEvent:
        this.move(e);
        break;
    }
  }

  void move(MoveEvent e) {
    Point from = this.point;
    switch (e.direction) {
      case Direction.north:
        Point to = new Point(this._x, this._y + e.force);
        break;
      case Direction.east:
        Point to = new Point(this._x + e.force, this._y);
        break;
      case Direction.south:
        Point to = new Point(this._x, this._y - e.force);
        break;
      case Direction.west:
        Point to = new Point(this._x - e.force, this._y);
        break;
    }

    // TODO: check collision
    // if (collidedEntity = getEntityAt(to)) {
    // this.broadcast(new CollisionEvent(collidedEntity));
    // return;
    // }

    this.broadcast(new MovedEvent(from, this.point));
  }

  Point get point => new Point(this._x, this._y);
}
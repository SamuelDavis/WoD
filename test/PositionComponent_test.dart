import 'package:unittest/unittest.dart';
import 'package:dartmocks/dartmocks.dart';
import 'package:wod/Events/Motion/MoveEvent.dart';
import 'package:wod/Components/PositionComponent.dart';
import 'dart:math';
import 'package:wod/Entities/Direction.dart';
import 'package:wod/Events/Motion/MovedEvent.dart';

testMove(Point from, Point to, Direction direction, int force) {
  TestDouble entity = mock('GameEntity')
    ..shouldReceive('queueEvent').times(1);
  PositionComponent position = new PositionComponent(from);
  position.entity = entity;
  position.listen(new MoveEvent(direction, force));
  expect(position.point, to);
}

main() {
  tearDown(() {
    currentTestRun.verify();
  });

  test('Move north', () {
    int force = 1;
    Point from = new Point(0, 0);
    Point to = new Point(from.x, from.y + force);
    testMove(from, to, Direction.north, force);
  });

  test('Move east', () {
    int force = 2;
    Point from = new Point(0, 0);
    Point to = new Point(from.x + force, from.y);
    testMove(from, to, Direction.east, force);
  });

  test('Move south', () {
    int force = 3;
    Point from = new Point(0, 0);
    Point to = new Point(from.x, from.y - force);
    testMove(from, to, Direction.south, force);
  });

  test('Move west', () {
    int force = 4;
    Point from = new Point(0, 0);
    Point to = new Point(from.x - force, from.y);
    testMove(from, to, Direction.west, force);
  });
}
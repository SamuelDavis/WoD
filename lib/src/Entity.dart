library wod.Entities;
import 'package:wod/src/Components.dart';

class EntityFactory {
  List<GameEntity> _entities = new List();

  NullEntity nullEntity() {
    NullEntity e = new NullEntity();
    _entities.add(e);
    return e;
  }
}

abstract class GameEntity {
  Map<Type, Component> _components = new Map();

  Component addComponent(Component c) => _components.putIfAbsent(c.runtimeType, () => c);

  bool hasComponent(Component c) => _components.containsKey(c.runtimeType);

  Component removeComponent(Component c) => _components.remove(c.runtimeType);
}

class NullEntity extends GameEntity {
}

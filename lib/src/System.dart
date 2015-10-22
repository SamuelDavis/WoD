library wod.Systems;
import 'package:wod/src/Messages.dart';
import 'package:wod/src/Components.dart';
import 'package:wod/src/Game.dart';

class SystemFactory {

}

abstract class System {
  Game _game;

  Map<Type, Component> _components = new Map();
  Map<Type, List<Component>> _messageSwitch = new Map();

  System(this._game);

  bool interestedInMessage(Message m) => _messageSwitch.containsKey(m.runtimeType);

  void addComponent(Component c) {
    _components.putIfAbsent(c.runtimeType, () => c);
    c.messageTypes.forEach((Type eventType) {
      _messageSwitch.putIfAbsent(eventType, () => new List<Component>());
      if (!_messageSwitch[eventType].contains(c)) _messageSwitch[eventType].add(c);
    });
  }

  bool hasComponent(Component c) => _components.containsKey(c.runtimeType);

  Component removeComponent(Component c) => _components.remove(c.runtimeType);

  void init();

  void update() => _components.values.forEach((Component c) => c.update());

  void bubbleDown(Message m) {
    Type type = m.runtimeType;
    if (_messageSwitch.containsKey(type)) {
      _messageSwitch[type].forEach((Component c) => c.onMessage(m));
    }
  }

  void bubbleUp(Message m) => this._game.queueMessage(m);
}
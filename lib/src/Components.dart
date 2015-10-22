library wod.Components;
import 'package:wod/src/Game.dart';
import 'package:wod/src/Messages.dart';

class ComponentFactory {
  List<Component> _components = new List();
}

abstract class Component {
  Game _game;
  List<Type> messageTypes = new List();

  Component(this._game);

  void update();

  onMessage(Message m);
  bubbleUp(Message m) => _game.queueMessage(m);
}

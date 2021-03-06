library wod.Entities;
import 'dart:collection';
import 'package:wod/Events/GameEvent.dart';
import 'package:wod/Components/GameComponent.dart';
import 'package:wod/Events/UpdateEvent.dart';

abstract class GameEntity {
  Queue<GameComponent> components = new Queue();
  Queue<GameEvent> events = new Queue();

  void registerComponent(GameComponent c) {
    if (!this.components.contains(c)) {
      c.entity = this;
      this.components.add(c);
    }
  }

  void queueEvent(GameEvent e) => this.events.add(e);

  void update() {
    this.queueEvent(new UpdateEvent());

    while (this.events.isNotEmpty) {
      this.components.forEach((GameComponent c) {
        c.listen(this.events.removeFirst());
      });
    }
  }
}
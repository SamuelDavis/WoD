library wod.Game;

import 'package:wod/src/Client.dart';
import 'dart:async';
import 'package:wod/src/Entity.dart';
import 'package:wod/src/System.dart';
import 'package:wod/src/Messages.dart';
import 'dart:collection';

class Game {
  static const Duration MS_PER_UPDATE = const Duration(milliseconds: 111);

  Queue<System> _systems = new Queue();
  Map<Client, GameEntity> _players = new Map();
  Queue<Message> _messages = new Queue(), _previousMessages = new Queue();

  SystemFactory _systemFactory = new SystemFactory();
  EntityFactory _entityFactory = new EntityFactory();

  void addSystem(System s) => _systems.add(s);

  void registerClient(Client client) {
    _players[client] = _entityFactory.nullEntity();
  }

  void run() {
    new Timer.periodic(MS_PER_UPDATE, (Timer t) => update());
  }

  void update() {
    _previousMessages = _messages;
    _messages.clear();
    _systems.forEach((System s) {
      _previousMessages.forEach((Message m) {
        if (s.interestedInMessage(m)) s.bubbleDown(m);
      });
      s.update();
    });
  }

  void queueMessage(Message m) => _messages.add(m);
}

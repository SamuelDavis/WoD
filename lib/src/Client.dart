library wodClient.Client;
import 'package:wodClient/src/Game.dart';
import 'dart:collection';
import 'dart:html';
import 'dart:async';
import 'package:wodClient/src/Assets.dart';

class Client {
  static const Duration RENDER_SLEEP = const Duration(milliseconds: 300);
  Game _game;
  DateTime _gameTimestamp, _clientTimestamp;
  Queue<ClientEvent> _events = new Queue();
  List<Asset> _floor = new List();
  List<Asset> _actors = new List();

  List<Asset> get assets => new List.from(_floor)
    ..addAll(_actors);

  CanvasElement _canvas;

  CanvasRenderingContext2D get ctx => _canvas.context2D;

  int get width => _canvas.width;

  int get height => _canvas.height;

  Client(int width, int height) {
    _canvas = new CanvasElement(width: width, height: height);
    ctx.fillStyle = Color.BLACK;
    document.onKeyDown.listen((KeyboardEvent e) => onKeyEvent(e, true));
    document.onKeyUp.listen((KeyboardEvent e) => onKeyEvent(e, false));
    document.body.append(_canvas);

    for (int y = 0; y < 100; y++) {
      for (int x = 0; x < 100; x++) {
        _floor.add(new FloorAsset(x, y));
      }
    }
  }

  void start(Game game) {
    _game = game;
    _game.registerClient(this);
    new Timer.periodic(RENDER_SLEEP, (Timer t) => render());
    _game.addCommand(new SpawnCommand());
  }

  void update(ClientData data) {
    _events.addAll(data.events);
    _gameTimestamp = data.timestamp;
  }

  void render() {
    _clientTimestamp = new DateTime.now();
    ctx.fillRect(0, 0, width, height);
    while (_events.isNotEmpty) {
      _handleEvent(_events.removeFirst());
    }
    assets.forEach((Asset asset) => asset.render(ctx));
    _renderTimestamps();
  }

  void _renderTimestamps() {
    Object fillStyle = ctx.fillStyle;
    ctx.fillStyle = Color.WHITE;
    String gameTimestamp = _gameTimestamp.toString();
    String clientTimestamp = _clientTimestamp.toString();
    ctx.fillText("Game: ${gameTimestamp}", width - gameTimestamp.length * 7 - 10, height - 20);
    ctx.fillText("Client: ${clientTimestamp}", width - clientTimestamp.length * 7 - 10, height - 10);
    ctx.fillStyle = fillStyle;
  }

  void onKeyEvent(KeyboardEvent e, bool isDown) {
  }

  void _handleEvent(ClientEvent event) {
    switch (event.runtimeType) {
      case SpawnPlayerEvent:
        handleSpawn(event as SpawnPlayerEvent);
        break;
    }
  }

  void handleSpawn(SpawnPlayerEvent event) => _actors.add(event.asset);
}

class ClientData {
  final Queue<ClientEvent> _events = new Queue();

  Queue get events => _events;

  final DateTime timestamp;

  ClientData(this.timestamp);
}

abstract class ClientCommand {
}

class SpawnCommand extends ClientCommand {
}
abstract class ClientEvent {
}

class SpawnPlayerEvent extends ClientEvent {
  final Asset asset;

  SpawnPlayerEvent() : asset = new PlayerAsset();
}

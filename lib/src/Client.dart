library wod.Client;
import 'dart:html';
import 'package:malison/malison.dart';
import 'package:wod/src/Game.dart';
import 'dart:async';

class Client {
  static const Duration MS_PER_RENDER = const Duration(milliseconds: 111);

  int width, height;
  CanvasElement canvas;
  RetroTerminal terminal;
  Game game;
  List<Renderable> _renderables = new List();

  Client(this.width, this.height, this.game) {
    canvas = new CanvasElement();
    document.onKeyDown.listen((KeyboardEvent e) => onKeyEvent(e, true));
    document.onKeyUp.listen((KeyboardEvent e) => onKeyEvent(e, false));
    document.body.append(canvas);
    terminal = new RetroTerminal.dos(width, height, canvas);
    game.registerClient(this);
    new Timer.periodic(MS_PER_RENDER, (Timer t) => render());
  }

  onKeyEvent(KeyboardEvent e, bool keyDown) {}

  void update(List<Renderable> renderables) {
    this._renderables = renderables;
  }

  void render() {
    terminal.clear();
    _renderables.forEach((Renderable renderable) => _renderRenderable(renderable));
    terminal.render();
  }

  _renderRenderable(Renderable renderable) {
//    var vector = renderable.vector;
//    if (vector != null) {
//      terminal.drawGlyph(vector.x, vector.y, Asset.forType(e));
//    }
  }
}

class Renderable {
}

class Asset {
//  static Glyph forType(thing) {
//    switch (thing.runtimeType) {
//      case Tile:
//        return getTile(thing);
//      case Player:
//        return new Glyph('@', Color.BLUE);
//    }
//
//    return new Glyph('?', Color.GREEN);
//  }
//
//  static Glyph getTile(Tile t) {
//    switch (t.type) {
//      case Tile.FLOOR:
//        return new Glyph('.');
//      case Tile.WALL:
//        return new Glyph('#', Color.GRAY);
//    }
//  }
}

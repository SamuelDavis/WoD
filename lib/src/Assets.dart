library wodClient.Assets;
import 'dart:math';
import 'dart:html';

class Color {
  static const BLACK = const Color('#000');
  static const WHITE = const Color('#fff');
  static const RED = const Color('rgb(220, 0, 0)');
  static const GREEN = const Color('rgb(0, 128, 0)');
  static const BLUE = const Color('rgb(0, 64, 255)');

  final String _value;

  const Color(this._value);

  String toString() => _value;
}

abstract class Asset {
  static Rectangle Tile(x, y, width, height) {
    return new Rectangle(x * width, y * height, width, height);
  }

  Rectangle _r;

  int get x => _r.topLeft.x;

  int get y => _r.topLeft.y;

  int get w => _r.width;

  int get h => _r.height;

  String get color => _color.toString();

  Color _color;

  Asset(this._r, this._color);

  void render(CanvasRenderingContext2D ctx) {
    Object fillStyle = ctx.fillStyle;
    ctx.fillStyle = this.color;
    ctx.fillRect(this.x, this.y, this.w, this.h);
    ctx.fillStyle = fillStyle;
  }
}

class FloorAsset extends Asset {
  FloorAsset(int x, int y) : super(Asset.Tile(x, y, 100, 100), Color.RED);
}

class PlayerAsset extends Asset {
  PlayerAsset() : super(Asset.Tile(0, 0, 100, 100), Color.GREEN);
}

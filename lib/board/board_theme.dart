import 'package:flutter/material.dart';
import 'package:wqhub/board/board_background.dart';
import 'package:wqhub/board/stone.dart';

@immutable
class BoardTheme {
  final String id;
  final BoardBackground background;
  final Stone blackStone;
  final Stone whiteStone;
  final Color lineColor;

  const BoardTheme({
    required this.id,
    required this.background,
    required this.blackStone,
    required this.whiteStone,
    required this.lineColor,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is BoardTheme &&
        other.id == id &&
        other.background == background &&
        other.blackStone == blackStone &&
        other.whiteStone == whiteStone &&
        other.lineColor == lineColor;
  }

  @override
  int get hashCode => Object.hash(background, blackStone, whiteStone);

  static const _imagesPath = 'assets/images';

  static const plain = BoardTheme(
    id: 'plain',
    background:
        SolidColorBoardBackground(color: Color.fromARGB(255, 218, 174, 92)),
    blackStone: SolidColorStone(color: Colors.black, border: false),
    whiteStone: SolidColorStone(color: Colors.white, border: false),
    lineColor: Colors.black,
  );

  static const green = BoardTheme(
    id: 'green',
    background:
        SolidColorBoardBackground(color: Color.fromARGB(170, 127, 150, 112)),
    blackStone: SolidColorStone(color: Colors.black, border: false),
    whiteStone: SolidColorStone(color: Colors.white, border: true),
    lineColor: Color(0xff89987f),
  );

  static const book = BoardTheme(
    id: 'book',
    background: SolidColorBoardBackground(color: Colors.white),
    blackStone: SolidColorStone(color: Colors.black, border: false),
    whiteStone: SolidColorStone(color: Colors.white, border: true),
    lineColor: Colors.black,
  );

  static const t101weiqi = BoardTheme(
    id: '101weiqi',
    background: ImageBoardBackground(
        image: AssetImage('$_imagesPath/board/101weiqi.png')),
    blackStone:
        ImageStone(image: AssetImage('$_imagesPath/stones/101weiqi_b.png')),
    whiteStone:
        ImageStone(image: AssetImage('$_imagesPath/stones/101weiqi_w.png')),
    lineColor: Colors.black,
  );

  static const fox = BoardTheme(
    id: 'fox',
    background:
        ImageBoardBackground(image: AssetImage('$_imagesPath/board/fox.png')),
    blackStone: ImageStone(image: AssetImage('$_imagesPath/stones/fox_b.png')),
    whiteStone: ImageStone(image: AssetImage('$_imagesPath/stones/fox_w.png')),
    lineColor: Colors.black,
  );

  static const foxOld = BoardTheme(
    id: 'fox_old',
    background: ImageBoardBackground(
        image: AssetImage('$_imagesPath/board/fox_old.png')),
    blackStone: ImageStone(image: AssetImage('$_imagesPath/stones/fox_b.png')),
    whiteStone: ImageStone(image: AssetImage('$_imagesPath/stones/fox_w.png')),
    lineColor: Colors.black,
  );

  static const foxMobile = BoardTheme(
    id: 'fox_mobile',
    background: ImageBoardBackground(
        image: AssetImage('$_imagesPath/board/fox_new.png')),
    blackStone:
        ImageStone(image: AssetImage('$_imagesPath/stones/fox_new_b.png')),
    whiteStone:
        ImageStone(image: AssetImage('$_imagesPath/stones/fox_new_w.png')),
    lineColor: Colors.black,
  );

  static const sabaki = BoardTheme(
    id: 'sabaki',
    background: ImageBoardBackground(
        image: AssetImage('$_imagesPath/board/sabaki.png')),
    blackStone:
        ImageStone(image: AssetImage('$_imagesPath/stones/sabaki_b.png')),
    whiteStone:
        ImageStone(image: AssetImage('$_imagesPath/stones/sabaki_w.png')),
    lineColor: Colors.black,
  );

  static const themes = {
    'plain': plain,
    'green': green,
    'book': book,
    '101weiqi': t101weiqi,
    'fox': fox,
    'fox_old': foxOld,
    'fox_mobile': foxMobile,
    'sabaki': sabaki,
  };
}

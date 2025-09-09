import 'package:flutter/material.dart';
import 'package:wqhub/board/board_background.dart';
import 'package:wqhub/board/stone.dart';

@immutable
class BoardTheme {
  final String id;
  final String displayName;
  final BoardBackground background;
  final Stone blackStone;
  final Stone whiteStone;
  final Color lineColor;

  const BoardTheme({
    required this.id,
    required this.displayName,
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
        other.displayName == displayName &&
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
    displayName: 'Plain',
    background:
        SolidColorBoardBackground(color: Color.fromARGB(255, 218, 174, 92)),
    blackStone: SolidColorStone(color: Colors.black, border: false),
    whiteStone: SolidColorStone(color: Colors.white, border: false),
    lineColor: Colors.black,
  );

  static const plainGradient = BoardTheme(
    id: 'plain_gradient',
    displayName: 'Plain with gradient',
    background:
        SolidColorBoardBackground(color: Color.fromARGB(255, 218, 174, 92)),
    blackStone: SolidColorStone(
      gradient: RadialGradient(
        center: AlignmentGeometry.xy(-0.5, -0.5),
        radius: 0.8,
        colors: <Color>[
          Color(0xff13251c),
          Colors.black,
        ],
      ),
      border: false,
    ),
    whiteStone: SolidColorStone(
      gradient: RadialGradient(
        center: AlignmentGeometry.xy(-0.5, -0.5),
        radius: 0.8,
        colors: <Color>[
          Colors.white,
          Color.fromARGB(255, 194, 194, 194),
        ],
      ),
      border: false,
    ),
    lineColor: Colors.black,
  );

  static const book = BoardTheme(
    id: 'book',
    displayName: 'Book',
    background: SolidColorBoardBackground(color: Colors.white),
    blackStone: SolidColorStone(color: Colors.black, border: false),
    whiteStone: SolidColorStone(color: Colors.white, border: true),
    lineColor: Colors.black,
  );

  static const t101weiqi = BoardTheme(
    id: '101weiqi',
    displayName: '101weiqi',
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
    displayName: 'Fox',
    background:
        ImageBoardBackground(image: AssetImage('$_imagesPath/board/fox.png')),
    blackStone: ImageStone(image: AssetImage('$_imagesPath/stones/fox_b.png')),
    whiteStone: ImageStone(image: AssetImage('$_imagesPath/stones/fox_w.png')),
    lineColor: Colors.black,
  );

  static const foxOld = BoardTheme(
    id: 'fox_old',
    displayName: 'Fox - legacy',
    background: ImageBoardBackground(
        image: AssetImage('$_imagesPath/board/fox_old.png')),
    blackStone: ImageStone(image: AssetImage('$_imagesPath/stones/fox_b.png')),
    whiteStone: ImageStone(image: AssetImage('$_imagesPath/stones/fox_w.png')),
    lineColor: Colors.black,
  );

  static const foxMobile = BoardTheme(
    id: 'fox_mobile',
    displayName: 'Fox - mobile',
    background: ImageBoardBackground(
        image: AssetImage('$_imagesPath/board/fox_new.png')),
    blackStone:
        ImageStone(image: AssetImage('$_imagesPath/stones/fox_new_b.png')),
    whiteStone:
        ImageStone(image: AssetImage('$_imagesPath/stones/fox_new_w.png')),
    lineColor: Colors.black,
  );

  static const badukTV = BoardTheme(
    id: 'badukTV',
    displayName: 'BadukTV',
    background: ImageBoardBackground(
        image: AssetImage('$_imagesPath/board/baduktv.png')),
    blackStone: ImageStone(image: AssetImage('$_imagesPath/stones/baduktv_b.png'), scale: 1.2,),
    whiteStone: ImageStone(image: AssetImage('$_imagesPath/stones/baduktv_w.png'), scale: 1.2,),
    lineColor: Colors.black,
  );

  static const sabaki = BoardTheme(
    id: 'sabaki',
    displayName: 'Sabaki',
    background: ImageBoardBackground(
        image: AssetImage('$_imagesPath/board/sabaki.png')),
    blackStone:
        ImageStone(image: AssetImage('$_imagesPath/stones/sabaki_b.png')),
    whiteStone:
        ImageStone(image: AssetImage('$_imagesPath/stones/sabaki_w.png')),
    lineColor: Colors.black,
  );

  static const goldenHane = BoardTheme(
    id: 'golden_hane',
    displayName: 'Golden Hane by Pumu',
    background:
        SolidColorBoardBackground(color: Color.fromARGB(255, 185, 133, 45)),
    blackStone:
        SolidColorStone(color: Color.fromARGB(255, 52, 45, 9), border: false),
    whiteStone: SolidColorStone(
        color: Color.fromARGB(255, 205, 194, 175), border: true),
    lineColor: Color.fromARGB(255, 216, 213, 197),
  );

  static const sepiaSente = BoardTheme(
    id: 'sepia_sente',
    displayName: 'Sepia Sente by Pumu',
    background:
        SolidColorBoardBackground(color: Color.fromARGB(255, 118, 114, 107)),
    blackStone:
        SolidColorStone(color: Color.fromARGB(255, 53, 46, 34), border: false),
    whiteStone: SolidColorStone(
        color: Color.fromARGB(255, 206, 201, 192), border: true),
    lineColor: Color.fromARGB(255, 216, 213, 197),
  );

  static const jumpingMoss = BoardTheme(
    id: 'jumping_moss',
    displayName: 'Jumping Moss by Pumu',
    background:
        SolidColorBoardBackground(color: Color.fromARGB(255, 125, 140, 115)),
    blackStone:
        SolidColorStone(color: Color.fromARGB(255, 39, 47, 34), border: false),
    whiteStone: SolidColorStone(
        color: Color.fromARGB(255, 225, 222, 203), border: true),
    lineColor: Color.fromARGB(255, 185, 183, 157),
  );

  static const jadeMonkey = BoardTheme(
    id: 'jade_monkey',
    displayName: 'Jade Monkey by Pumu',
    background:
        SolidColorBoardBackground(color: Color.fromARGB(255, 88, 132, 105)),
    blackStone:
        SolidColorStone(color: Color.fromARGB(255, 29, 68, 48), border: false),
    whiteStone: SolidColorStone(
        color: Color.fromARGB(255, 175, 197, 186), border: true),
    lineColor: Color.fromARGB(255, 161, 201, 175),
  );

  static const jadeWalrus = BoardTheme(
    id: 'jade_walrus',
    displayName: 'Jade Walrus by Pumu',
    background:
        SolidColorBoardBackground(color: Color.fromARGB(255, 88, 132, 105)),
    blackStone:
        SolidColorStone(color: Color.fromARGB(255, 11, 35, 23), border: false),
    whiteStone: SolidColorStone(
        color: Color.fromARGB(255, 214, 225, 219), border: true),
    lineColor: Color.fromARGB(255, 161, 201, 175),
  );

  static const themes = {
    'plain': plain,
    'plain_gradient': plainGradient,
    'book': book,
    '101weiqi': t101weiqi,
    'fox': fox,
    'fox_old': foxOld,
    'fox_mobile': foxMobile,
    'badukTV': badukTV,
    'sabaki': sabaki,
    'golden_hane': goldenHane,
    'sepia_sente': sepiaSente,
    'jumping_moss': jumpingMoss,
    'jade_monkey': jadeMonkey,
    'jade_walrus': jadeWalrus,
  };
}

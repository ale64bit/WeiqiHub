import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/widgets.dart';

enum CoordinateLabels {
  indices(
      labels: IListConst([
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18'
  ])),
  numbers(
      labels: IListConst([
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19'
  ])),
  alpha(
      labels: IListConst([
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S'
  ])),
  alphaNoI(
      labels: IListConst([
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T'
  ]));

  const CoordinateLabels({required this.labels});

  final IList<String> labels;
}

@immutable
class CoordinateStyle {
  const CoordinateStyle({
    required this.labels,
    this.reverse = false,
  });

  Iterable<String> labelsFor(int fullSize, int visibleSize, int offset) {
    final full = labels.labels.maxLength(fullSize);
    final ordered = reverse ? full.reversed : full;
    return ordered.skip(offset).take(visibleSize);
  }

  final CoordinateLabels labels;
  final bool reverse;
}

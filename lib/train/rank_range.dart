import 'package:wqhub/wq/rank.dart';

class RankRange {
  final Rank from;
  final Rank to;

  const RankRange({required this.from, required this.to});

  const RankRange.single(Rank rank)
      : from = rank,
        to = rank;

  bool isSingle() => from == to;

  @override
  String toString() =>
      from == to ? from.toString() : '${from.toString()}-${to.toString()}';
}

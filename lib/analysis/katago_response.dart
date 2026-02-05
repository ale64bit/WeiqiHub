import 'package:wqhub/generated/katago.pb.dart' as katagopb;
import 'package:wqhub/wq/wq.dart' as wq;

class RootInfo {
  final wq.Color currentPlayer;
  final double scoreLead;
  final double winrate;

  const RootInfo(
      {required this.currentPlayer,
      required this.scoreLead,
      required this.winrate});

  RootInfo.fromJson(Map<String, dynamic> json)
      : currentPlayer = wq.Color.fromString(json['currentPlayer'] as String)!,
        scoreLead = json['scoreLead'].toDouble(),
        winrate = json['winrate'].toDouble();

  RootInfo.fromProto(katagopb.Response_RootInfo info)
      : currentPlayer = wq.Color.fromString(info.currentPlayer)!,
        scoreLead = info.scoreLead,
        winrate = info.winrate;
}

class MoveInfo {
  final wq.Point? move;
  final int order;
  final double scoreLead;
  final double winrate;
  final List<wq.Point?> pv;
  final int visits;
  final List<double>? ownership;

  const MoveInfo({
    required this.move,
    required this.order,
    required this.scoreLead,
    required this.winrate,
    required this.pv,
    required this.visits,
    required this.ownership,
  });

  MoveInfo.fromJson(Map<String, dynamic> json, int boardSize)
      : move = _fromKataGoMove(json['move'] as String, boardSize),
        order = json['order'] as int,
        scoreLead = json['scoreLead'].toDouble(),
        winrate = json['winrate'].toDouble(),
        pv = [
          for (final p in (json['pv'] as List<dynamic>?) ?? [])
            _fromKataGoMove(p, boardSize)
        ],
        visits = json['visits'] as int,
        ownership = _from2DArray(json['ownership']);

  MoveInfo.fromProto(katagopb.Response_MoveInfo info, int boardSize)
      : move = _fromKataGoMove(info.move, boardSize),
        order = info.order,
        scoreLead = info.scoreLead,
        winrate = info.winrate,
        visits = info.visits,
        pv = [for (final mv in info.pv) _fromKataGoMove(mv, boardSize)],
        ownership = info.ownership;
}

class KataGoResponse {
  final String id;
  final bool isDuringSearch;
  final int turnNumber;
  final RootInfo rootInfo;
  final List<MoveInfo> moveInfos;
  final List<double>? policy;
  final List<double>? humanPolicy;
  final List<double>? ownership;

  const KataGoResponse(
      {required this.id,
      required this.isDuringSearch,
      required this.turnNumber,
      required this.rootInfo,
      required this.moveInfos,
      required this.policy,
      required this.humanPolicy,
      required this.ownership});

  KataGoResponse.fromJson(Map<String, dynamic> json, int boardSize)
      : id = json['id'] as String,
        isDuringSearch = (json['isDuringSearch'] as bool?) ?? false,
        turnNumber = json['turnNumber'] as int,
        rootInfo = RootInfo.fromJson(json['rootInfo'] as Map<String, dynamic>),
        moveInfos = [
          for (final info in (json['moveInfos'] as List<dynamic>))
            MoveInfo.fromJson(info as Map<String, dynamic>, boardSize)
        ],
        policy = _from2DArray(json['policy']),
        humanPolicy = _from2DArray(json['humanPolicy']),
        ownership = _from2DArray(json['ownership']);

  KataGoResponse.fromProto(katagopb.Response resp, int boardSize)
      : id = resp.id,
        isDuringSearch = resp.isDuringSearch,
        turnNumber = resp.turnNumber,
        rootInfo = RootInfo.fromProto(resp.rootInfo),
        moveInfos = [
          for (final info in resp.moveInfos) MoveInfo.fromProto(info, boardSize)
        ],
        policy = resp.policy,
        humanPolicy = resp.humanPolicy,
        ownership = resp.ownership;
}

wq.Point? _fromKataGoMove(String mv, int boardSize) {
  if (mv.isEmpty || mv == 'pass') return null;
  final row = boardSize - int.parse(mv.substring(1));
  var col = mv.codeUnitAt(0);
  if (col > 'I'.codeUnitAt(0)) col--;
  return (row, col - 'A'.codeUnitAt(0));
}

List<double>? _from2DArray(dynamic l) {
  if (l is List<dynamic>) {
    return [for (final li in l) (li is double) ? li : li.toDouble()];
  }
  return null;
}

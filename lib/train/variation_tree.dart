import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:petitparser/petitparser.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/symmetry.dart';
import 'package:wqhub/wq/wq.dart' as wq;

enum VariationStatus {
  correct,
  wrong;

  String toLocalizedString(AppLocalizations loc) => switch (this) {
        VariationStatus.correct => loc.taskCorrect,
        VariationStatus.wrong => loc.taskWrong,
      };
}

class VariationTree {
  static final _parser = _VariationTreeDefinition().build();

  final VariationStatus? status;
  final IMap<wq.Point, VariationTree> children;

  const VariationTree({required this.status, required this.children});
  factory VariationTree.parse(String vt) => _parser.parse(vt).value;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    return other is VariationTree &&
        other.status == status &&
        other.children == children;
  }

  @override
  int get hashCode => Object.hash(status, children.hashCode);

  VariationStatus finalStatus() =>
      status ??
      children.values.fold(
          VariationStatus.wrong,
          (cur, t) => t.finalStatus() == VariationStatus.correct
              ? VariationStatus.correct
              : cur);

  VariationTree withSymmetry(Symmetry symmetry, int boardSize) {
    if (symmetry == Symmetry.identity) {
      return this;
    }

    final transformedChildren =
        children.entries.fold<IMap<wq.Point, VariationTree>>(
      const IMap<wq.Point, VariationTree>.empty(),
      (acc, entry) {
        final transformedPoint = symmetry.transformPoint(entry.key, boardSize);
        final transformedChild = entry.value.withSymmetry(symmetry, boardSize);
        return acc.add(transformedPoint, transformedChild);
      },
    );

    return VariationTree(
      status: status,
      children: transformedChildren,
    );
  }

  String serialize() {
    assert((status == null) != (children.isEmpty));
    return switch (status) {
      null =>
        '${children.entries.map((e) => e.key.toSgf() + e.value.serialize()).join()}<',
      VariationStatus.correct => '0',
      VariationStatus.wrong => '1',
    };
  }
}

class _VariationTreeDefinition extends GrammarDefinition<VariationTree> {
  @override
  Parser<VariationTree> start() => [
        status(),
        edges(),
      ].toChoiceParser().map((obj) {
        if (obj is VariationStatus) {
          return VariationTree(status: obj, children: const IMap.empty());
        } else if (obj is List<(wq.Point, VariationTree)>) {
          return VariationTree(
              status: null,
              children:
                  IMap.fromEntries((obj).map((x) => MapEntry(x.$1, x.$2))));
        }
        throw FormatException('invalid parser result type');
      });

  Parser<List<(wq.Point, VariationTree)>> edges() =>
      edge().star().skip(after: char('<')).map((x) => x);

  Parser<(wq.Point, VariationTree)> edge() => (point() & ref0(start))
      .map((l) => (l[0] as wq.Point, l[1] as VariationTree));

  Parser<VariationStatus> status() =>
      [statusCorrect(), statusWrong()].toChoiceParser().map((x) => x);

  Parser<VariationStatus> statusCorrect() =>
      char('0').map((_) => VariationStatus.correct);

  Parser<VariationStatus> statusWrong() =>
      char('1').map((_) => VariationStatus.wrong);

  Parser<wq.Point> point() =>
      lowercase().times(2).map((xs) => wq.parseSgfPoint(xs.join()));
}

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wqhub/train/variation_tree.dart';

void main() {
  test('parse', () {
    final testTrees = [
      VariationTree(
        status: VariationStatus.correct,
        children: const IMap.empty(),
      ),
      VariationTree(
        status: VariationStatus.wrong,
        children: const IMap.empty(),
      ),
      VariationTree(
        status: null,
        children: IMap({
          (1, 2): VariationTree(
            status: VariationStatus.correct,
            children: const IMap.empty(),
          ),
        }),
      ),
      VariationTree(
        status: null,
        children: IMap({
          (1, 2): VariationTree(
            status: VariationStatus.correct,
            children: const IMap.empty(),
          ),
          (3, 4): VariationTree(
            status: null,
            children: IMap({
              (5, 6): VariationTree(
                status: VariationStatus.wrong,
                children: const IMap.empty(),
              ),
            }),
          ),
        }),
      ),
      VariationTree(
        status: null,
        children: IMap({
          (1, 2): VariationTree(
            status: null,
            children: IMap({
              (5, 6): VariationTree(
                status: VariationStatus.correct,
                children: const IMap.empty(),
              ),
            }),
          ),
          (3, 4): VariationTree(
            status: VariationStatus.wrong,
            children: const IMap.empty(),
          ),
        }),
      ),
    ];

    for (final vt in testTrees) {
      final data = vt.serialize();
      expect(VariationTree.parse(data), vt);
    }
  });
}

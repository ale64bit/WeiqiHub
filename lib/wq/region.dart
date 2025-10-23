import 'package:wqhub/wq/wq.dart';

void visitRegion(Point initial,
    {required bool Function(Point) shouldVisit,
    required void Function(Point) visit}) {
  dfs(Point p) {
    if (shouldVisit(p)) {
      final (r, c) = p;
      visit(p);
      dfs((r + 1, c));
      dfs((r - 1, c));
      dfs((r, c + 1));
      dfs((r, c - 1));
    }
  }

  dfs(initial);
}

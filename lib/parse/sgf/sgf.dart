import 'package:petitparser/petitparser.dart';

typedef SgfNode = Map<String, List<String>>;

class SgfTree {
  final List<SgfNode> nodes;
  final List<SgfTree> children;

  SgfTree({required this.nodes, required this.children});
}

class Sgf {
  final List<SgfTree> trees;
  static final _parser = _SgfDefinition().build();

  Sgf._({required this.trees});

  factory Sgf.parse(String sgf) => _parser.parse(sgf).value;
}

// See https://www.red-bean.com/sgf/sgf4.html
class _SgfDefinition extends GrammarDefinition {
  @override
  Parser<Sgf> start() => ref0(collection)
      .skip(before: ref0(space), after: ref0(space))
      .map((trees) => Sgf._(trees: trees));

  Parser<List<SgfTree>> collection() =>
      ref0(gameTree).plusSeparated(ref0(space)).map((l) => l.elements);

  Parser<SgfTree> gameTree() =>
      (ref0(nodeSeq) & ref0(gameTree).starSeparated(ref0(space)))
          .skip(before: char('(').trim(), after: char(')').trim())
          .map((l) => SgfTree(
                nodes: l[0],
                children: l[1].elements,
              ));

  Parser<List<SgfNode>> nodeSeq() =>
      ref0(node).plusSeparated(ref0(space)).map((r) => r.elements);

  Parser<SgfNode> node() =>
      (char(';') & ref0(prop).starSeparated(ref0(space))).map((l) {
        return {for (final (k, vs) in l[1].elements) k: vs};
      });

  Parser<(String, List<String>)> prop() =>
      (ref0(propIdent) & ref0(space) & ref0(propValues))
          .map((l) => (l[0], l[2]));

  Parser<String> propIdent() => (uppercase() & uppercase().star()).flatten();

  Parser<List<String>> propValues() =>
      ref0(propValue).plusSeparated(ref0(space)).map((sl) => sl.elements);

  Parser<String> propValue() =>
      ((char('\\') & char(']')).map((_) => ']') // handle escaped ]
              |
              (char(']').not() & any()).pick(1)) // any char except ]
          .star()
          .map((parts) => parts.join())
          .skip(before: char('['), after: char(']'));

  Parser<void> space() => (whitespace() | newline()).star();
}

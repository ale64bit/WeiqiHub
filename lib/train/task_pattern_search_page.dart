import 'package:extension_type_unions/extension_type_unions.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:wqhub/board/board.dart';
import 'package:wqhub/board/board_annotation.dart';
import 'package:wqhub/board/board_settings.dart';
import 'package:wqhub/input/rank_range_form_field.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/train/rank_range.dart';
import 'package:wqhub/train/task_pattern_search_results_page.dart';
import 'package:wqhub/train/task_type.dart';
import 'package:wqhub/wq/rank.dart';
import 'package:wqhub/wq/wq.dart' as wq;

class TaskPatternSearchPage extends StatefulWidget {
  static const routeName = '/train/task_pattern_search';

  @override
  State<TaskPatternSearchPage> createState() => _TaskPatternSearchPageState();
}

class _TaskPatternSearchPageState extends State<TaskPatternSearchPage> {
  final _formKey = GlobalKey<FormState>(debugLabel: 'task_pattern_search_page');
  var _boardSize = 13;
  wq.Color? _turn = wq.Color.black;
  var _stones = const IMap<wq.Point, wq.Color>.empty();
  var _empty = const ISet<wq.Point>.empty();
  var _rankRange = RankRange(from: Rank.k15, to: Rank.d7);
  var _selectedTaskTypes = ISet(TaskType.values);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final boardSettings = BoardSettings(
      size: _boardSize,
      theme: context.settings.boardTheme,
      edgeLine: context.settings.edgeLine,
      stoneShadows: context.settings.stoneShadows,
    );
    final annotations = IMapOfSets.from(IMap({
      for (final p in _empty)
        p: ISet({
          (
            type: AnnotationShape.circle.u21,
            color: Colors.blueAccent,
          )
        })
    }));
    final board = LayoutBuilder(
      builder: (context, constraints) {
        final boardSize = constraints.biggest.shortestSide -
            2 * (boardSettings.border?.size ?? 0);
        return Board(
          size: boardSize,
          settings: boardSettings,
          onPointClicked: _onPointClicked,
          turn: _turn,
          stones: _stones,
          annotations: annotations,
          confirmTap: context.settings.confirmMoves,
        );
      },
    );
    final boardSizeSegmentedButton = SegmentedButton(
      segments: <ButtonSegment<int>>[
        ButtonSegment<int>(
          value: 9,
          label: Text(loc.nxnBoardSize(9)),
        ),
        ButtonSegment<int>(
          value: 13,
          label: Text(loc.nxnBoardSize(13)),
        ),
        ButtonSegment<int>(
          value: 19,
          label: Text(loc.nxnBoardSize(19)),
        ),
      ],
      selected: <int>{_boardSize},
      onSelectionChanged: (Set<int> newSelection) {
        setState(() {
          _boardSize = newSelection.first;
          _stones = const IMap.empty();
          _empty = const ISet.empty();
        });
      },
    );
    final turnSegmentedButton = SegmentedButton(
      segments: <ButtonSegment<wq.Color?>>[
        ButtonSegment<wq.Color?>(
          value: wq.Color.black,
          label: Text(loc.black),
        ),
        ButtonSegment<wq.Color?>(
          value: wq.Color.white,
          label: Text(loc.white),
        ),
        ButtonSegment<wq.Color?>(
          value: null,
          label: Text(loc.empty),
        ),
      ],
      selected: <wq.Color?>{_turn},
      onSelectionChanged: (Set<wq.Color?> newSelection) {
        setState(() {
          _turn = newSelection.first;
        });
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.findTask),
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.clear),
            label: const Text('Clear'),
            onPressed: () {
              setState(() {
                _stones = const IMap.empty();
                _empty = const ISet.empty();
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 600),
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  spacing: 8.0,
                  children: <Widget>[
                    boardSizeSegmentedButton,
                    turnSegmentedButton,
                    board,
                    RankRangeFormField(
                      initialValue: _rankRange,
                      validator: (rankRange) {
                        if (rankRange!.from.index > rankRange.to.index) {
                          return 'Min rank must be less or equal than max rank';
                        }
                        return null;
                      },
                      onChanged: (RankRange newRange) {
                        setState(() {
                          _rankRange = newRange;
                        });
                      },
                    ),
                    Wrap(
                      spacing: 4.0,
                      runSpacing: 4.0,
                      children: [
                        for (final taskType in TaskType.values)
                          FilterChip(
                            label: Text(taskType.toLocalizedString(loc)),
                            selected: _selectedTaskTypes.contains(taskType),
                            onSelected: (bool selected) {
                              setState(() {
                                if (selected)
                                  _selectedTaskTypes =
                                      _selectedTaskTypes.add(taskType);
                                else
                                  _selectedTaskTypes =
                                      _selectedTaskTypes.remove(taskType);
                              });
                            },
                          )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 400),
            child: Row(
              children: [
                Expanded(
                  child: FilledButton(
                    child: Text(loc.find),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.of(context).pushNamed(
                          TaskPatternSearchResultsPage.routeName,
                          arguments: TaskPatternSearchResultsRouteArguments(
                            rankRange: _rankRange,
                            taskTypes: _selectedTaskTypes,
                            stones: _stones,
                            empty: _empty,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text(
                                'Invalid task search settings. Please fix the errors.'),
                            showCloseIcon: true,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onPointClicked(wq.Point p) {
    setState(() {
      if (_turn == null) {
        _stones = _stones.remove(p);
        _empty = _empty.toggle(p);
      } else {
        _empty = _empty.remove(p);
        if (_stones.contains(p, _turn!))
          _stones = _stones.remove(p);
        else
          _stones = _stones.add(p, _turn!);
      }
    });
  }
}

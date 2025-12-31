import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:wqhub/input/duration_form_field.dart';
import 'package:wqhub/input/int_form_field.dart';
import 'package:wqhub/input/rank_range_form_field.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/pop_aware_state.dart';
import 'package:wqhub/stats/stats_db.dart';
import 'package:wqhub/train/custom_exam_page.dart';
import 'package:wqhub/train/rank_range.dart';
import 'package:wqhub/train/task_repository.dart';
import 'package:wqhub/train/task_source/task_source_type.dart';
import 'package:wqhub/train/task_tag.dart';
import 'package:wqhub/train/task_type.dart';
import 'package:wqhub/wq/rank.dart';

class CustomExamSelectionPage extends StatefulWidget {
  static const routeName = '/train/custom_exam_selection';

  const CustomExamSelectionPage({super.key});

  @override
  State<CustomExamSelectionPage> createState() =>
      _CustomExamSelectionPageState();
}

class _CustomExamSelectionPageState
    extends PopAwareState<CustomExamSelectionPage> {
  final _formKey =
      GlobalKey<FormState>(debugLabel: 'custom_exam_selection_page');
  var _taskCount = 10;
  var _maxMistakes = 2;
  var _timePerTask = Duration(seconds: 45);
  var _collectStats = true;
  var _rankRange = RankRange(from: Rank.k15, to: Rank.d7);
  var _taskSourceType = TaskSourceType.values.first;
  final _selectedTaskTypes = {TaskType.lifeAndDeath, TaskType.tesuji};
  var _tag = TaskTag.beginner;
  var _subtag = TaskTag.captureInOneMove;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final taskCount = availableTasks();
    final availableTasksText = Text(loc.nTasksAvailable(taskCount));
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.customExam),
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
                    IntFormField(
                      label: loc.numberOfTasks,
                      initialValue: _taskCount,
                      minValue: 1,
                      maxValue: 1000,
                      onChanged: (value) {
                        _taskCount = value;
                      },
                    ),
                    IntFormField(
                      label: loc.maxNumberOfMistakes,
                      initialValue: _maxMistakes,
                      minValue: 0,
                      maxValue: 1 << 30,
                      onChanged: (value) {
                        _maxMistakes = value;
                      },
                    ),
                    DurationFormField(
                      label: loc.timePerTask,
                      initialValue: _timePerTask,
                      validator: (duration) {
                        if (duration! == Duration.zero) {
                          return 'Must be greater than zero';
                        }
                        if (duration <= Duration.zero) {
                          return 'Must be positive';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _timePerTask = value;
                      },
                    ),
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
                    DropdownButtonFormField<TaskSourceType>(
                      initialValue: _taskSourceType,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: loc.taskSource,
                      ),
                      items: [
                        for (final value in TaskSourceType.values)
                          DropdownMenuItem(
                            value: value,
                            child: Text(value.toLocalizedString(loc)),
                          ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _taskSourceType = value;
                          });
                        }
                      },
                    ),
                    ...switch (_taskSourceType) {
                      TaskSourceType.fromTaskTypes => <Widget>[
                          Wrap(
                            spacing: 4.0,
                            runSpacing: 4.0,
                            children: [
                              for (final taskType in TaskType.values)
                                FilterChip(
                                  label: Text(taskType.toLocalizedString(loc)),
                                  selected:
                                      _selectedTaskTypes.contains(taskType),
                                  onSelected: (bool selected) {
                                    setState(() {
                                      if (selected) {
                                        _selectedTaskTypes.add(taskType);
                                      } else {
                                        _selectedTaskTypes.remove(taskType);
                                      }
                                    });
                                  },
                                )
                            ],
                          ),
                          availableTasksText,
                        ],
                      TaskSourceType.fromTaskTag => <Widget>[
                          DropdownButtonFormField<TaskTag>(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: loc.topic,
                            ),
                            initialValue: _tag,
                            items: [
                              for (final tag in TaskTag.values
                                  .where((t) => t.subtags().isNotEmpty))
                                DropdownMenuItem(
                                  value: tag,
                                  child: Text(tag.toLocalizedString(loc)),
                                )
                            ],
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  _tag = value;
                                  _subtag = _tag.subtags().first;
                                });
                              }
                            },
                          ),
                          DropdownButtonFormField<TaskTag>(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: loc.subtopic,
                            ),
                            initialValue: _subtag,
                            items: [
                              for (final tag in _tag
                                  .subtags()
                                  .where((t) => t.ranks().isNotEmpty))
                                DropdownMenuItem(
                                  value: tag,
                                  child: Text(tag.toLocalizedString(loc)),
                                )
                            ],
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  _subtag = value;
                                });
                              }
                            },
                          ),
                          availableTasksText,
                        ],
                      TaskSourceType.fromMistakes => <Widget>[
                          availableTasksText,
                        ],
                    },
                    CheckboxListTile(
                      title: Text(loc.collectStats),
                      value: _collectStats,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _collectStats = value;
                          });
                        }
                      },
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
                    onPressed: taskCount == 0
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.pushNamed(
                                context,
                                CustomExamPage.routeName,
                                arguments: CustomExamRouteArguments(
                                  taskCount: _taskCount,
                                  timePerTask: _timePerTask,
                                  rankRange: _rankRange,
                                  maxMistakes: _maxMistakes,
                                  taskSourceType: _taskSourceType,
                                  taskTypes: ISet(_selectedTaskTypes),
                                  taskTag: _subtag,
                                  collectStats: _collectStats,
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                      'Invalid exam settings. Please fix the errors.'),
                                  showCloseIcon: true,
                                ),
                              );
                            }
                          },
                    child: Text(loc.start),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int availableTasks() => switch (_taskSourceType) {
        TaskSourceType.fromTaskTypes =>
          TaskRepository().countByTypes(_rankRange, ISet(_selectedTaskTypes)),
        TaskSourceType.fromTaskTag =>
          TaskRepository().countByTag(_rankRange, _subtag),
        TaskSourceType.fromMistakes =>
          StatsDB().countMistakesByRange(_rankRange),
      };
}

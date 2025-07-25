import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:wqhub/input/duration_form_field.dart';
import 'package:wqhub/input/int_form_field.dart';
import 'package:wqhub/input/rank_range_form_field.dart';
import 'package:wqhub/stats/stats_db.dart';
import 'package:wqhub/train/custom_exam_page.dart';
import 'package:wqhub/train/rank_range.dart';
import 'package:wqhub/train/task_repository.dart';
import 'package:wqhub/train/task_source/task_source_type.dart';
import 'package:wqhub/train/task_tag.dart';
import 'package:wqhub/train/task_type.dart';
import 'package:wqhub/wq/rank.dart';

class CustomExamSelectionPage extends StatefulWidget {
  @override
  State<CustomExamSelectionPage> createState() =>
      _CustomExamSelectionPageState();
}

class _CustomExamSelectionPageState extends State<CustomExamSelectionPage> {
  final _formKey = GlobalKey<FormState>();
  var _taskCount = 10;
  var _maxMistakes = 2;
  var _timePerTask = Duration(seconds: 45);
  var _collectStats = true;
  var _rankRange = RankRange(from: Rank.k15, to: Rank.d7);
  var _taskSourceType = TaskSourceType.values.first;
  var _selectedTaskTypes = {TaskType.lifeAndDeath, TaskType.tesuji};
  var _tag = TaskTag.beginner;
  var _subtag = TaskTag.captureInOneMove;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom exam'),
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
                      label: 'Number of tasks',
                      initialValue: _taskCount,
                      minValue: 1,
                      maxValue: 1000,
                      onChanged: (value) {
                        _taskCount = value;
                      },
                    ),
                    IntFormField(
                      label: 'Maximum number of mistakes',
                      initialValue: _maxMistakes,
                      minValue: 0,
                      maxValue: 1 << 30,
                      onChanged: (value) {
                        _maxMistakes = value;
                      },
                    ),
                    DurationFormField(
                      label: 'Time per task',
                      initialValue: _timePerTask,
                      validator: (duration) {
                        if (duration! == Duration.zero)
                          return 'Must be greater than zero';
                        if (duration <= Duration.zero)
                          return 'Must be positive';
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
                      value: _taskSourceType,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Task source',
                      ),
                      items: [
                        for (final value in TaskSourceType.values)
                          DropdownMenuItem(
                            value: value,
                            child: Text(value.description),
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
                                  label: Text(taskType.toString()),
                                  selected:
                                      _selectedTaskTypes.contains(taskType),
                                  onSelected: (bool selected) {
                                    setState(() {
                                      if (selected)
                                        _selectedTaskTypes.add(taskType);
                                      else
                                        _selectedTaskTypes.remove(taskType);
                                    });
                                  },
                                )
                            ],
                          ),
                          Text(
                              '${TaskRepository().countByTypes(_rankRange, ISet(_selectedTaskTypes))} tasks available'),
                        ],
                      TaskSourceType.fromTaskTag => <Widget>[
                          DropdownButtonFormField<TaskTag>(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Topic',
                            ),
                            value: _tag,
                            items: [
                              for (final tag in TaskTag.values
                                  .where((t) => t.subtags().isNotEmpty))
                                DropdownMenuItem(
                                  value: tag,
                                  child: Text(tag.toString()),
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
                              labelText: 'Subtopic',
                            ),
                            value: _subtag,
                            items: [
                              for (final tag in _tag
                                  .subtags()
                                  .where((t) => t.ranks().isNotEmpty))
                                DropdownMenuItem(
                                  value: tag,
                                  child: Text(tag.toString()),
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
                          Text(
                              '${TaskRepository().countByTag(_rankRange, _subtag)} tasks available'),
                        ],
                      TaskSourceType.fromMistakes => <Widget>[
                          Text(
                              '${StatsDB().countMistakesByRange(_rankRange)} tasks available'),
                        ],
                    },
                    CheckboxListTile(
                      title: const Text('Collect statistics'),
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
                    child: const Text('Start'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PopScope(
                              canPop: false,
                              child: CustomExamPage(
                                taskCount: _taskCount,
                                timePerTask: _timePerTask,
                                rankRange: _rankRange,
                                maxMistakes: _maxMistakes,
                                taskSourceType: _taskSourceType,
                                taskTypes: ISet(_selectedTaskTypes),
                                taskTag: _subtag,
                                collectStats: _collectStats,
                              ),
                            ),
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

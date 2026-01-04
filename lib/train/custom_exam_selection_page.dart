import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:wqhub/confirm_dialog.dart';
import 'package:wqhub/input/duration_form_field.dart';
import 'package:wqhub/input/int_form_field.dart';
import 'package:wqhub/input/rank_range_form_field.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/pop_aware_state.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/stats/stats_db.dart';
import 'package:wqhub/text_input_dialog.dart';
import 'package:wqhub/train/custom_exam_page.dart';
import 'package:wqhub/train/custom_exam_presets.dart';
import 'package:wqhub/train/custom_exam_settings.dart';
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
  final _taskCountKey = GlobalKey<FormFieldState<String>>(
      debugLabel: 'custom_exam_selection_page.task_count');
  final _maxMistakesKey = GlobalKey<FormFieldState<String>>(
      debugLabel: 'custom_exam_selection_page.max_mistakes');
  final _timePerTaskMinKey = GlobalKey<FormFieldState<String>>(
      debugLabel: 'custom_exam_selection_page.time_per_task.min');
  final _timePerTaskSecKey = GlobalKey<FormFieldState<String>>(
      debugLabel: 'custom_exam_selection_page.time_per_task.sec');
  final _rankRangeKey = GlobalKey<FormFieldState<RankRange>>(
      debugLabel: 'custom_exam_selection_page.rank_range');

  var _taskCount = 10;
  var _maxMistakes = 2;
  var _timePerTask = Duration(seconds: 45);
  var _rankRange = RankRange(from: Rank.k15, to: Rank.d7);
  var _taskSourceType = TaskSourceType.values.first;
  final _taskTypes = {TaskType.lifeAndDeath, TaskType.tesuji};
  var _tag = TaskTag.beginner;
  final _subtags = TaskTag.beginner.subtags().toSet();
  var _collectStats = true;
  var _presets = CustomExamPresets.empty();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _presets = context.settings.customExamPresets;
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final taskCount = availableTasks();
    final availableTasksText = Text(loc.nTasksAvailable(taskCount));
    final presetDrawer = NavigationDrawer(
      header: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          loc.presets,
          style: TextTheme.of(context).titleLarge,
        ),
      ),
      children: [
        for (final e in _presets.presets.entries)
          ListTile(
            title: Text(e.key),
            trailing: IconButton(
              onPressed: () async {
                final confirmDelete = await showDialog<bool>(
                  context: context,
                  builder: (context) => ConfirmDialog(
                    title: loc.confirm,
                    content: loc.msgConfirmDeletePreset,
                    onYes: () => Navigator.pop(context, true),
                    onNo: () => Navigator.pop(context, false),
                  ),
                );
                if (confirmDelete ?? false) {
                  setState(() {
                    _presets.presets.remove(e.key);
                  });
                  if (context.mounted) {
                    context.settings.customExamPresets = _presets;
                  }
                }
              },
              icon: Icon(Icons.delete),
            ),
            onTap: () {
              setState(() {
                _taskCount = e.value.taskCount;
                _taskCountKey.currentState?.didChange(_taskCount.toString());
                _maxMistakes = e.value.maxMistakes;
                _maxMistakesKey.currentState
                    ?.didChange(_maxMistakes.toString());
                _timePerTask = e.value.timePerTask;
                _timePerTaskMinKey.currentState
                    ?.didChange(_timePerTask.inMinutes.toString());
                _timePerTaskSecKey.currentState
                    ?.didChange((_timePerTask.inSeconds % 60).toString());
                _rankRange = e.value.rankRange;
                _rankRangeKey.currentState?.didChange(_rankRange);

                _taskSourceType = e.value.taskSourceType;
                if (e.value.taskTypes != null) {
                  _taskTypes.clear();
                  _taskTypes.addAll(e.value.taskTypes!);
                }
                if (e.value.taskTag != null) {
                  _tag = e.value.taskTag!;
                  _subtags.clear();
                  if (e.value.taskSubtags != null) {
                    _subtags.addAll(e.value.taskSubtags!);
                  } else {
                    _subtags.addAll(_tag.subtags());
                  }
                }
                _collectStats = e.value.collectStats;
              });
              Navigator.pop(context);
            },
          ),
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.customExam),
      ),
      endDrawer: presetDrawer,
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
                    intFormField(
                      context,
                      key: _taskCountKey,
                      initialValue: _taskCount,
                      label: loc.numberOfTasks,
                      minValue: 1,
                      maxValue: 1000,
                      onChanged: (value) {
                        _taskCount = value;
                      },
                    ),
                    intFormField(
                      context,
                      key: _maxMistakesKey,
                      initialValue: _maxMistakes,
                      label: loc.maxNumberOfMistakes,
                      minValue: 0,
                      maxValue: 1 << 30,
                      onChanged: (value) {
                        _maxMistakes = value;
                      },
                    ),
                    DurationFormField(
                      minKey: _timePerTaskMinKey,
                      secKey: _timePerTaskSecKey,
                      initialValue: _timePerTask,
                      label: loc.timePerTask,
                      validator: (duration) {
                        if (duration != null && duration == Duration.zero) {
                          return 'Must be greater than zero';
                        }
                        if (duration != null && duration <= Duration.zero) {
                          return 'Must be positive';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _timePerTask = value;
                      },
                    ),
                    RankRangeFormField(
                      key: _rankRangeKey,
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
                            alignment: WrapAlignment.center,
                            children: [
                              for (final taskType in TaskType.values)
                                FilterChip(
                                  label: Text(taskType.toLocalizedString(loc)),
                                  selected: _taskTypes.contains(taskType),
                                  onSelected: (bool selected) {
                                    setState(() {
                                      if (selected) {
                                        _taskTypes.add(taskType);
                                      } else {
                                        _taskTypes.remove(taskType);
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
                                  _subtags.clear();
                                  _subtags.addAll(_tag.subtags());
                                });
                              }
                            },
                          ),
                          Row(
                            spacing: 8.0,
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed:
                                      _subtags.length < _tag.subtags().length
                                          ? () {
                                              setState(() {
                                                _subtags.clear();
                                                _subtags.addAll(_tag.subtags());
                                              });
                                            }
                                          : null,
                                  icon: Icon(Icons.done_all),
                                  label: Text(loc.selectAll),
                                ),
                              ),
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: _subtags.isNotEmpty
                                      ? () {
                                          setState(() {
                                            _subtags.clear();
                                          });
                                        }
                                      : null,
                                  icon: Icon(Icons.clear_all),
                                  label: Text(loc.deselectAll),
                                ),
                              ),
                            ],
                          ),
                          Wrap(
                            spacing: 4.0,
                            runSpacing: 4.0,
                            alignment: WrapAlignment.center,
                            children: [
                              for (final subtag in _tag.subtags())
                                FilterChip(
                                  label: Text(subtag.toLocalizedString(loc)),
                                  selected: _subtags.contains(subtag),
                                  onSelected: (bool selected) {
                                    setState(() {
                                      if (selected) {
                                        _subtags.add(subtag);
                                      } else {
                                        _subtags.remove(subtag);
                                      }
                                    });
                                  },
                                )
                            ],
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
              spacing: 8.0,
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: taskCount == 0
                        ? null
                        : () async {
                            final name = await showDialog<String>(
                              context: context,
                              builder: (context) => TextInputDialog(
                                title: loc.confirm,
                                content: loc.presetName,
                                maxLength: 40,
                              ),
                            );
                            if (_presets.presets.containsKey(name)) {
                              if (context.mounted) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text(loc.error),
                                    content: Text(loc.msgPresetAlreadyExists),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text(loc.ok),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            } else if (name?.isNotEmpty ?? false) {
                              setState(() {
                                _presets.presets[name!] = _currentSettings();
                              });
                              if (context.mounted) {
                                context.settings.customExamPresets = _presets;
                              }
                            }
                          },
                    child: Text(loc.savePreset),
                  ),
                ),
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
                                  settings: _currentSettings(),
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

  CustomExamSettings _currentSettings() => CustomExamSettings(
        taskCount: _taskCount,
        timePerTask: _timePerTask,
        rankRange: _rankRange,
        maxMistakes: _maxMistakes,
        taskSourceType: _taskSourceType,
        taskTypes: ISet(_taskTypes),
        taskTag: _tag,
        taskSubtags: ISet(_subtags),
        collectStats: _collectStats,
      );

  int availableTasks() => switch (_taskSourceType) {
        TaskSourceType.fromTaskTypes =>
          TaskRepository().countByTypes(_rankRange, _taskTypes),
        TaskSourceType.fromTaskTag =>
          TaskRepository().approxCountByTags(_rankRange, _subtags),
        TaskSourceType.fromMistakes =>
          StatsDB().countMistakesByRange(_rankRange),
      };
}

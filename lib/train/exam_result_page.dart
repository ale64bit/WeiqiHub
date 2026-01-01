import 'package:flutter/material.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/stats/stats_db.dart';
import 'package:wqhub/train/task_preview_tile.dart';
import 'package:wqhub/train/task_repository.dart';
import 'package:wqhub/vertical_icon_button.dart';
import 'package:wqhub/window_class_aware_state.dart';

class ExamResultRouteArguments {
  const ExamResultRouteArguments({
    required this.event,
    required this.totalTime,
    required this.passed,
    required this.taskCount,
    required this.mistakeCount,
    required this.completedTasks,
    required this.onRedo,
    required this.onNext,
  });

  final ExamEvent event;
  final Duration totalTime;
  final bool passed;
  final int taskCount;
  final int mistakeCount;
  final List<(TaskRef, bool)> completedTasks;
  final Function(BuildContext) onRedo;
  final Function(BuildContext)? onNext;
}

class ExamResultPage extends StatefulWidget {
  static const routeName = '/train/exam_result';

  const ExamResultPage(
      {super.key,
      required this.event,
      required this.totalTime,
      required this.passed,
      required this.taskCount,
      required this.mistakeCount,
      required this.completedTasks,
      required this.onRedo,
      required this.onNext});

  final ExamEvent event;
  final Duration totalTime;
  final bool passed;
  final int taskCount;
  final int mistakeCount;
  final List<(TaskRef, bool)> completedTasks;
  final Function(BuildContext) onRedo;
  final Function(BuildContext)? onNext;

  @override
  State<ExamResultPage> createState() => _ExamResultPageState();
}

class _ExamResultPageState extends WindowClassAwareState<ExamResultPage> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final successRate =
        (100 * (widget.taskCount - widget.mistakeCount) / widget.taskCount)
            .toInt();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event.toLocalizedString(loc)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: Card(
            child: ListTile(
              leading: switch (widget.passed) {
                true => Icon(Icons.mood, color: Colors.green),
                false => Icon(Icons.mood_bad, color: Colors.red),
              },
              title:
                  Text(widget.passed ? loc.trainingPassed : loc.trainingFailed),
              subtitle: Text(
                  '${widget.taskCount - widget.mistakeCount} / ${widget.taskCount} ($successRate%)'),
              trailing: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    widget.totalTime.toString().substring(2, 7),
                    style: TextTheme.of(context).headlineSmall,
                  ),
                  Text(
                      '${loc.sSeconds((widget.totalTime.inSeconds / widget.taskCount).round())} ${loc.perTask}')
                ],
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 800),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: switch (windowClass) {
                WindowClass.compact => 3,
                WindowClass.medium => 5,
                WindowClass.expanded => 6,
                WindowClass.large => 6,
                WindowClass.extraLarge => 6,
              },
            ),
            itemCount: widget.completedTasks.length,
            itemBuilder: (context, index) {
              final (ref, solved) = widget.completedTasks[index];
              return TaskPreviewTile(
                task: ref,
                solved: solved,
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: VerticalIconButton(
                icon: Icon(Icons.repeat),
                label: loc.taskRedo,
                onTap: () => widget.onRedo(context),
              ),
            ),
            if (widget.onNext != null)
              Expanded(
                child: VerticalIconButton(
                  icon: Icon(Icons.skip_next),
                  label: loc.taskNext,
                  onTap: () => widget.onNext!(context),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

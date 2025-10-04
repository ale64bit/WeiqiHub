import 'package:flutter/material.dart';
import 'package:wqhub/pop_aware_state.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/train/circular_percent_text.dart';
import 'package:wqhub/train/task_tag.dart';

class TagCompletionRate extends StatefulWidget {
  final TaskTag tag;

  const TagCompletionRate({super.key, required this.tag});

  @override
  State<TagCompletionRate> createState() => _TagCompletionRateState();
}

class _TagCompletionRateState extends PopAwareState<TagCompletionRate> {
  Future<int>? completionRateFut;

  @override
  void initState() {
    _updateFut();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateFut();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: completionRateFut,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final completionRate = snapshot.data ?? 0;
          return CircularPercentText(value: completionRate);
        }
        return CircularProgressIndicator();
      },
    );
  }

  (int, int) compute(BuildContext context, TaskTag tag) {
    var total = 0;
    var passed = 0;
    final rankRanges = tag.ranks();
    for (final rankRange in rankRanges) {
      final pass = context.stats.getTagExamPassCount(tag, rankRange);
      total++;
      if (pass > 0) passed++;
    }
    for (final subtag in tag.subtags()) {
      final (t, p) = compute(context, subtag);
      total += t;
      passed += p;
    }
    return (total, passed);
  }

  _updateFut() {
    completionRateFut = Future(() {
      final (total, passed) = compute(context, widget.tag);
      return (100 * passed / total).floor();
    });
  }
}

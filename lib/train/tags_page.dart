import 'package:flutter/material.dart';
import 'package:wqhub/train/subtags_page.dart';
import 'package:wqhub/train/tag_completion_rate.dart';
import 'package:wqhub/train/task_tag.dart';

class TagsPage extends StatelessWidget {
  static const routeName = '/train/tags';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Topics'),
      ),
      body: Center(
        child: ListView(
          children: [
            _TagTile(tag: TaskTag.beginner),
            Divider(height: 4),
            _TagTile(tag: TaskTag.capturingTechniques),
            _TagTile(tag: TaskTag.capturingRace),
            Divider(height: 4),
            _TagTile(tag: TaskTag.basicLifeAndDeath),
            _TagTile(tag: TaskTag.lifeAndDeath),
            _TagTile(tag: TaskTag.commonLifeAndDeath),
            Divider(height: 4),
            _TagTile(tag: TaskTag.basicTesuji),
            Divider(height: 4),
            _TagTile(tag: TaskTag.opening),
            _TagTile(tag: TaskTag.middlegame),
            _TagTile(tag: TaskTag.basicEndgame),
            _TagTile(tag: TaskTag.endgame),
            Divider(height: 4),
            _TagTile(tag: TaskTag.comprehensiveTasks),
            _TagTile(tag: TaskTag.interestingTasks),
          ],
        ),
      ),
    );
  }
}

class _TagTile extends StatelessWidget {
  final TaskTag tag;

  const _TagTile({required this.tag});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(tag.toString()),
      trailing: TagCompletionRate(tag: tag),
      onTap: () {
        Navigator.pushNamed(
          context,
          SubtagsPage.routeName,
          arguments: SubtagsRouteArguments(tag: tag),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:wqhub/train/subtag_rank_selection_page.dart';
import 'package:wqhub/train/tag_completion_rate.dart';
import 'package:wqhub/train/task_tag.dart';

class SubtagsRouteArguments {
  final TaskTag tag;

  const SubtagsRouteArguments({required this.tag});
}

class SubtagsPage extends StatelessWidget {
  static const routeName = '/train/subtags';

  final TaskTag tag;

  const SubtagsPage({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tag.toString()),
      ),
      body: Center(
        child: ListView(
          children: [
            for (final subtag in tag.subtags())
              if (subtag.ranks().isNotEmpty)
                ListTile(
                  title: Text(subtag.toString()),
                  trailing: TagCompletionRate(tag: subtag),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      SubtagRankSelectionPage.routeName,
                      arguments:
                          SubtagRankSelectionRouteArguments(subtag: subtag),
                    );
                  },
                )
          ],
        ),
      ),
    );
  }
}

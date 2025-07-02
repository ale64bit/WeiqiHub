import 'package:flutter/material.dart';
import 'package:wqhub/train/subtag_rank_selection_page.dart';
import 'package:wqhub/train/tag_completion_rate.dart';
import 'package:wqhub/train/task_tag.dart';

class SubtagsPage extends StatelessWidget {
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SubtagRankSelectionPage(subtag: subtag),
                      ),
                    );
                  },
                )
          ],
        ),
      ),
    );
  }
}

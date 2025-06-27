import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wqhub/audio/audio_controller.dart';
import 'package:wqhub/settings/settings.dart';
import 'package:wqhub/settings/shared_preferences_inherited_widget.dart';
import 'package:wqhub/stats/stats_db.dart';
import 'package:wqhub/train/task_repository.dart';
import 'package:wqhub/weiqi_hub_app.dart';

Future<void> main() async {
  if (kDebugMode) {
    Logger.root.level = Level.ALL; // defaults to Level.INFO
    Logger.root.onRecord.listen((record) {
      log('${record.level.name}: ${record.time}: [${record.loggerName}] ${record.message}');
    });
  }
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    final sharedPreferences = await SharedPreferencesWithCache.create(
        cacheOptions: const SharedPreferencesWithCacheOptions());
    final downloadsDir = await getDownloadsDirectory();
    final appDocsDir = await getApplicationDocumentsDirectory();
    sharedPreferences.setString(
        Settings.defaultSaveDirKey, downloadsDir?.path ?? appDocsDir.path);
    await Future.wait(<Future>[
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky),
      AudioController.init(),
      TaskRepository.init(),
      StatsDB.init(),
    ]);
    runApp(
      SharedPreferencesInheritedWidget(
        sharedPreferences: sharedPreferences,
        child: const WeiqiHubApp(),
      ),
    );
  }, (err, trace) {
    log('unhandled: $err', stackTrace: trace);
  });
}

import 'dart:collection';

import 'package:wqhub/train/custom_exam_settings.dart';

class CustomExamPresets {
  final SplayTreeMap<String, CustomExamSettings> presets;

  const CustomExamPresets({required this.presets});

  CustomExamPresets.empty()
      : presets = SplayTreeMap<String, CustomExamSettings>();

  Map<String, dynamic> toJson() =>
      presets.map((key, settings) => MapEntry(key, settings.toJson()));

  CustomExamPresets.fromJson(Map<String, dynamic> json)
      : presets = SplayTreeMap.from(json.map((key, val) => MapEntry(
            key, CustomExamSettings.fromJson(val as Map<String, dynamic>))));
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wqhub/settings/settings.dart';
import 'package:wqhub/settings/stats.dart';

class SharedPreferencesInheritedWidget extends InheritedWidget {
  final SharedPreferencesWithCache sharedPreferences;

  const SharedPreferencesInheritedWidget(
      {super.key, required super.child, required this.sharedPreferences});

  static SharedPreferencesInheritedWidget? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SharedPreferencesInheritedWidget>();
  }

  @override
  bool updateShouldNotify(SharedPreferencesInheritedWidget oldWidget) =>
      sharedPreferences != oldWidget.sharedPreferences;
}

extension SharedPreferencesContext on BuildContext {
  Settings get settings => Settings(_sharedPreferences());

  Stats get stats => Stats(_sharedPreferences());

  SharedPreferencesWithCache _sharedPreferences() {
    final widget = SharedPreferencesInheritedWidget.of(this);
    if (widget == null) {
      throw Exception('SharedPreferencesInheritedWidget not found in context');
    }
    return widget.sharedPreferences;
  }
}

import 'package:flutter/material.dart';

// @see https://m3.material.io/foundations/layout/applying-layout/window-size-classes

enum WindowClass { compact, medium, expanded, large, extraLarge }

abstract class WindowClassAwareState<T extends StatefulWidget>
    extends State<T> {
  WindowClass _windowClass = WindowClass.compact;

  WindowClass get windowClass => _windowClass;
  bool get isWindowClassCompact => _windowClass == WindowClass.compact;
  bool get isWindowClassMedium => _windowClass == WindowClass.medium;
  bool get isWindowClassExpanded => _windowClass == WindowClass.expanded;
  bool get isWindowClassLarge => _windowClass == WindowClass.large;
  bool get isWindowClassExtraLarge => _windowClass == WindowClass.extraLarge;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final Size size = MediaQuery.sizeOf(context);
    if (size.width < 600) {
      _windowClass = WindowClass.compact;
    } else if (size.width < 840) {
      _windowClass = WindowClass.medium;
    } else if (size.width < 1200) {
      _windowClass = WindowClass.expanded;
    } else if (size.width < 1600) {
      _windowClass = WindowClass.large;
    } else {
      _windowClass = WindowClass.extraLarge;
    }
  }
}

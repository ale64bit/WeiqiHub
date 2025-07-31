import 'package:flutter/material.dart';
import 'package:wqhub/routes.dart';
import 'package:wqhub/window_class_aware_state.dart';

abstract class PopAndWindowClassAwareState<T extends StatefulWidget>
    extends WindowClassAwareState<T> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    super.didPopNext();
    setState(() {
      // Force rebuild to update the widget when returning to this page
    });
  }
}

import 'dart:async';

class CancellableIsolateStream<T> {
  final Stream<T> stream;
  final void Function() cancel;

  const CancellableIsolateStream({required this.stream, required this.cancel});
}

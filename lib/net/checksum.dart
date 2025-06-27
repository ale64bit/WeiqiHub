import 'dart:math';
import 'dart:typed_data';

int adler32(Uint8List data, {int seed = 1}) {
  final n = data.length;
  var a = seed & 0xFFFF;
  var b = (seed >> 16) & 0xFFFF;
  for (int i = 0; i < n;) {
    final m = min(n - i, 2654) + i;
    for (; i < m; ++i) {
      a += data[i];
      b += a;
    }
    a = (15 * (a >>> 16) + (a & 65535));
    b = (15 * (b >>> 16) + (b & 65535));
  }
  return ((b % 65521) << 16) | (a % 65521);
}

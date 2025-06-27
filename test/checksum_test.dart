import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:wqhub/net/checksum.dart';

void main() {
  test('adler32', () {
    expect(adler32(Uint8List.fromList('Wikipedia'.codeUnits)), 0x11E60398);
    expect(adler32(Uint8List.fromList('123'.codeUnits)), 0x012D0097);
  });
}

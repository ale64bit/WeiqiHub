import 'package:flutter_test/flutter_test.dart';
import 'package:wqhub/wq/rank.dart';

void main() {
  test('decimalString', () {
    expect(Rank.decimalString(12.0), '18.0K');
    expect(Rank.decimalString(12.1), '17.9K');
    expect(Rank.decimalString(12.5), '17.5K');
    expect(Rank.decimalString(12.9), '17.1K');
    expect(Rank.decimalString(13.0), '17.0K');
    expect(Rank.decimalString(21.0), '9.0K');
    expect(Rank.decimalString(21.1), '8.9K');
    expect(Rank.decimalString(21.5), '8.5K');
    expect(Rank.decimalString(21.9), '8.1K');
    expect(Rank.decimalString(22.0), '8.0K');
    expect(Rank.decimalString(28.0), '2.0K');
    expect(Rank.decimalString(28.1), '1.9K');
    expect(Rank.decimalString(28.5), '1.5K');
    expect(Rank.decimalString(28.9), '1.1K');
    expect(Rank.decimalString(29.0), '1.0K');
    expect(Rank.decimalString(29.1), '0.9K');
    expect(Rank.decimalString(29.5), '0.5K');
    expect(Rank.decimalString(29.9), '0.1K');
    expect(Rank.decimalString(30.0), '1.0D');
    expect(Rank.decimalString(30.1), '1.1D');
    expect(Rank.decimalString(30.5), '1.5D');
    expect(Rank.decimalString(30.9), '1.9D');
    expect(Rank.decimalString(31.0), '2.0D');
  });
}

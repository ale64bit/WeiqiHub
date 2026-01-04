import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wqhub/l10n/app_localizations.dart';

Widget intFormField(
  BuildContext context, {
  Key? key,
  String? label,
  int? initialValue,
  int? minValue,
  int? maxValue,
  Function(int)? onChanged,
}) {
  final loc = AppLocalizations.of(context)!;

  (int, String?) validator(value) {
    if (value == null || value.isEmpty) return (0, loc.errCannotBeEmpty);
    final count = int.tryParse(value);
    if (count == null) return (0, loc.errMustBeInteger);
    if (minValue != null && count < minValue) {
      return (0, loc.errMustBeAtLeast(minValue));
    }
    if (maxValue != null && count > maxValue) {
      return (0, loc.errMustBeAtMost(maxValue));
    }
    return (count, null);
  }

  return TextFormField(
    key: key,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      labelText: label,
    ),
    validator: (value) => validator(value).$2,
    initialValue: initialValue?.toString(),
    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    autovalidateMode: AutovalidateMode.always,
    onChanged: (value) {
      log('onChanged: => $value');
      final (i, err) = validator(value);
      if (err == null) onChanged?.call(i);
    },
  );
}

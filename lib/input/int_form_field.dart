import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wqhub/l10n/app_localizations.dart';

class IntFormField extends StatelessWidget {
  final String label;
  final int? initialValue;
  final int? minValue;
  final int? maxValue;
  final Function(int)? onChanged;

  const IntFormField(
      {super.key,
      required this.label,
      this.initialValue,
      this.minValue,
      this.maxValue,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    (int, String?) validator(value) {
      if (value == null || value.isEmpty) return (0, loc.errCannotBeEmpty);
      final count = int.tryParse(value);
      if (count == null) return (0, loc.errMustBeInteger);
      if (minValue != null && count < minValue!) {
        return (0, loc.errMustBeAtLeast(minValue!));
      }
      if (maxValue != null && count > maxValue!) {
        return (0, loc.errMustBeAtMost(maxValue!));
      }
      return (count, null);
    }

    return TextFormField(
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
        final (i, err) = validator(value);
        if (err == null) onChanged?.call(i);
      },
    );
  }
}

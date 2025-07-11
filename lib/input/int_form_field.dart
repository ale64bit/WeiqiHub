import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
      ),
      validator: (value) => _validator(value).$2,
      initialValue: initialValue?.toString(),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      autovalidateMode: AutovalidateMode.always,
      onChanged: (value) {
        final (i, err) = _validator(value);
        if (err == null) onChanged?.call(i);
      },
    );
  }

  (int, String?) _validator(value) {
    if (value == null || value.isEmpty) return (0, 'Cannot be empty');
    final count = int.tryParse(value);
    if (count == null) return (0, 'Must be an integer');
    if (minValue != null && count < minValue!)
      return (0, 'Must be at least $minValue');
    if (maxValue != null && count > maxValue!)
      return (0, 'Must be at most $maxValue');
    return (count, null);
  }
}

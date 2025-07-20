import 'package:flutter/material.dart';
import 'package:wqhub/input/int_form_field.dart';

class DurationFormField extends FormField<Duration> {
  DurationFormField({
    super.key,
    String? label,
    String minutesLabel = 'Minutes',
    String secondsLabel = 'Seconds',
    required Duration initialValue,
    required FormFieldValidator<Duration> validator,
    Function(Duration)? onChanged,
  }) : super(
          initialValue: initialValue,
          validator: validator,
          autovalidateMode: AutovalidateMode.always,
          builder: (FormFieldState<Duration> st) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  spacing: 8.0,
                  children: <Widget>[
                    if (label != null) Text(label),
                    Expanded(
                      child: IntFormField(
                        label: minutesLabel,
                        initialValue: (st.value?.inMinutes ?? 0) % 60,
                        minValue: 0,
                        maxValue: 59,
                        onChanged: (int? minutes) {
                          final newDuration = Duration(
                            minutes: minutes!,
                            seconds: st.value!.inSeconds % 60,
                          );
                          st.didChange(newDuration);
                          onChanged?.call(newDuration);
                        },
                      ),
                    ),
                    Text(':', style: TextTheme.of(st.context).headlineLarge),
                    Expanded(
                      child: IntFormField(
                        label: secondsLabel,
                        initialValue: (st.value?.inSeconds ?? 0) % 60,
                        minValue: 0,
                        maxValue: 59,
                        onChanged: (int? seconds) {
                          final newDuration = Duration(
                            minutes: st.value!.inMinutes % 60,
                            seconds: seconds!,
                          );
                          st.didChange(newDuration);
                          onChanged?.call(newDuration);
                        },
                      ),
                    ),
                  ],
                ),
                if (st.hasError)
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(st.errorText ?? '',
                        style:
                            TextStyle(color: ColorScheme.of(st.context).error)),
                  ),
              ],
            );
          },
        );
}

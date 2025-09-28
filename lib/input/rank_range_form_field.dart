import 'dart:math';
import 'package:flutter/material.dart';
import 'package:wqhub/train/rank_range.dart';
import 'package:wqhub/wq/rank.dart';

class RankRangeFormField extends FormField<RankRange> {
  RankRangeFormField({
    super.key,
    required RankRange initialValue,
    required FormFieldValidator<RankRange> validator,
    Function(RankRange)? onChanged,
  }) : super(
          initialValue: initialValue,
          validator: validator,
          autovalidateMode: AutovalidateMode.always,
          builder: (FormFieldState<RankRange> st) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  spacing: 8.0,
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<Rank>(
                        initialValue: st.value?.from,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Min rank',
                        ),
                        items: [
                          for (var i = Rank.k15.index; i <= Rank.d7.index; ++i)
                            DropdownMenuItem(
                              value: Rank.values[i],
                              child: Text(Rank.values[i].toString()),
                            ),
                        ],
                        onChanged: (value) {
                          final newRange = RankRange(
                            from: value!,
                            to: Rank
                                .values[max(st.value!.to.index, value.index)],
                          );
                          st.didChange(newRange);
                          onChanged?.call(newRange);
                        },
                      ),
                    ),
                    Expanded(
                      child: DropdownButtonFormField<Rank>(
                        initialValue: st.value?.to,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Max rank',
                        ),
                        items: [
                          for (var i = (st.value?.from ?? Rank.k15).index;
                              i <= Rank.d7.index;
                              ++i)
                            DropdownMenuItem(
                              value: Rank.values[i],
                              child: Text(Rank.values[i].toString()),
                            ),
                        ],
                        onChanged: (value) {
                          final newRange = RankRange(
                            from: st.value!.from,
                            to: value!,
                          );
                          st.didChange(newRange);
                          onChanged?.call(newRange);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
}

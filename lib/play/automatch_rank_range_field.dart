import 'package:flutter/material.dart';
import 'package:wqhub/game_client/automatch_options.dart';
import 'package:wqhub/l10n/app_localizations.dart';
import 'package:wqhub/wq/rank.dart';

/// Lets the user pick how many ranks stronger/weaker an automatch opponent may
/// be. When [playerRank] is known, the resulting absolute rank range is shown.
class AutomatchRankRangeField extends StatelessWidget {
  final AutomatchOptions options;
  final Rank? playerRank;
  final ValueChanged<AutomatchOptions> onChanged;

  const AutomatchRankRangeField({
    super.key,
    required this.options,
    required this.playerRank,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(loc.automatchRankRange, style: TextTheme.of(context).titleSmall),
        const SizedBox(height: 8),
        Row(
          spacing: 8.0,
          children: [
            Expanded(
              child: _RankDiffDropdown(
                label: loc.automatchStrongerOpponents,
                sign: '+',
                value: options.upperRankDiff,
                onChanged: (v) => onChanged(options.copyWith(upperRankDiff: v)),
              ),
            ),
            Expanded(
              child: _RankDiffDropdown(
                label: loc.automatchWeakerOpponents,
                sign: '-',
                value: options.lowerRankDiff,
                onChanged: (v) => onChanged(options.copyWith(lowerRankDiff: v)),
              ),
            ),
          ],
        ),
        if (playerRank != null) ...[
          const SizedBox(height: 8),
          Text(
            loc.automatchSearchRange(_absoluteRange(playerRank!)),
            style: TextTheme.of(context).bodySmall,
          ),
        ],
      ],
    );
  }

  String _absoluteRange(Rank rank) {
    final last = Rank.values.length - 1;
    final weakest =
        Rank.values[(rank.index - options.lowerRankDiff).clamp(0, last)];
    final strongest =
        Rank.values[(rank.index + options.upperRankDiff).clamp(0, last)];
    return '$weakest – $strongest';
  }
}

class _RankDiffDropdown extends StatelessWidget {
  final String label;

  /// Sign shown in front of each non-zero option ('+' for stronger, '-' for
  /// weaker); the stored [value] stays a non-negative rank count.
  final String sign;
  final int value;
  final ValueChanged<int> onChanged;

  const _RankDiffDropdown({
    required this.label,
    required this.sign,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      // Recreate the field when [value] changes externally so the shown
      // selection stays in sync with the persisted setting.
      key: ValueKey('$label:$value'),
      initialValue: value,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
        isDense: true,
      ),
      items: [
        for (var i = 0; i <= AutomatchOptions.maxRankDiff; ++i)
          DropdownMenuItem(value: i, child: Text(i == 0 ? '0' : '$sign$i')),
      ],
      onChanged: (v) {
        if (v != null) onChanged(v);
      },
    );
  }
}

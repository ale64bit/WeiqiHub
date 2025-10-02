import 'package:wqhub/l10n/app_localizations.dart';

enum ResponseDelay {
  none,
  short,
  medium,
  long;

  Duration get duration => switch (this) {
        none => Duration.zero,
        short => Duration(milliseconds: 50),
        medium => Duration(milliseconds: 200),
        long => Duration(milliseconds: 400),
      };

  String toLocalizedString(AppLocalizations loc) => switch (this) {
        ResponseDelay.none => loc.responseDelayNone,
        ResponseDelay.short => loc.responseDelayShort,
        ResponseDelay.medium => loc.responseDelayMedium,
        ResponseDelay.long => loc.responseDelayLong,
      };
}

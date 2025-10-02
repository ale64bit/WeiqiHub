import 'package:wqhub/l10n/app_localizations.dart';

typedef LocalizedString = String Function(AppLocalizations);

class ServerInfo {
  final String id;
  final LocalizedString name;
  final String nativeName;
  final LocalizedString description;
  final String homeUrl;
  final Uri? registerUrl;

  const ServerInfo({
    required this.id,
    required this.name,
    required this.nativeName,
    required this.description,
    required this.homeUrl,
    this.registerUrl,
  });
}

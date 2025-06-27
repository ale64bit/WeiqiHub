import 'package:flutter/widgets.dart';

@immutable
class ServerInfo {
  final String id;
  final String name;
  final String nativeName;
  final String description;
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

  @override
  int get hashCode =>
      Object.hash(id, name, nativeName, description, homeUrl, registerUrl);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is ServerInfo &&
        other.id == id &&
        other.name == name &&
        other.nativeName == nativeName &&
        other.description == description &&
        other.homeUrl == homeUrl &&
        other.registerUrl == registerUrl;
  }
}

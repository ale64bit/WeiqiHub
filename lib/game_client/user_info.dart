import 'package:flutter/widgets.dart';
import 'package:wqhub/wq/rank.dart';

@immutable
class PromotionRequirements {
  final int? up;
  final int? down;
  final int? doubleUp;
  final int? doubleDown;

  const PromotionRequirements(
      {required this.up,
      required this.down,
      required this.doubleUp,
      required this.doubleDown});

  @override
  int get hashCode => Object.hash(up, down, doubleUp, doubleDown);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is PromotionRequirements &&
        other.up == up &&
        other.down == down &&
        other.doubleUp == doubleUp &&
        other.doubleDown == doubleDown;
  }
}

@immutable
class UserInfo {
  final String userId;
  final String username;
  final Rank rank;
  final bool online;
  final int? winCount;
  final int? lossCount;
  final String? streak;
  final PromotionRequirements? promotionRequirements;

  const UserInfo(
      {required this.userId,
      required this.username,
      required this.rank,
      required this.online,
      this.winCount,
      this.lossCount,
      this.streak,
      this.promotionRequirements});

  UserInfo copyWith({
    String? userId,
    String? username,
    Rank? rank,
    bool? online,
    int? winCount,
    int? lossCount,
    String? streak,
    PromotionRequirements? promotionRequirements,
  }) =>
      UserInfo(
        userId: userId ?? this.userId,
        username: username ?? this.username,
        rank: rank ?? this.rank,
        online: online ?? this.online,
        winCount: winCount ?? this.winCount,
        lossCount: lossCount ?? this.lossCount,
        streak: streak ?? this.streak,
        promotionRequirements:
            promotionRequirements ?? this.promotionRequirements,
      );

  @override
  int get hashCode => Object.hash(userId, username, rank, online, winCount,
      lossCount, streak, promotionRequirements);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is UserInfo &&
        other.userId == userId &&
        other.username == username &&
        other.rank == rank &&
        other.online == online &&
        other.winCount == winCount &&
        other.lossCount == lossCount &&
        other.streak == streak &&
        other.promotionRequirements == promotionRequirements;
  }

  @override
  String toString() =>
      '{id=$userId, nick=$username, rank=$rank win=$winCount loss=$lossCount}';

  static UserInfo empty() => const UserInfo(
        userId: '',
        username: '',
        rank: Rank.k18,
        online: false,
      );
}

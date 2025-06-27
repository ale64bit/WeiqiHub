import 'package:shared_preferences/shared_preferences.dart';
import 'package:wqhub/wq/rank.dart';

class Stats {
  static const _gradingExamKeyPrefix = 'stats.grading_exam';
  static const _endgameExamKeyPrefix = 'stats.endgame_exam';
  static const _timeFrenzyHighScoreKey = 'stats.time_frenzy.hi_score';
  static const _rankedModeRankKey = 'stats.ranked_mode.rank';
  static const _totalKeyPrefix = 'stats.total';

  final SharedPreferencesWithCache prefs;

  const Stats(this.prefs);

  int getGradingExamPassCount(Rank rank) =>
      prefs.getInt('$_gradingExamKeyPrefix.$rank.pass') ?? 0;

  int getGradingExamFailCount(Rank rank) =>
      prefs.getInt('$_gradingExamKeyPrefix.$rank.fail') ?? 0;

  void incrementGradingExamPassCount(Rank rank) {
    prefs.setInt(
        '$_gradingExamKeyPrefix.$rank.pass', getGradingExamPassCount(rank) + 1);
  }

  void incrementGradingExamFailCount(Rank rank) {
    prefs.setInt(
        '$_gradingExamKeyPrefix.$rank.fail', getGradingExamFailCount(rank) + 1);
  }

  int getEndgameExamPassCount(Rank rank) =>
      prefs.getInt('$_endgameExamKeyPrefix.$rank.pass') ?? 0;

  int getEndgameExamFailCount(Rank rank) =>
      prefs.getInt('$_endgameExamKeyPrefix.$rank.fail') ?? 0;

  void incrementEndgameExamPassCount(Rank rank) {
    prefs.setInt(
        '$_endgameExamKeyPrefix.$rank.pass', getEndgameExamPassCount(rank) + 1);
  }

  void incrementEndgameExamFailCount(Rank rank) {
    prefs.setInt(
        '$_endgameExamKeyPrefix.$rank.fail', getEndgameExamFailCount(rank) + 1);
  }

  int get timeFrenzyHighScore => prefs.getInt(_timeFrenzyHighScoreKey) ?? 0;

  void updateTimeFrenzyHighScore(int score) {
    final hiScore = prefs.getInt(_timeFrenzyHighScoreKey) ?? 0;
    if (score > hiScore) prefs.setInt(_timeFrenzyHighScoreKey, score);
  }

  double get rankedModeRank =>
      prefs.getDouble(_rankedModeRankKey) ?? Rank.k15.index.toDouble();

  void updateRankedModeRank(double value) =>
      prefs.setDouble(_rankedModeRankKey, value);

  int getTotalPassCount(Rank rank) =>
      prefs.getInt('$_totalKeyPrefix.$rank.pass') ?? 0;

  int getTotalFailCount(Rank rank) =>
      prefs.getInt('$_totalKeyPrefix.$rank.fail') ?? 0;

  void incrementTotalPassCount(Rank rank) {
    prefs.setInt('$_totalKeyPrefix.$rank.pass', getTotalPassCount(rank) + 1);
  }

  void incrementTotalFailCount(Rank rank) {
    prefs.setInt('$_totalKeyPrefix.$rank.fail', getTotalFailCount(rank) + 1);
  }
}

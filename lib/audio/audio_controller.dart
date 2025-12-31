import 'package:flutter_soloud/flutter_soloud.dart';
import 'package:logging/logging.dart';
import 'package:wqhub/settings/settings.dart';
import 'package:wqhub/wq/game_tree.dart';

class _LocalizedVoice {
  final AudioSource startToPlay;
  final AudioSource pass;
  final List<AudioSource> count;

  _LocalizedVoice(
      {required this.startToPlay, required this.pass, required this.count});
}

class AudioController {
  static final Logger _log = Logger('AudioController');
  static AudioController? _instance;

  factory AudioController() => _instance!;

  final SoLoud _soloud;
  final AudioSource _stone;
  final AudioSource _captureOne;
  final AudioSource _captureMany;
  final AudioSource _correct;
  final AudioSource _wrong;
  final _LocalizedVoice _enVoice;

  var stoneVolume = 1.0;
  var voiceVolume = 1.0;
  var uiVolume = 1.0;

  static Future<void> init(Settings settings) async {
    _log.info('init');
    assert(_instance == null);
    final soloud = SoLoud.instance;
    await soloud.init();
    _instance = AudioController._(
      soloud,
      stone: await soloud.loadAsset('assets/sounds/stone.mp3'),
      captureOne: await soloud.loadAsset('assets/sounds/capture_one.mp3'),
      captureMany: await soloud.loadAsset('assets/sounds/capture_many.mp3'),
      correct: await soloud.loadAsset('assets/sounds/correct.mp3'),
      wrong: await soloud.loadAsset('assets/sounds/wrong.mp3'),
      enVoice: _LocalizedVoice(
        startToPlay:
            await soloud.loadAsset('assets/sounds/en/start_to_play.mp3'),
        pass: await soloud.loadAsset('assets/sounds/en/pass.mp3'),
        count: await Future.wait([
          for (int i = 1; i <= 9; ++i)
            soloud.loadAsset('assets/sounds/en/$i.mp3')
        ]),
      ),
      stoneVolume: settings.soundStone,
      voiceVolume: settings.soundVoice,
      uiVolume: settings.soundUI,
    );
  }

  AudioController._(
    this._soloud, {
    required AudioSource stone,
    required AudioSource captureOne,
    required AudioSource captureMany,
    required AudioSource correct,
    required AudioSource wrong,
    required _LocalizedVoice enVoice,
    required this.stoneVolume,
    required this.voiceVolume,
    required this.uiVolume,
  })  : _stone = stone,
        _captureOne = captureOne,
        _captureMany = captureMany,
        _correct = correct,
        _wrong = wrong,
        _enVoice = enVoice;

  void dispose() {
    _soloud.deinit();
  }

  //================================================================================
  // Stone sounds
  Future<void> playStone() async =>
      await _soloud.play(_stone, volume: stoneVolume);
  Future<void> captureOne() async =>
      await _soloud.play(_captureOne, volume: stoneVolume);
  Future<void> captureMany() async =>
      await _soloud.play(_captureMany, volume: stoneVolume);

  Future<void> playForNode(GameTreeNode node) async {
    playStone();
    if (node.diff.length > 5) {
      await Future.delayed(Duration(milliseconds: 150));
      captureMany();
    } else if (node.diff.isNotEmpty) {
      await Future.delayed(Duration(milliseconds: 150));
      captureOne();
    }
  }

  //================================================================================
  // UI sounds
  Future<void> correct() async =>
      await _soloud.play(_correct, volume: uiVolume);
  Future<void> wrong() async => await _soloud.play(_wrong, volume: uiVolume);

  //================================================================================
  // Voice sounds
  Future<void> startToPlay() async =>
      await _soloud.play(_enVoice.startToPlay, volume: voiceVolume);
  Future<void> pass() async =>
      await _soloud.play(_enVoice.pass, volume: voiceVolume);
  Future<void> count(int i) async {
    if (i < 1 || i > _enVoice.count.length) {
      _log.warning(
          'Invalid count value: $i (expected 1-${_enVoice.count.length})');
      return;
    }
    await _soloud.play(_enVoice.count[i - 1], volume: voiceVolume);
  }
}

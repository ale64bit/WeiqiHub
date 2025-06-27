import 'package:flutter_soloud/flutter_soloud.dart';
import 'package:logging/logging.dart';
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

  static init() async {
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
  })  : _stone = stone,
        _captureOne = captureOne,
        _captureMany = captureMany,
        _correct = correct,
        _wrong = wrong,
        _enVoice = enVoice;

  void dispose() {
    _soloud.deinit();
  }

  Future<void> playStone() async => await _soloud.play(_stone);
  Future<void> captureOne() async => await _soloud.play(_captureOne);
  Future<void> captureMany() async => await _soloud.play(_captureMany);

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

  Future<void> correct() async => await _soloud.play(_correct);
  Future<void> wrong() async => await _soloud.play(_wrong);

  Future<void> startToPlay() async => await _soloud.play(_enVoice.startToPlay);
  Future<void> pass() async => await _soloud.play(_enVoice.pass);
  Future<void> count(int i) async => await _soloud.play(_enVoice.count[i - 1]);
}

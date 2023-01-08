import 'package:audioplayers/audioplayers.dart';
import 'package:riverpod_study/data/count/count_data.dart';
import 'package:riverpod_study/logic/count_changed_notifier.dart';

class SoundLogic with CountChangedNotifier {
  static const SOUND_DATA_UP = 'sound/up.mp3';
  static const SOUND_DATA_DOWN = 'sound/down.mp3';
  static const SOUND_DATA_RESET = 'sound/reset.mp3';

  final AudioCache _cache = AudioCache(
    fixedPlayer: AudioPlayer(),
  );

  void load() {
    _cache.loadAll([SOUND_DATA_UP, SOUND_DATA_DOWN, SOUND_DATA_RESET]);
  }

  @override
  void valueChanged(CountData prevData, CountData newData) {
    if (newData.count == 0 && newData.countUp == 0 && newData.countDown == 0) {
      playSoundReset();
    } else if (prevData.countUp + 1 == newData.countUp) {
      playSoundUp();
    } else if (prevData.countDown + 1 == newData.countDown) {
      playSoundDown();
    }
  }

  void playSoundUp() {
    _cache.play(SOUND_DATA_UP);
  }

  void playSoundDown() {
    _cache.play(SOUND_DATA_DOWN);
  }

  void playSoundReset() {
    _cache.play(SOUND_DATA_RESET);
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_study/data/count/count_data.dart';
import 'package:riverpod_study/logic/sound_logic.dart';
import 'package:riverpod_study/model/count_model.dart';
import 'package:riverpod_study/provider.dart';

class CountViewModel {
  final CountModel _model = CountModel();
  final SoundLogic _soundLogic = SoundLogic();
  late WidgetRef _ref;

  void setRef(WidgetRef ref) {
    _ref = ref;
  }

  get count => _ref.watch(countDataProvider).count;
  get countUp => _ref.watch(countDataProvider.select((value) => value.countUp));
  get countDown =>
      _ref.watch(countDataProvider.select((value) => value.countDown));

  void onIncrease() {
    _model.increase();
    update();
  }

  void onDecrease() {
    _model.decrease();
    update();
  }

  void onReset() {
    _model.reset();
    update();
  }

  void update() {
    CountData prevData = _ref.watch(countDataProvider.notifier).state;
    _ref.watch(countDataProvider.notifier).state = _model.countData;
    CountData newData = _ref.watch(countDataProvider.notifier).state;

    _soundLogic.valueChanged(prevData, newData);
  }
}

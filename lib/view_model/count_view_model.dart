import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_study/data/count/count_data.dart';
import 'package:riverpod_study/logic/button_animation.dart';
import 'package:riverpod_study/logic/count_changed_notifier.dart';
import 'package:riverpod_study/logic/sound_logic.dart';
import 'package:riverpod_study/model/count_model.dart';
import 'package:riverpod_study/provider.dart';

class CountViewModel {
  final CountModel _model = CountModel();
  final SoundLogic _soundLogic = SoundLogic();
  late ButtonAnimationLogic _btnAnimationLogicPlus;
  late ButtonAnimationLogic _btnAnimationLogicMinus;
  late ButtonAnimationLogic _btnAnimationLogicReset;

  late WidgetRef _ref;
  List<CountChangedNotifier> notifiers = [];

  void setRef(WidgetRef ref, TickerProvider tickerProvider) {
    _ref = ref;

    conditionPlus(CountData prevData, CountData newData) {
      return prevData.countUp + 1 == newData.countUp;
    }

    conditionMinus(CountData prevData, CountData newData) {
      return prevData.countDown + 1 == newData.countDown;
    }

    conditionReset(CountData prevData, CountData newData) {
      return newData.count == 0 &&
          newData.countUp == 0 &&
          newData.countDown == 0;
    }

    _btnAnimationLogicPlus =
        ButtonAnimationLogic(tickerProvider, conditionPlus);
    _btnAnimationLogicMinus =
        ButtonAnimationLogic(tickerProvider, conditionMinus);
    _btnAnimationLogicReset =
        ButtonAnimationLogic(tickerProvider, conditionReset);
    _soundLogic.load();
    notifiers = [
      _btnAnimationLogicPlus,
      _btnAnimationLogicMinus,
      _btnAnimationLogicReset,
      _soundLogic
    ];
  }

  get count => _ref.watch(countDataProvider).count;
  get countUp => _ref.watch(countDataProvider.select((value) => value.countUp));
  get countDown =>
      _ref.watch(countDataProvider.select((value) => value.countDown));

  get animationBtnPlusCombination =>
      _btnAnimationLogicPlus.animationCombination;
  get animationBtnMinusCombination =>
      _btnAnimationLogicMinus.animationCombination;
  get animationBtnResetCombination =>
      _btnAnimationLogicReset.animationCombination;

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

    notifiers.forEach((element) => element.valueChanged(prevData, newData));
  }
}

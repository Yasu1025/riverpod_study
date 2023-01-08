import 'package:flutter/material.dart';
import 'package:riverpod_study/data/count/count_data.dart';
import 'package:riverpod_study/logic/count_changed_notifier.dart';

class ButtonAnimationLogic with CountChangedNotifier {
  late AnimationController _animationCtrl;
  late Animation<double> _animationScale;
  ValueChangedCondition startCondition;

  get animationScale => _animationScale;

  ButtonAnimationLogic(TickerProvider tickerProvider, this.startCondition) {
    _animationCtrl = AnimationController(
      vsync: tickerProvider,
      duration: const Duration(milliseconds: 500),
    );

    _animationScale = _animationCtrl
        .drive(
          CurveTween(
            curve: const Interval(0.1, 1.0),
          ),
        )
        .drive(
          Tween(begin: 1.0, end: 1.8),
        );
  }

  @override
  void dispose() {
    _animationCtrl.dispose();
  }

  void start() {
    _animationCtrl.forward().whenComplete(
          () => _animationCtrl.reset(),
        );
  }

  @override
  void valueChanged(CountData prevData, CountData newData) {
    if (startCondition(prevData, newData)) {
      start();
    }
  }
}

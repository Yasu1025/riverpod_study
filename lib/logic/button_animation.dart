import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:riverpod_study/data/count/count_data.dart';
import 'package:riverpod_study/logic/count_changed_notifier.dart';

class ButtonAnimationLogic with CountChangedNotifier {
  late AnimationController _animationCtrl;
  late Animation<double> _animationScale;
  late Animation<double> _animationRotate;
  late AnimationCombination _animationCombination;
  ValueChangedCondition startCondition;

  get animationCombination => _animationCombination;

  ButtonAnimationLogic(TickerProvider tickerProvider, this.startCondition) {
    _animationCtrl = AnimationController(
      vsync: tickerProvider,
      duration: const Duration(milliseconds: 500),
    );

    _animationScale = _animationCtrl
        .drive(
          CurveTween(curve: const Interval(0.1, 0.7)),
        )
        .drive(Tween(begin: 1.0, end: 1.8));

    _animationRotate = _animationCtrl
        .drive(
          CurveTween(
            curve: Interval(0.4, 0.8, curve: ButtonRotateCurve()),
          ),
        )
        .drive(Tween(begin: 0.0, end: 1.0));

    _animationCombination =
        AnimationCombination(_animationScale, _animationRotate);
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

class ButtonRotateCurve extends Curve {
  @override
  double transform(double t) {
    return math.sin(2 * math.pi * t) / 16;
  }
}

class AnimationCombination {
  final Animation<double> animationScale;
  final Animation<double> animationRotate;

  AnimationCombination(
    this.animationScale,
    this.animationRotate,
  );
}

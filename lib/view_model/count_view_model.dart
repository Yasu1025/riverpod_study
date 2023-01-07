import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_study/model/count_model.dart';
import 'package:riverpod_study/provider.dart';

class CountViewModel {
  final CountModel _model = CountModel();
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

    _ref.watch(countDataProvider.notifier).state = _model.countData;
  }

  void onDecrease() {
    _model.decrease();

    _ref.watch(countDataProvider.notifier).state = _model.countData;
  }

  void onReset() {
    _model.reset();

    _ref.watch(countDataProvider.notifier).state = _model.countData;
  }
}

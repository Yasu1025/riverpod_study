import 'package:riverpod_study/data/count/count_data.dart';

typedef ValueChangedCondition = bool Function(
    CountData prevData, CountData newData);

abstract class CountChangedNotifier {
  void valueChanged(CountData prevData, CountData newData) {}
}

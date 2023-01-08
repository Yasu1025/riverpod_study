import 'package:riverpod_study/data/count/count_data.dart';
import 'package:riverpod_study/logic/count_changed_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesLogic with CountChangedNotifier {
  static const keyCount = 'COUNT';
  static const keyCountPlus = 'COUNT_PLUS';
  static const keyCountDown = 'COUNT_DOWN';
  @override
  void valueChanged(CountData prevData, CountData newData) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt(keyCount, newData.count);
    sharedPreferences.setInt(keyCountPlus, newData.countUp);
    sharedPreferences.setInt(keyCountDown, newData.countDown);
  }

  static Future<CountData> read() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return CountData(
      count: sharedPreferences.getInt(keyCount) ?? 0,
      countUp: sharedPreferences.getInt(keyCountPlus) ?? 0,
      countDown: sharedPreferences.getInt(keyCountDown) ?? 0,
    );
  }
}

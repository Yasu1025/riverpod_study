import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_study/data/count/count_data.dart';

// test
final titleProvider = Provider<String>((ref) => 'I am title');

final textProvider = Provider<String>((ref) => 'I am Text');

final countDataProvider = StateProvider<CountData>(
  (ref) => const CountData(
    count: 0,
    countUp: 0,
    countDown: 0,
  ),
);

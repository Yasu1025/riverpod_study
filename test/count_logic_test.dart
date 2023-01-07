import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_study/data/count/count_data.dart';
import 'package:riverpod_study/model/count_model.dart';

void main() {
  CountModel target = CountModel();

  setUp(() async {
    target = CountModel();
  });

  test('init', () async {
    expect(
      target.countData,
      const CountData(count: 0, countUp: 0, countDown: 0),
    );
  });
  test('inincreaseit', () async {
    target.increase();
    expect(
      target.countData,
      const CountData(count: 1, countUp: 1, countDown: 0),
    );
    target.increase();
    target.increase();
    target.increase();
    expect(
      target.countData,
      const CountData(count: 4, countUp: 4, countDown: 0),
    );
  });
  test('decrease', () async {
    target.decrease();
    expect(
      target.countData,
      const CountData(count: -1, countUp: 0, countDown: 1),
    );
    target.decrease();
    target.decrease();
    target.decrease();
    expect(
      target.countData,
      const CountData(count: -4, countUp: 0, countDown: 4),
    );
  });
  test('reset', () async {
    target.increase();
    target.decrease();
    target.increase();
    target.increase();

    target.reset();
    expect(
      target.countData,
      const CountData(count: 0, countUp: 0, countDown: 0),
    );
  });
}

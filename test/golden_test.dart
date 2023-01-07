import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:riverpod_study/main.dart';
import 'package:riverpod_study/view_model/count_view_model.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });
  testGoldens('normal', (tester) async {
    const iPhone55 = Device(
      name: 'iPhone55',
      size: Size(414, 736),
      devicePixelRatio: 3.0,
    );

    List<Device> devices = [iPhone55];

    CountViewModel countVM = CountViewModel();

    await tester.pumpWidgetBuilder(
      ProviderScope(child: MyHomePage(countVM)),
    );

    await multiScreenGolden(
      tester,
      '0: myHomePage_init',
      devices: devices,
    );

    await tester.tap(find.byIcon(CupertinoIcons.plus));
    await tester.pump();

    await multiScreenGolden(
      tester,
      '1: myHomePage_increase_tapped',
      devices: devices,
    );
  });
}

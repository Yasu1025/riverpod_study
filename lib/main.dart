import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_study/logic/button_animation.dart';
import 'package:riverpod_study/provider.dart';
import 'package:riverpod_study/view_model/count_view_model.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(CountViewModel()),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  final CountViewModel countVM;
  const MyHomePage(this.countVM, {super.key});

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage>
    with TickerProviderStateMixin {
  late CountViewModel _countVM;
  @override
  void initState() {
    super.initState();

    _countVM = widget.countVM;
    _countVM.setRef(ref, this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ref.watch(titleProvider)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              ref.watch(textProvider),
            ),
            Text(
              _countVM.count.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton(
                  onPressed: _countVM.onIncrease,
                  child: AnimationButton(
                    animationCombination: _countVM.animationBtnPlusCombination,
                    child: const Icon(CupertinoIcons.plus),
                  ),
                ),
                FloatingActionButton(
                  onPressed: _countVM.onDecrease,
                  child: AnimationButton(
                    animationCombination: _countVM.animationBtnMinusCombination,
                    child: const Icon(CupertinoIcons.minus),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(_countVM.countUp.toString()),
                Text(_countVM.countDown.toString()),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _countVM.onReset,
        child: AnimationButton(
          animationCombination: _countVM.animationBtnResetCombination,
          child: const Icon(CupertinoIcons.refresh),
        ),
      ),
    );
  }
}

class AnimationButton extends StatelessWidget {
  final AnimationCombination animationCombination;
  final Widget child;
  const AnimationButton(
      {Key? key, required this.animationCombination, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: animationCombination.animationScale,
      child: RotationTransition(
        turns: animationCombination.animationScale,
        child: child,
      ),
    );
  }
}

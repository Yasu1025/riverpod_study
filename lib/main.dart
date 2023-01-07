import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_study/data/count/count_data.dart';
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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  MyHomePage({super.key});

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  CountViewModel countVM = CountViewModel();
  @override
  void initState() {
    super.initState();
    countVM.setRef(ref);
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
              countVM.count.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton(
                  onPressed: countVM.onIncrease,
                  child: const Icon(CupertinoIcons.plus),
                ),
                FloatingActionButton(
                  onPressed: countVM.onDecrease,
                  child: const Icon(CupertinoIcons.minus),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(countVM.countUp.toString()),
                Text(countVM.countDown.toString()),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: countVM.onReset,
        child: const Icon(CupertinoIcons.refresh),
      ),
    );
  }
}

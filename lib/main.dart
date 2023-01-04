import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_study/data/count/count_data.dart';
import 'package:riverpod_study/provider.dart';

void main() {
  runApp(
    ProviderScope(
      child: const MyApp(),
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
              ref.watch(countDataProvider).count.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    CountData countData =
                        ref.read(countDataProvider.notifier).state;
                    ref.read(countDataProvider.notifier).state =
                        countData.copyWith(
                      count: countData.count + 1,
                      countUp: countData.countUp + 1,
                    );
                  },
                  child: const Icon(CupertinoIcons.plus),
                ),
                FloatingActionButton(
                  onPressed: () {
                    CountData countData =
                        ref.read(countDataProvider.notifier).state;
                    ref.read(countDataProvider.notifier).state =
                        countData.copyWith(
                      count: countData.count - 1,
                      countDown: countData.countDown + 1,
                    );
                  },
                  child: const Icon(CupertinoIcons.minus),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(ref
                    .watch(countDataProvider.select((value) => value.countUp))
                    .toString()),
                Text(ref
                    .watch(countDataProvider.select((value) => value.countDown))
                    .toString()),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(countDataProvider.notifier).state = const CountData(
            count: 0,
            countUp: 0,
            countDown: 0,
          );
        },
        child: const Icon(CupertinoIcons.refresh),
      ),
    );
  }
}

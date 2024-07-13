import 'package:flutter/material.dart';
import 'package:notification_listeners_example/model/counter_model.dart';
import 'package:notification_listeners_example/widget/counter_provider.dart';
import 'package:notification_listeners_example/widget/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification listeners example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Необходимо внедрить CounterProvider в дерево виджетов ВЫШЕ того места,
      // где он будет вызываться. А также передаем в него модель нашего
      // счетчика.
      home: CounterProvider(
        model: CounterModel(),
        child: const MyHomePage(),
      ),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';

/// Оригинальный пример счетчика, который генерируется при создании нового
/// Flutter приложения.
///
/// При увеличении значения счетчика перерисовывается буквально весь экран.
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Генерация случайного цвета Scaffold для контроля его перерисовки.
    final scaffoldBodyColor = Colors.primaries[Random().nextInt(
      Colors.primaries.length,
    )];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('StatefulWidget and setState()'),
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: scaffoldBodyColor,
            width: 8,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextWidget(),
              CounterWidget(counter: _counter),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

/// Виджет текста.
///
/// Конструктор виджета нарочно сделан не константным, чтобы виджет мог
/// перерисовываться при обновлении родительского виджета.
class TextWidget extends StatelessWidget {
  TextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Генерация случайного цвета текста для контроля его перерисовки.
    final textColor = Colors.primaries[Random().nextInt(
      Colors.primaries.length,
    )];

    return Text(
      'You have pushed the button this many times:',
      style: TextStyle(color: textColor),
    );
  }
}

/// Виджет счетчика.
class CounterWidget extends StatelessWidget {
  const CounterWidget({
    super.key,
    required int counter,
  }) : _counter = counter;

  final int _counter;

  @override
  Widget build(BuildContext context) {
    // Генерация случайного цвета счетчика для контроля его перерисовки.
    final counterColor = Colors.primaries[Random().nextInt(
      Colors.primaries.length,
    )];

    return Text(
      '$_counter',
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: counterColor,
          ),
    );
  }
}

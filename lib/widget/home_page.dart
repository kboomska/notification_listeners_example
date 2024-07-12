import 'dart:math';

import 'package:flutter/material.dart';

/// Пример использования ValueNotifier совместно с ValueListenableBuilder
/// для отслеживания изменения значения счетчика и перерисовки только
/// минимально необходимой части интерфейса.
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _counter = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    // Генерация случайного цвета Scaffold для контроля его перерисовки.
    final scaffoldBodyColor = Colors.primaries[Random().nextInt(
      Colors.primaries.length,
    )];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('ValueNotifier and ValueListenableBuilder'),
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: scaffoldBodyColor,
            width: 8,
          ),
        ),
        // Чтобы избежать перерисовки части дочерних виджетов у
        // ValueListenableBuilder, которые не зависят от значения счетчика
        // (например, TextWidget), такие виджеты можно вынести в child.
        child: ValueListenableBuilder<int>(
          valueListenable: _counter,
          builder: (context, value, child) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  child!,
                  // Поднимаем ValueListenableBuilder выше по дереву виджетов.
                  CounterWidget(counter: value),
                ],
              ),
            );
          },
          // Данный виджет не будет перерисовываться при изменении значения
          // счетчика.
          child: TextWidget(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _counter.value += 1,
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

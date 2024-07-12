import 'dart:math';

import 'package:flutter/material.dart';
import 'package:notification_listeners_example/model/counter_model.dart';

/// Пример использования ChangeNotifier совместно с ListenableBuilder
/// для отслеживания изменения мутабельной модели и перерисовки только
/// следящие за моделью виджеты.
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _counter = CounterModel();

  @override
  Widget build(BuildContext context) {
    // Генерация случайного цвета Scaffold для контроля его перерисовки.
    final scaffoldBodyColor = Colors.primaries[Random().nextInt(
      Colors.primaries.length,
    )];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('ChangeNotifier and ListenableBuilder'),
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: scaffoldBodyColor,
            width: 8,
          ),
        ),
        // ListenableBuilder работает аналогично рассмотренному ранее
        // ValueListenableBuilder.
        child: ListenableBuilder(
          listenable: _counter,
          builder: (context, child) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  child!,
                  CounterWidget(counterNotifier: _counter),
                ],
              ),
            );
          },
          // Данный виджет не будет перерисовываться при изменении значения
          // счетчика.
          child: TextWidget(),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => _counter.increment(),
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 16),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Изменение цвета счетчика по нажатию соответствующей кнопки.
              FloatingActionButton(
                onPressed: () => _counter.changeColor(),
                tooltip: 'Change Color',
                child: const Icon(Icons.color_lens_outlined),
              ),
              const SizedBox(height: 16),
              FloatingActionButton(
                onPressed: () => _counter.reset(),
                tooltip: 'Reset',
                child: const Icon(Icons.refresh_outlined),
              ),
            ],
          ),
        ],
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
    required CounterModel counterNotifier,
  }) : _counterNotifier = counterNotifier;

  final CounterModel _counterNotifier;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${_counterNotifier.count}',
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: _counterNotifier.color,
          ),
    );
  }
}

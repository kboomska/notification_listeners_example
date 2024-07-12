import 'dart:math';

import 'package:flutter/material.dart';

/// Если требуется зависимость от мутабельных типов данных или моделей с
/// несколькими меняющимися параметрами, то имеет смысл использовать
/// ChangeNotifier.
///
/// Для справки:
/// ValueNotifier - это дочерний класс ChangeNotifier, содержащий единственное
/// значение.
class CounterModel with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count += 1;
    // Метод для оповещения слушателей об изменении в CounterModel.
    notifyListeners();
  }

  void reset() {
    if (_count != 0) {
      _count = 0;
      // Метод для оповещения слушателей об изменении в CounterModel.
      notifyListeners();
    }
  }
}

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
                  CounterWidget(counter: _counter.count),
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
        children: [
          FloatingActionButton(
            onPressed: () => _counter.increment(),
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: () => _counter.reset(),
            tooltip: 'Reset',
            child: const Icon(Icons.refresh_outlined),
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

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:notification_listeners_example/widget/counter_provider.dart';

/// Пример использования InheritedNotifier, благодаря которому возможно
/// встроить в context модель нашего счетчика и обращаться к ней из любого
/// места ниже по дереву.
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // Генерация случайного цвета Scaffold для контроля его перерисовки.
    final scaffoldBodyColor = Colors.primaries[Random().nextInt(
      Colors.primaries.length,
    )];

    // Получаем модель из контекста используя самописный провайдер,
    // наследованный от InheritedNotifier.
    //
    // В данном случае, мы не подписываемся на изменения (listen == false),
    // поскольку в текущем виджете мы только обращаемся к методам модели
    // и не зависим от значения счетчика напрямую.
    final counter = CounterProvider.of(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('InheritedNotifier'),
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
              // Нам теперь не нужно ничего передавать через конструктор -
              // виджет будет получать значение счетчика через контекст
              // внутри своего метода build().
              const CounterWidget(),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Поскольку модель счетчика передается через контекст и данный
              // виджет MyHomePage напрямую с ней никак не связан, то обновление
              // видежта никак не влияет на состояние значения счетчика,
              // а только на зависимый от него виджет текста.
              FloatingActionButton(
                onPressed: () => setState(() {}),
                tooltip: 'Reload',
                child: const Icon(Icons.bolt),
              ),
              const SizedBox(height: 16),
              FloatingActionButton(
                onPressed: () => counter.increment(),
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Изменение цвета счетчика по нажатию соответствующей кнопки.
              FloatingActionButton(
                onPressed: () => counter.changeColor(),
                tooltip: 'Change Color',
                child: const Icon(Icons.color_lens_outlined),
              ),
              const SizedBox(height: 16),
              FloatingActionButton(
                onPressed: () => counter.reset(),
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
  // ignore: prefer_const_constructors_in_immutables
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
  const CounterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Обращаемся к модели счетчика через контекст и подписываемся на её
    // изменения (по умолчанию listen == true).
    // При этом, в случае изменения модели, перерисовываться будет только
    // данный виджет, зависящий от значения счетчика.
    final counter = CounterProvider.of(context);

    return Text(
      '${counter.count}',
      // Стоит обратить внимание на очевидную схожесть работы Theme с нашим
      // CounterProvider. Все потому что под капотом Theme также использует
      // метод dependOnInheritedWidgetOfExactType().
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: counter.color,
          ),
    );
  }
}

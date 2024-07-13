import 'package:flutter/material.dart';
import 'package:notification_listeners_example/model/counter_model.dart';

/// Пример "проводника", благодаря которому можно внедрить модель или контроллер
/// в дерево виджетов (или, если хотите, в context).
///
/// Наследование от InheritedNotifier позволяет следить за изменениями в модели,
/// для этого необходимо передать в его конструктор модель, наследованную от
/// ChangeNotifier через super(notifier: model).
///
/// Параметр child - это дочерний виджет, которому будет доступно обращение
/// к модели через контекст.
class CounterProvider extends InheritedNotifier {
  const CounterProvider({
    super.key,
    required this.model,
    required Widget child,
  }) : super(
          notifier: model,
          child: child,
        );

  /// Модель счетчика.
  final CounterModel model;

  /// Метод maybeOf() в зависимости от необходимости подписки на изменения в
  /// модели возвращает один из двух методов:
  /// * первый метод dependOnInheritedWidgetOfExactType() ищет выше по дереву
  ///   относительно места его вызова ближайший экземпляр класса CounterProvider
  ///   и подписывается на изменения;
  /// * второй метод getInheritedWidgetOfExactType() также ищет выше по дереву
  ///   ближайший экземпляр класса CounterProvider, но не перестраивает виджет,
  ///   из которого данный метод был вызван, при изменениях в модели.
  /// Стоит отметить, что оба этих метода находят нужный экземпляр класса
  /// CounterProvider в контексте за O(1).
  static CounterModel? maybeOf(
    BuildContext context, {
    bool listen = true,
  }) =>
      listen
          ? context.dependOnInheritedWidgetOfExactType<CounterProvider>()?.model
          : context.getInheritedWidgetOfExactType<CounterProvider>()?.model;

  /// Метод of() используется для получения non-nullable значения. В случае,
  /// если ближайший экземпляр класса CounterProvider не будет найден, т.е.
  /// метод maybeOf() вернет null, значит мы либо не встроили CounterProvider
  /// в дерево вообще, либо пытаемся к нему обратиться из соседней или
  /// вышележащей ветки дерева виджетов.
  static CounterModel of<CounterProvider extends InheritedNotifier>(
    BuildContext context, {
    bool listen = true,
  }) =>
      maybeOf(context, listen: listen) ??
      (throw ArgumentError('No $CounterModel found in context'));
}

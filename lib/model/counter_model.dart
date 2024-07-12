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
  Color _color = Colors.black;

  int get count => _count;
  Color get color => _color;

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

  void changeColor() {
    _color = Colors.primaries[Random().nextInt(
      Colors.primaries.length,
    )];
    // Метод для оповещения слушателей об изменении в CounterModel.
    notifyListeners();
  }
}

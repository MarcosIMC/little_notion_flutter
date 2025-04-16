import 'package:flutter/cupertino.dart';

import '../models/categories.dart';

class CategoriesProvider with ChangeNotifier {
  Set<CategoriesEnum> _selectedCategory = {};

  Set<CategoriesEnum> get selectedCategory => _selectedCategory;

  void add(CategoriesEnum category) {
    _selectedCategory.add(category);
    notifyListeners();
  }

  void remove(CategoriesEnum category) {
    _selectedCategory.remove(category);
    notifyListeners();
  }

  bool contains(CategoriesEnum category) {
    return _selectedCategory.contains(category);
  }
}
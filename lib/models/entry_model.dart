import 'package:mini_notion/models/categories.dart';

class Entry {
  String _title;
  String _description;
  CategoriesEnum _categories;

  Entry(this._title, this._description, this._categories);

  CategoriesEnum get categories => _categories;

  String get description => _description;

  String get title => _title;

}
import 'package:mini_notion/models/categories.dart';

class Entry {
  String _id;
  String _title;
  String _description;
  List<CategoriesEnum> _categories;
  String _date;

  Entry(this._id, this._title, this._description, this._categories, this._date);

  List<CategoriesEnum> get categories => _categories;

  String get id => _id;

  String get description => _description;

  String get title => _title;

  String get date => _date;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'categories': categories.join(','),
      'date': date
    };
  }
}
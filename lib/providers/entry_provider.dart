import 'package:flutter/widgets.dart';
import 'package:mini_notion/models/entry_model.dart';
import 'package:mini_notion/services/sql_helper.dart';

class EntryProvider with ChangeNotifier {
  final SqlHelper _sqlHelper = SqlHelper.instance;
  Entry? _entry;

  void addEntry(Entry newEntry) async {
    var rowId = await _sqlHelper.insertEntry(newEntry);

    if (rowId != null) {
      notifyListeners();
    }
  }
}
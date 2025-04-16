import 'package:flutter/widgets.dart';

class FormEntryProvider extends ChangeNotifier {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  bool validateForm(GlobalKey<FormState> formKey) {
    if (formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  void resetForm() {
    titleController.clear();
    descriptionController.clear();
    notifyListeners();
  }
}
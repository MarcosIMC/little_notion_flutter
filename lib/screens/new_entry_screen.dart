import 'package:flutter/material.dart';
import 'package:mini_notion/models/entry_model.dart';
import 'package:mini_notion/providers/entry_provider.dart';
import 'package:mini_notion/providers/new_entry_form_provider.dart';
import 'package:mini_notion/widgets/filter_chip.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../providers/categories_provider.dart';

class NewEntryScreen extends StatefulWidget {
  const NewEntryScreen({super.key});

  @override
  State<NewEntryScreen> createState() => _NewEntryScreenState();
}

class _NewEntryScreenState extends State<NewEntryScreen> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final formProvider = Provider.of<FormEntryProvider>(context);
    final entryProvider = Provider.of<EntryProvider>(context);
    final categoriesProvider = Provider.of<CategoriesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Entry'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: formProvider.titleController,
                    decoration: const InputDecoration(
                        labelText: 'Title...'
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please, type a title for a new entry.';
                      }
                      return null;
                    },
                  ),
                  FilterChipWidget(),
                  Divider(),
                  SingleChildScrollView(
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 10,
                      controller: formProvider.descriptionController,
                      decoration: InputDecoration(
                          hintText: 'Type ur task...',
                          border: OutlineInputBorder()
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please, type a task description.';
                        }
                        return null;
                      },
                    ),
                  ),
                  Divider(),
                  FilledButton(onPressed: () {
                    if (formProvider.validateForm(_formKey)) {
                      entryProvider.addEntry(Entry(Uuid().v4(), formProvider.titleController.text, formProvider.descriptionController.text, categoriesProvider.selectedCategory.toList(), DateTime.now().toIso8601String()));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Task created!')));
                      Navigator.of(context).pop();
                    }
                  },
                    child: Text('Save'),
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}

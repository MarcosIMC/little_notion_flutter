import 'package:flutter/material.dart';
import 'package:mini_notion/widgets/filter_chip.dart';

class NewEntryScreen extends StatefulWidget {
  const NewEntryScreen({super.key});

  @override
  State<NewEntryScreen> createState() => _NewEntryScreenState();
}

class _NewEntryScreenState extends State<NewEntryScreen> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

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
                      decoration: InputDecoration(
                          hintText: 'Type ur task...',
                          border: OutlineInputBorder()
                      ),
                    ),
                  ),
                  Divider(),
                  FilledButton(onPressed: () {

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

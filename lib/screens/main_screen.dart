import 'package:flutter/material.dart';
import 'package:mini_notion/models/categories.dart';
import 'package:mini_notion/models/entry_model.dart';
import 'package:mini_notion/screens/new_entry_screen.dart';

import '../widgets/entry_item.dart';

class MainScreen extends StatefulWidget {
  final List<Entry> entries;

  const MainScreen({super.key, required this.entries});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mini Notion'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search))
        ],
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(10),
        itemCount: widget.entries.length,
        itemBuilder: (context, index) {
          return EntryItem(entry: Entry(widget.entries[index].title, widget.entries[index].description, widget.entries[index].categories));
        }, separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => NewEntryScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

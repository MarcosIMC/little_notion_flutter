import 'package:flutter/material.dart';
import 'package:mini_notion/screens/new_entry_screen.dart';

import '../widgets/entry_item.dart';
import '../widgets/list_item.dart';

class MainScreen extends StatefulWidget {



  const MainScreen({super.key});

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
      body: ListItem(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => NewEntryScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

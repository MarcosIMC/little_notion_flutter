import 'package:flutter/material.dart';
import 'package:mini_notion/providers/entry_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../models/entry_model.dart';
import 'entry_item.dart';

class ListItem extends StatefulWidget {
  const ListItem({super.key});

  @override
  State<ListItem> createState() => _ListItemState();
}

Future<List<Entry>> fetchAll(EntryProvider provider) async {
  final data = await provider.allEntries();
  return data;
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    final entryProvider =  Provider.of<EntryProvider>(context);

    return FutureBuilder(future: fetchAll(entryProvider), builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return Center(
          child: Text('You don\'t have any task right now.'),
        );
      } else if (snapshot.hasError) {
        return Center(
          child: Text('error: ${snapshot.hasError}'),
        );
      } else {
       return ListView.separated(
         padding: EdgeInsets.all(10),
         itemCount: snapshot.data!.length,
         itemBuilder: (context, index) {
           Entry entry = snapshot.data![index];
           return EntryItem(entry: Entry(entry.id, entry.title, entry.description, entry.categories, entry.date));
         }, separatorBuilder: (BuildContext context, int index) => const Divider(),
       );
      }
    });
  }
}

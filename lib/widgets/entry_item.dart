import 'package:flutter/material.dart';
import 'package:mini_notion/models/entry_model.dart';

class EntryItem extends StatefulWidget {
  final Entry entry;
  const EntryItem({super.key, required this.entry});

  @override
  State<EntryItem> createState() => _EntryItemState();
}

class _EntryItemState extends State<EntryItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.entry.title),
      trailing: Icon(Icons.arrow_forward_ios),
      tileColor: Colors.blueGrey,
      textColor: Colors.white,
      iconColor: Colors.white,
      onTap: () {

      },
    );
  }
}

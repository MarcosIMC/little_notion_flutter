import 'package:flutter/material.dart';

import '../models/entry_model.dart';

class DetailTaskScreen extends StatefulWidget {
  final Entry entry;
  const DetailTaskScreen({super.key, required this.entry});

  @override
  State<DetailTaskScreen> createState() => _DetailTaskScreenState();
}

class _DetailTaskScreenState extends State<DetailTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.entry.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Text('Category'),
                SizedBox(width: 5,),

              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Text('Date'),
                SizedBox(width: 10,),
                Text(widget.entry.date)
              ],
            ),
            SizedBox(height: 10,),
            Divider(),
            SingleChildScrollView(
              child: TextFormField(
                readOnly: true,
                maxLines: 10,
                initialValue: widget.entry.description,
              ),
            )
          ],
        ),
      )
    );
  }
}

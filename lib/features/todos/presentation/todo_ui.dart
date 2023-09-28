import 'package:flutter/material.dart';

class TodoUI extends StatelessWidget {
  final String id;
  final String title;
  const TodoUI({
    Key? key,
    required this.id,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo: $id"),
      ),
      body: Center(
        child: Text(title),
      ),
    );
  }
}

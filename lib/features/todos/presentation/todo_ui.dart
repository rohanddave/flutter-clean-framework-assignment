import 'package:flutter/material.dart';

class TodoUI extends StatelessWidget {
  final String id;

  const TodoUI({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo: $id"),
      ),
    );
  }
}

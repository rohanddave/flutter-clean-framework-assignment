import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  final String title;
  final int id;
  final Function() onTap;

  const TodoCard({
    Key? key,
    required this.title,
    required this.id,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 160,
        child: Card(
          color: const Color(0xff22b65d),
          child: Center(
            child: ListTile(
              title: Text(title),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todos/widgets/todo_card.dart';

void main() {
  testWidgets('TodoCard test', (tester) async {
    String title = "Test";
    await tester.pumpWidget(
      MaterialApp(
        home: TodoCard(
          id: 1,
          title: title,
          onTap: () {},
        ),
      ),
    );
    await tester.pumpAndSettle();

    final cardMaterialFinder = find.descendant(
      of: find.byType(Card),
      matching: find.byType(Material),
    );
    final titleFinder = find.text(title);

    Material material = tester.widget<Material>(cardMaterialFinder);
    expect(material.color, equals(const Color(0xff22b65d)));
    expect(titleFinder, findsOneWidget);
  });
}

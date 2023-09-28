import 'package:flutter_test/flutter_test.dart';
import 'package:todos/features/todos/models/todo_model.dart';

void main() {
  group('TodoModel Equality Test', () {
    test('Two TodoModel instances with the same id should be equal', () {
      final todo1 = TodoModel(title: 'Task 1', id: 1);
      final todo2 = TodoModel(title: 'Task 2', id: 1);

      expect(todo1, equals(todo2));
    });

    test('Two TodoModel instances with different ids should not be equal', () {
      final todo1 = TodoModel(title: 'Task 1', id: 1);
      final todo2 = TodoModel(title: 'Task 2', id: 2);

      expect(todo1, isNot(equals(todo2)));
    });
  });

  group('TodoModel HashCode Test', () {
    test(
        'Two TodoModel instances with the same id should have the same hashCode',
        () {
      final todo1 = TodoModel(title: 'Task 1', id: 1);
      final todo2 = TodoModel(title: 'Task 2', id: 1);

      expect(todo1.hashCode, equals(todo2.hashCode));
    });

    test(
        'Two TodoModel instances with different ids should have different hashCodes',
        () {
      final todo1 = TodoModel(title: 'Task 1', id: 1);
      final todo2 = TodoModel(title: 'Task 2', id: 2);

      expect(todo1.hashCode, isNot(equals(todo2.hashCode)));
    });
  });
}

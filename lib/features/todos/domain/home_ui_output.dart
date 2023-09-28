import 'package:clean_framework/clean_framework.dart';
import 'package:todos/features/todos/domain/home_entity.dart';
import 'package:todos/features/todos/models/todo_model.dart';

class HomeUIOutput extends Output {
  const HomeUIOutput({
    required this.todos,
    required this.status,
    required this.isRefresh,
  });

  final List<TodoModel> todos;
  final HomeStatus status;
  final bool isRefresh;

  @override
  List<Object?> get props => [todos, status, isRefresh];
}

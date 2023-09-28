import 'package:clean_framework/clean_framework.dart';
import 'package:todos/features/todos/models/todo_model.dart';

enum HomeStatus { initial, loading, loaded, failed }

class HomeEntity extends Entity {
  const HomeEntity({
    this.todos = const [],
    this.status = HomeStatus.initial,
    this.isRefresh = false,
  });

  final List<TodoModel> todos;
  final HomeStatus status;
  final bool isRefresh;

  @override
  List<Object?> get props {
    return [todos, status, isRefresh];
  }

  @override
  HomeEntity copyWith({
    List<TodoModel>? todos,
    HomeStatus? status,
    bool? isRefresh,
    String? loggedInEmail,
  }) {
    return HomeEntity(
      todos: todos ?? this.todos,
      status: status ?? this.status,
      isRefresh: isRefresh ?? this.isRefresh,
    );
  }
}

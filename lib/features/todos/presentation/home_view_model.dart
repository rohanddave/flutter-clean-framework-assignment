import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/foundation.dart';
import 'package:todos/features/todos/models/todo_model.dart';

class HomeViewModel extends ViewModel {
  const HomeViewModel({
    required this.todos,
    required this.isLoading,
    required this.hasFailedLoading,
    required this.onRetry,
    required this.onRefresh,
  });

  final List<TodoModel> todos;
  final bool isLoading;
  final bool hasFailedLoading;

  final VoidCallback onRetry;
  final AsyncCallback onRefresh;

  @override
  List<Object?> get props => [isLoading, hasFailedLoading, todos];
}

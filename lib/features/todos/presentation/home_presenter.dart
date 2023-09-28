import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';
import 'package:todos/features/todos/domain/home_entity.dart';
import 'package:todos/features/todos/domain/home_ui_output.dart';
import 'package:todos/features/todos/domain/home_use_case.dart';
import 'package:todos/features/todos/presentation/home_view_model.dart';
import 'package:todos/providers.dart';

class HomePresenter
    extends Presenter<HomeViewModel, HomeUIOutput, HomeUseCase> {
  HomePresenter({
    super.key,
    required super.builder,
  }) : super(provider: homeUseCaseProvider);

  @override
  void onLayoutReady(BuildContext context, HomeUseCase useCase) {
    useCase.fetchTodos();
  }

  @override
  HomeViewModel createViewModel(HomeUseCase useCase, HomeUIOutput output) {
    return HomeViewModel(
      todos: output.todos,
      onRefresh: () => useCase.fetchTodos(isRefresh: true),
      onRetry: useCase.fetchTodos,
      isLoading: output.status == HomeStatus.loading,
      hasFailedLoading: output.status == HomeStatus.failed,
    );
  }

  @override
  void onOutputUpdate(BuildContext context, HomeUIOutput output) async {
    if (output.isRefresh) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            output.status == HomeStatus.failed
                ? 'Sorry, failed refreshing!'
                : 'Refreshed successfully!',
          ),
        ),
      );
    }
  }
}

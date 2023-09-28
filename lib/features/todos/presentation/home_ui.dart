import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework_router/clean_framework_router.dart';
import 'package:flutter/material.dart';
import 'package:todos/features/todos/presentation/home_presenter.dart';
import 'package:todos/features/todos/presentation/home_view_model.dart';
import 'package:todos/routing/routes.dart';
import 'package:todos/widgets/todo_card.dart';

class HomeUI extends UI<HomeViewModel> {
  HomeUI({super.key});

  @override
  HomePresenter create(WidgetBuilder builder) {
    return HomePresenter(builder: builder);
  }

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    final textTheme = Theme.of(context).textTheme;

    Widget child;
    if (viewModel.isLoading) {
      child = const Center(child: CircularProgressIndicator());
    } else if (viewModel.hasFailedLoading) {
      child = _LoadingFailed(onRetry: viewModel.onRetry);
    } else {
      child = RefreshIndicator(
        onRefresh: viewModel.onRefresh,
        child: Scrollbar(
          thumbVisibility: true,
          child: ListView.builder(
            itemCount: viewModel.todos.length,
            prototypeItem: const SizedBox(height: 176), // 160 + 16
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              final todo = viewModel.todos[index];

              return TodoCard(
                title: todo.title,
                id: todo.id,
                onTap: () => context.router
                    .go(Routes.todo, params: {'todo_id': todo.id.toString()}),
              );
            },
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
        centerTitle: false,
        titleTextStyle: textTheme.displaySmall!.copyWith(
          fontWeight: FontWeight.w300,
        ),
      ),
      body: child,
    );
  }
}

class _LoadingFailed extends StatelessWidget {
  const _LoadingFailed({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            'Oops, loading failed.',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 24),
          OutlinedButton(
            onPressed: onRetry,
            child: const Text('Failed to load todos!'),
          ),
          const SizedBox(height: 64),
        ],
      ),
    );
  }
}

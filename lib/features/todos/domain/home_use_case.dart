import 'package:clean_framework/clean_framework.dart';
import 'package:todos/features/todos/domain/home_entity.dart';
import 'package:todos/features/todos/domain/home_ui_output.dart';
import 'package:todos/features/todos/external_interface/todo_collection_gateway.dart';
import 'package:todos/features/todos/models/todo_model.dart';

class HomeUseCase extends UseCase<HomeEntity> {
  HomeUseCase()
      : super(entity: const HomeEntity(), transformers: [
          HomeUIOutputTransformer(),
        ]);

  Future<void> fetchTodos({bool isRefresh = false}) async {
    if (!isRefresh) {
      entity = entity.copyWith(status: HomeStatus.loading);
    }

    final input = await getInput(TodoCollectionGatewayOutput());
    switch (input) {
      case Success(:TodoCollectionSuccessInput input):
        final todos = input.todoIdentities.map(_resolveTodo);

        entity = entity.copyWith(
          todos: todos.toList(growable: false),
          status: HomeStatus.loaded,
          isRefresh: isRefresh,
        );
      case _:
        entity = entity.copyWith(
          status: HomeStatus.failed,
          isRefresh: isRefresh,
        );
    }

    if (isRefresh) {
      entity = entity.copyWith(isRefresh: false, status: HomeStatus.loaded);
    }
  }

  TodoModel _resolveTodo(TodoIdentity todo) {
    return TodoModel(
      title: todo.title.toUpperCase(),
      id: todo.id,
    );
  }
}

class HomeUIOutputTransformer
    extends OutputTransformer<HomeEntity, HomeUIOutput> {
  @override
  HomeUIOutput transform(HomeEntity entity) {
    return HomeUIOutput(
      todos: entity.todos,
      status: entity.status,
      isRefresh: entity.isRefresh,
    );
  }
}

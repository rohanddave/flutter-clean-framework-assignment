import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework_test/clean_framework_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todos/features/todos/domain/home_entity.dart';
import 'package:todos/features/todos/domain/home_ui_output.dart';
import 'package:todos/features/todos/domain/home_use_case.dart';
import 'package:todos/features/todos/external_interface/todo_collection_gateway.dart';
import 'package:todos/features/todos/models/todo_model.dart';
import 'package:todos/providers.dart';

void main() {
  final todos = [
    TodoModel(
      title: 'todo 1',
      id: 1,
    ),
    TodoModel(
      title: 'todo 2',
      id: 2,
    ),
  ];

  group('HomeUseCase test |', () {
    useCaseTest<HomeUseCase, HomeEntity, HomeUIOutput>(
      'fetch todos; success',
      provider: homeUseCaseProvider,
      execute: (useCase) {
        _mockSuccess(useCase);

        return useCase.fetchTodos();
      },
      expect: () => [
        const HomeUIOutput(
          todos: [],
          status: HomeStatus.loading,
          isRefresh: false,
        ),
        HomeUIOutput(
          todos: todos,
          status: HomeStatus.loaded,
          isRefresh: false,
        ),
      ],
      verify: (useCase) {
        expect(
          useCase.debugEntity,
          HomeEntity(todos: todos, status: HomeStatus.loaded),
        );
      },
    );

    useCaseTest<HomeUseCase, HomeEntity, HomeUIOutput>(
      'refresh todos; success',
      provider: homeUseCaseProvider,
      execute: (useCase) {
        _mockSuccess(useCase);

        return useCase.fetchTodos(isRefresh: true);
      },
      expect: () {
        return [
          HomeUIOutput(
            todos: todos,
            status: HomeStatus.loaded,
            isRefresh: true,
          ),
          HomeUIOutput(
            todos: todos,
            status: HomeStatus.loaded,
            isRefresh: false,
          ),
        ];
      },
    );

    useCaseTest<HomeUseCase, HomeEntity, HomeUIOutput>(
      'fetch todos; failure',
      provider: homeUseCaseProvider,
      execute: (useCase) {
        _mockFailure(useCase);

        return useCase.fetchTodos();
      },
      expect: () => [
        const HomeUIOutput(
          todos: [],
          status: HomeStatus.loading,
          isRefresh: false,
        ),
        const HomeUIOutput(
          todos: [],
          status: HomeStatus.failed,
          isRefresh: false,
        ),
      ],
    );

    useCaseTest<HomeUseCase, HomeEntity, HomeUIOutput>(
      'refresh todos; failure',
      provider: homeUseCaseProvider,
      execute: (useCase) {
        _mockFailure(useCase);

        return useCase.fetchTodos(isRefresh: true);
      },
      expect: () => [
        const HomeUIOutput(
          todos: [],
          status: HomeStatus.failed,
          isRefresh: true,
        ),
        const HomeUIOutput(
          todos: [],
          status: HomeStatus.loaded,
          isRefresh: false,
        ),
      ],
    );
  });
}

void _mockSuccess(HomeUseCase useCase) {
  useCase.subscribe<TodoCollectionGatewayOutput, TodoCollectionSuccessInput>(
    (_) async {
      return Either.right(
        TodoCollectionSuccessInput(
          todoIdentities: [
            TodoIdentity(title: 'todo 1', id: 1),
            TodoIdentity(title: 'todo 2', id: 2),
          ],
        ),
      );
    },
  );
}

void _mockFailure(HomeUseCase useCase) {
  useCase.subscribe<TodoCollectionGatewayOutput, TodoCollectionSuccessInput>(
    (_) async {
      return const Either.left(FailureInput(message: 'No Internet'));
    },
  );
}

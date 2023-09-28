import 'package:clean_framework_test/clean_framework_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todos/features/todos/domain/home_entity.dart';
import 'package:todos/features/todos/domain/home_ui_output.dart';
import 'package:todos/features/todos/domain/home_use_case.dart';
import 'package:todos/features/todos/models/todo_model.dart';
import 'package:todos/features/todos/presentation/home_presenter.dart';
import 'package:todos/features/todos/presentation/home_view_model.dart';
import 'package:todos/providers.dart';

void main() {
  group('HomePresenter tests |', () {
    presenterTest<HomeViewModel, HomeUIOutput, HomeUseCase>(
      'creates proper view model',
      create: (builder) => HomePresenter(builder: builder),
      overrides: [
        homeUseCaseProvider.overrideWith(HomeUseCaseFake()),
      ],
      setup: (useCase) {
        useCase.debugEntityUpdate(
          (e) => e.copyWith(
            todos: [
              TodoModel(title: 'todo 1', id: 1),
              TodoModel(title: 'todo 2', id: 2),
            ],
          ),
        );
      },
      expect: () => [
        isA<HomeViewModel>().having((vm) => vm.todos, 'todos', []),
        isA<HomeViewModel>().having(
          (vm) => vm.todos.map((p) => p.title),
          'todos',
          ['todo 1', 'todo 2'],
        ),
      ],
    );

    presenterTest<HomeViewModel, HomeUIOutput, HomeUseCase>(
      'shows success snack bar if refreshing succeeds',
      create: (builder) => HomePresenter(builder: builder),
      overrides: [
        homeUseCaseProvider.overrideWith(HomeUseCaseFake()),
      ],
      setup: (useCase) {
        useCase.debugEntityUpdate(
          (e) => e.copyWith(
            isRefresh: true,
            status: HomeStatus.loaded,
          ),
        );
      },
      verify: (tester) {
        expect(
          find.text('Refreshed successfully!'),
          findsOneWidget,
        );
      },
    );

    presenterTest<HomeViewModel, HomeUIOutput, HomeUseCase>(
      'shows failure snack bar if refreshing fails',
      create: (builder) => HomePresenter(builder: builder),
      overrides: [
        homeUseCaseProvider.overrideWith(HomeUseCaseFake()),
      ],
      setup: (useCase) {
        useCase.debugEntityUpdate(
          (e) => e.copyWith(
            isRefresh: true,
            status: HomeStatus.failed,
          ),
        );
      },
      verify: (tester) {
        expect(
          find.text('Sorry, failed refreshing!'),
          findsOneWidget,
        );
      },
    );

    presenterCallbackTest<HomeViewModel, HomeUIOutput, HomeUseCase>(
      'calls refresh pokemon in use case',
      useCase: HomeUseCaseMock(),
      create: (builder) => HomePresenter(builder: builder),
      setup: (useCase) {
        when(() => useCase.fetchTodos(isRefresh: true))
            .thenAnswer((_) async {});
      },
      verify: (useCase, vm) {
        vm.onRefresh();

        verify(() => useCase.fetchTodos(isRefresh: true));
      },
    );
  });
}

class HomeUseCaseFake extends HomeUseCase {
  @override
  Future<void> fetchTodos({bool isRefresh = false}) async {}
}

class HomeUseCaseMock extends UseCaseMock<HomeEntity> implements HomeUseCase {
  HomeUseCaseMock()
      : super(
          entity: const HomeEntity(),
          transformers: [HomeUIOutputTransformer()],
        );
}

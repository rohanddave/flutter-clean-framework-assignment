import 'package:clean_framework_router/clean_framework_router.dart';
import 'package:clean_framework_test/clean_framework_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todos/features/todos/models/todo_model.dart';
import 'package:todos/features/todos/presentation/home_ui.dart';
import 'package:todos/features/todos/presentation/home_view_model.dart';
import 'package:todos/routing/routes.dart';
import 'package:todos/widgets/todo_card.dart';

void main() {
  group('HomeUI tests |', () {
    uiTest(
      'shows pokemon list correctly',
      ui: HomeUI(),
      viewModel: HomeViewModel(
        todos: [
          TodoModel(title: 'todo 1', id: 1),
          TodoModel(title: 'todo 2', id: 2),
        ],
        isLoading: false,
        hasFailedLoading: false,
        onRetry: () {},
        onRefresh: () async {},
      ),
      verify: (tester) async {
        expect(find.text('todo 1'), findsOneWidget);
        expect(find.text('todo 2'), findsOneWidget);
      },
    );

    uiTest(
      'shows loading indicator if loading data',
      ui: HomeUI(),
      viewModel: HomeViewModel(
        todos: const [],
        isLoading: true,
        hasFailedLoading: false,
        onRetry: () {},
        onRefresh: () async {},
      ),
      verify: (tester) async {
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );

    uiTest(
      'shows loading failed widget if data failed loading',
      ui: HomeUI(),
      viewModel: HomeViewModel(
        todos: const [],
        isLoading: false,
        hasFailedLoading: true,
        onRetry: () {},
        onRefresh: () async {},
      ),
      verify: (tester) async {
        expect(find.text('Oops, loading failed.'), findsOneWidget);
        expect(find.text('Failed to load todos!'), findsOneWidget);
      },
    );

    uiTest(
      'tapping on pokemon navigates to detail page',
      ui: HomeUI(),
      viewModel: HomeViewModel(
        todos: [
          TodoModel(title: 'todo 1', id: 1),
          TodoModel(title: 'todo 2', id: 2),
        ],
        isLoading: false,
        hasFailedLoading: false,
        onRetry: () {},
        onRefresh: () async {},
      ),
      verify: (tester) async {
        await tester.pumpAndSettle();

        final todo1CardFinder = find.descendant(
          of: find.byType(TodoCard),
          matching: find.text('todo 1'),
        );

        expect(todo1CardFinder, findsOneWidget);

        await tester.tap(todo1CardFinder);
        await tester.pumpAndSettle();

        final routeData = tester.routeData!;
        expect(routeData.route, Routes.todo);
        expect(routeData.params, equals({'todo_id': '1', 'title': 'todo 1'}));

        tester.element(find.byType(MaterialApp)).router.pop();
        await tester.pumpAndSettle();

        final poppedRouteData = tester.poppedRouteData!;
        expect(poppedRouteData.route, Routes.todo);
        expect(poppedRouteData.params,
            equals({'todo_id': '1', 'title': 'todo 1'}));
      },
    );
  });
}

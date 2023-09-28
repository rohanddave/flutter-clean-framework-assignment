import 'package:clean_framework_router/clean_framework_router.dart';
import 'package:todos/features/todos/presentation/home_ui.dart';
import 'package:todos/features/todos/presentation/todo_ui.dart';
import 'package:todos/routing/routes.dart';

class TodoAppRouter extends AppRouter<Routes> {
  @override
  RouterConfiguration configureRouter() {
    return RouterConfiguration(
      debugLogDiagnostics: true,
      routes: [
        AppRoute(
          route: Routes.home,
          builder: (_, __) => HomeUI(),
          routes: [
            AppRoute.custom(
              route: Routes.todo,
              builder: (_, state) {
                return TodoUI(id: state.params['todo_id'] ?? '');
              },
            ),
          ],
        ),
      ],
    );
  }
}

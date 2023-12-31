import 'package:clean_framework_router/clean_framework_router.dart';

enum Routes with RoutesMixin {
  home('/'),
  todo(':todo_id/:title');

  const Routes(this.path);

  @override
  final String path;
}

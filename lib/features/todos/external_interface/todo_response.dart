import 'package:clean_framework/clean_framework.dart';

class TodoSuccessResponse extends SuccessResponse {
  const TodoSuccessResponse({required this.data});

  final Map<String, dynamic> data;
}

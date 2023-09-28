import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework_http/clean_framework_http.dart';
import 'package:todos/features/todos/external_interface/todo_request.dart';

class TodoCollectionGateway extends Gateway<TodoCollectionGatewayOutput,
    TodoCollectionRequest, SuccessResponse, TodoCollectionSuccessInput> {
  @override
  TodoCollectionRequest buildRequest(TodoCollectionGatewayOutput output) {
    return TodoCollectionRequest();
  }

  @override
  FailureInput onFailure(covariant FailureResponse failureResponse) {
    return FailureInput(message: failureResponse.message);
  }

  @override
  TodoCollectionSuccessInput onSuccess(JsonArrayHttpSuccessResponse response) {
    return TodoCollectionSuccessInput(
      todoIdentities: List.from(
        response.data.map(
          (e) => TodoIdentity.fromJson(e),
        ),
      ),
    );
  }
}

class TodoCollectionGatewayOutput extends Output {
  @override
  List<Object?> get props => [];
}

class TodoCollectionSuccessInput extends SuccessInput {
  TodoCollectionSuccessInput({required this.todoIdentities});

  final List<TodoIdentity> todoIdentities;
}

class TodoIdentity {
  final String title;
  final int id;

  TodoIdentity({required this.title, required this.id});

  factory TodoIdentity.fromJson(Map<String, dynamic> json) {
    return TodoIdentity(
      title: json['title'],
      id: json['id'],
    );
  }
}

class TodoCollectionRequest extends GetTodosRequest {
  @override
  String get path => 'todos';
}

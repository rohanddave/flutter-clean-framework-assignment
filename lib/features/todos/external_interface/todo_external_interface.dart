// import 'package:dio/dio.dart';

// class TodoExternalInterface
//     extends ExternalInterface<TodoRequest, TodoSuccessResponse> {
//   TodoExternalInterface({
//     Dio? dio,
//   }) : _dio = dio ??
//             Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com/'));

//   final Dio _dio;

//   @override
//   void handleRequest() {
//     on<GetTodosRequest>(
//       (request, send) async {
//         final response = await _dio.get<List<dynamic>>(
//           request.resource,
//           queryParameters: request.queryParams,
//         );

//         final data = response.data!;

//         send(TodoSuccessResponse(data: {'data': data}));
//       },
//     );

//     on<AddTodoRequest>((request, send) async {
//       await Future.delayed(const Duration(seconds: 3));

//       final response = await Future.value({
//         'title': request.todo.title,
//         'id': 'xuz',
//       });

//       send(TodoSuccessResponse(data: response));
//     });

//     on<RemoveTodoRequest>((request, send) async {
//       await Future.delayed(const Duration(seconds: 3));

//       final response = await Future.error({
//         'title': request.todo.title,
//         'id': 'xuz',
//       });

//       send(TodoSuccessResponse(data: response));
//     });
//   }

//   @override
//   FailureResponse onError(Object error) {
//     return UnknownFailureResponse(error);
//   }
// }
import 'package:clean_framework_http/clean_framework_http.dart';
import 'dart:async';

class TodoExternalInterface extends HttpExternalInterface {
  TodoExternalInterface()
      : super(delegate: _TodoHttpExternalInterfaceDelegate());
}

class _TodoHttpExternalInterfaceDelegate extends HttpExternalInterfaceDelegate {
  _TodoHttpExternalInterfaceDelegate();

  @override
  Future<HttpOptions> buildOptions() async {
    return const HttpOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com/',
      responseType: HttpResponseType.json,
    );
  }
}

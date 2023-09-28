import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework_http/clean_framework_http.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todos/features/todos/external_interface/todo_collection_gateway.dart';

void main() {
  group('TodoCollectionGateway tests |', () {
    test('verify request', () async {
      final gateway = TodoCollectionGateway();
      final gatewayOutput = TodoCollectionGatewayOutput();

      final request = gateway.buildRequest(gatewayOutput);

      expect(request.path, equals('todos'));

      expect(gatewayOutput, TodoCollectionGatewayOutput());
    });

    test('success', () async {
      final gateway = TodoCollectionGateway()
        ..feedResponse(
          (request) async => const Either.right(
            JsonArrayHttpSuccessResponse(
              [
                {
                  'title': 'todo 1',
                  'id': 1,
                },
                {
                  'title': 'todo 2',
                  'id': 2,
                }
              ],
              200,
            ),
          ),
        );

      final input = await gateway.buildInput(TodoCollectionGatewayOutput());

      expect(input.isRight, isTrue);

      final identities = input.right.todoIdentities;

      expect(identities.first.title, equals('todo 1'));
      expect(identities.first.id, equals(1));

      expect(identities.last.title, equals('todo 2'));
      expect(identities.last.id, equals(2));
    });

    test('failure', () async {
      final gateway = TodoCollectionGateway()
        ..feedResponse(
          (request) async => Either.left(
            UnknownFailureResponse('No Internet'),
          ),
        );

      final input = await gateway.buildInput(TodoCollectionGatewayOutput());

      expect(input.isLeft, isTrue);

      expect(input.left.message, equals('No Internet'));
    });
  });
}

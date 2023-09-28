import 'package:clean_framework/clean_framework.dart' hide Response;
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todos/features/todos/external_interface/todo_collection_gateway.dart';
import 'package:todos/providers.dart';

final restClientProvider = DependencyProvider(
  (_) => Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com/')),
);

void main() {
  group('TodoExternalInterface tests |', () {
    test('get request success', () async {
      final container = ProviderContainer(
        overrides: [
          restClientProvider.overrideWith(DioMock()),
        ],
      );
      final dio = restClientProvider.read(container);
      final interface = todoExternalInterfaceProvider.read(container);

      when(
        () => dio.get<dynamic>(
          'todos',
        ),
      ).thenAnswer(
        (_) async => Response(
          data: {'title': 'todo 1'},
          requestOptions: RequestOptions(path: 'todos'),
        ),
      );

      final result = await interface.request(TodoCollectionRequest());

      expect(result.isRight, isTrue);
      expect(result.right.data, isA<List>());
    });

    // test('get request failure', () async {
    //   final container = ProviderContainer(
    //     overrides: [
    //       restClientProvider.overrideWith(DioMock()),
    //     ],
    //   );

    //   final interface = todoExternalInterfaceProvider.read(container);
    //   final dio = restClientProvider.read(container);

    //   when(
    //     () => dio.get<Map<String, dynamic>>(
    //       'todos',
    //     ),
    //   ).thenThrow(const HttpException('No Internet'));

    //   await interface.request(TodoCollectionRequest());

    // expect(result.isLeft, isTrue);
    // expect(
    //   result.left.message,
    //   equals(const HttpException('No Internet').toString()),
    // );
    // });
  });
}

class DioMock extends Mock implements Dio {}

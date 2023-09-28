import 'package:clean_framework/clean_framework.dart';
import 'package:todos/features/todos/domain/home_use_case.dart';
import 'package:todos/features/todos/external_interface/todo_external_interface.dart';
import 'package:todos/features/todos/external_interface/todo_collection_gateway.dart';

final homeUseCaseProvider = UseCaseProvider(HomeUseCase.new);

final todoCollectionGateway = GatewayProvider(
  TodoCollectionGateway.new,
  useCases: [
    homeUseCaseProvider,
  ],
);

final todoExternalInterfaceProvider = ExternalInterfaceProvider(
  TodoExternalInterface.new,
  gateways: [
    todoCollectionGateway,
  ],
);

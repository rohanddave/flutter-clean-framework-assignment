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

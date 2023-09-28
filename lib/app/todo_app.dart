import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework_router/clean_framework_router.dart';
import 'package:flutter/material.dart';
import 'package:todos/providers.dart';
import 'package:todos/routing/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
    );
    final inputDecorationTheme = InputDecorationTheme(border: inputBorder);

    return AppProviderScope(
      externalInterfaceProviders: [
        todoExternalInterfaceProvider,
      ],
      child: AppRouterScope(
        create: TodoAppRouter.new,
        builder: (context) {
          return MaterialApp.router(
            title: 'Todo App',
            routerConfig: context.router.config,
            theme: ThemeData(
              colorSchemeSeed: Colors.green,
              useMaterial3: true,
              inputDecorationTheme: inputDecorationTheme,
            ),
            darkTheme: ThemeData(
              colorSchemeSeed: Colors.green,
              brightness: Brightness.light,
              useMaterial3: true,
              inputDecorationTheme: inputDecorationTheme,
            ),
            themeMode: ThemeMode.light,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

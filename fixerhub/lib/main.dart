import 'package:flutter/material.dart';
import 'package:fixerhub/core/router/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'FixerHub',
      theme: ThemeData(
        primaryColor: const Color(0xFF34A853),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF34A853)),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}

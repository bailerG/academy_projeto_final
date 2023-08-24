import '../dealer_app/presentation/pages/login_screen.dart';
import 'package:flutter/material.dart';

const colorDetail = Color.fromRGBO(134, 46, 46, 1);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anderson Automoveis',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: colorDetail,
        ),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}

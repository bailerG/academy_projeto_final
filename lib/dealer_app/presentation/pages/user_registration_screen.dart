import 'package:flutter/material.dart';

class UserRegistrationScreen extends StatelessWidget {
  const UserRegistrationScreen({super.key});

  static const routeName = '/registration';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text(
          'Hello!',
          style: TextStyle(fontSize: 50),
        ),
      ),
    );
  }
}

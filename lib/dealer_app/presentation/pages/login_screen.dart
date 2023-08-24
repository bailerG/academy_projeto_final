import 'package:desafio_academy_flutter/main.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Title(
                color: Colors.black,
                child: const Text(
                  'Welcome!',
                  textScaleFactor: 2.0,
                  style: TextStyle(
                      color: colorDetail, fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
          const LoginForm(),
        ],
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Username',
              textScaleFactor: 1.3,
              style: TextStyle(color: colorDetail, fontWeight: FontWeight.w700),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: TextFormField(
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  hintText: 'Type your username',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: TextFormField(
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  hintText: 'Type in your password',
                  prefixIcon: Icon(Icons.security),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: const ButtonStyle(
                      shape: MaterialStatePropertyAll(
                        BeveledRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.zero),
                        ),
                      ),
                    ),
                    child: const Text('Login'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Register'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

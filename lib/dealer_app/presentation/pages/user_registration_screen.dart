import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/main.dart';
import '../state/user_registration_state.dart';

class UserRegistrationScreen extends StatelessWidget {
  const UserRegistrationScreen({super.key});

  static const routeName = '/registration';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ChangeNotifierProvider(
        create: (context) => UserRegistrationState(),
        child:
            Consumer<UserRegistrationState>(builder: (context, state, child) {
          return Form(
            key: state.formState,
            child: const Padding(
              padding: EdgeInsets.all(40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ------------------- New Here Title ------------------- //
                  _NewHereTitle(),
                  //------------------- Full Name Text Field ------------------- //
                  Text(
                    'Full Name',
                    textScaleFactor: 1.3,
                    style: TextStyle(
                      color: accentColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    child: _FullNameTextField(),
                  ),
                  //------------------- Username Text Field ------------------- //
                  Text(
                    'Username',
                    textScaleFactor: 1.3,
                    style: TextStyle(
                      color: accentColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    child: _UsernameTextField(),
                  ),
                  Text(
                    'Dealership',
                    textScaleFactor: 1.3,
                    style: TextStyle(
                      color: accentColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    child: _DealershipDropdown(),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _NewHereTitle extends StatelessWidget {
  const _NewHereTitle();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Title(
        color: accentColor,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //------------------- New here title -------------------
            Text(
              'Have a new associate?',
              textScaleFactor: 2.5,
              style: TextStyle(
                color: accentColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'Please fill these fields',
              textScaleFactor: 1.2,
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FullNameTextField extends StatelessWidget {
  const _FullNameTextField();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        hintText: "Associate's full name",
        prefixIcon: Icon(Icons.person),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
      ),
    );
  }
}

class _UsernameTextField extends StatelessWidget {
  const _UsernameTextField();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        hintText: "Associate's username",
        prefixIcon: Icon(Icons.person),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
      ),
    );
  }
}

class _DealershipDropdown extends StatelessWidget {
  const _DealershipDropdown();

  static const list = ['1', '2', '3', '4'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.26,
      child: DropdownButtonFormField(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        items: List.generate(
          list.length,
          (index) => DropdownMenuItem(
            value: list[index],
            child: Text('$index'),
          ),
        ),
        onChanged: (value) {},
      ),
    );
  }
}

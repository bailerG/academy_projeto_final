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
          return SingleChildScrollView(
            child: Form(
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
                        bottom: 10,
                      ),
                      child: _DealershipDropdown(),
                    ),
                    Text(
                      'Role',
                      textScaleFactor: 1.3,
                      style: TextStyle(
                        color: accentColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 30,
                      ),
                      child: _RoleDropdown(),
                    ),
                    _RegisterButton(),
                  ],
                ),
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
      padding: const EdgeInsets.only(bottom: 30),
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
    return Consumer<UserRegistrationState>(
      builder: (context, state, child) {
        return TextFormField(
          controller: state.fullNameController,
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
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please share the associate's name";
            }
            if (value.length < 3) {
              return 'Name should be at least 3 letters long';
            }
            return null;
          },
        );
      },
    );
  }
}

class _UsernameTextField extends StatelessWidget {
  const _UsernameTextField();

  @override
  Widget build(BuildContext context) {
    return Consumer<UserRegistrationState>(
      builder: (context, state, child) {
        return TextFormField(
          controller: state.usernameController,
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
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please write a username';
            }
            if (value.length < 4) {
              return 'Username should be at least 4 letters long';
            }
            return null;
          },
        );
      },
    );
  }
}

class _DealershipDropdown extends StatelessWidget {
  const _DealershipDropdown();

  @override
  Widget build(BuildContext context) {
    return Consumer<UserRegistrationState>(
      builder: (context, state, child) {
        return SizedBox(
          width: MediaQuery.of(context).size.width / 1.26,
          child: DropdownButtonFormField(
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            items: List.generate(
              state.dealershipList.length,
              (index) => DropdownMenuItem(
                value: state.dealershipList[index],
                child: Text(state.dealershipList[index].name),
              ),
            ),
            onChanged: (value) {
              state.dealershipController = value!.id!;
              state.passwordController = value.password;
            },
            validator: (value) {
              if (value == null) {
                return 'Please select a Dealership';
              }
              return null;
            },
          ),
        );
      },
    );
  }
}

class _RoleDropdown extends StatelessWidget {
  const _RoleDropdown();

  @override
  Widget build(BuildContext context) {
    return Consumer<UserRegistrationState>(
      builder: (context, state, child) {
        return SizedBox(
          width: MediaQuery.of(context).size.width / 1.26,
          child: DropdownButtonFormField(
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            items: List.generate(
              state.roleList.length,
              (index) => DropdownMenuItem(
                value: state.roleList[index].id,
                child: Text(state.roleList[index].roleName),
              ),
            ),
            onChanged: (value) {
              state.roleController = value!;
            },
            validator: (value) {
              if (value == null) {
                return 'Please select a Role';
              }
              return null;
            },
          ),
        );
      },
    );
  }
}

class _RegisterButton extends StatelessWidget {
  const _RegisterButton();

  @override
  Widget build(BuildContext context) {
    return Consumer<UserRegistrationState>(
      builder: (context, state, child) {
        return ElevatedButton(
          onPressed: () {
            if (state.formState.currentState!.validate()) {
              state.insert();
            }
          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(
              MediaQuery.of(context).size.width / 1.26,
              MediaQuery.of(context).size.height / 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            backgroundColor: accentColor,
            foregroundColor: Colors.white,
          ),
          child: const Text('Register Associate'),
        );
      },
    );
  }
}

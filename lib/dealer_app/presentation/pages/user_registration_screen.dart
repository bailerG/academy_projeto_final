import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/user_registration_state.dart';
import '../utils/dropdown.dart';
import '../utils/header.dart';
import '../utils/large_button.dart';
import '../utils/text_descriptions.dart';
import '../utils/text_field.dart';
import '../utils/title.dart';

class UserRegisterScreen extends StatelessWidget {
  const UserRegisterScreen({super.key});

  static const routeName = '/registration';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const _UserRegistrationStructure(),
    );
  }
}

class _UserRegistrationStructure extends StatelessWidget {
  const _UserRegistrationStructure();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserRegistrationState(),
      child: Consumer<UserRegistrationState>(
        builder: (context, state, child) {
          return SingleChildScrollView(
            child: Form(
              key: state.formState,
              child: const Padding(
                padding: EdgeInsets.all(40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _NewHereTitle(),
                    AppHeader(header: 'Full Name'),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 8,
                        bottom: 8,
                      ),
                      child: _FullNameTextField(),
                    ),
                    AppHeader(header: 'Username'),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 8,
                        bottom: 8,
                      ),
                      child: _UsernameTextField(),
                    ),
                    AppHeader(header: 'Dealership'),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 8,
                      ),
                      child: _DealershipDropdown(),
                    ),
                    AppHeader(header: 'Role'),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 32,
                      ),
                      child: _RoleDropdown(),
                    ),
                    _RegisterButton(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _NewHereTitle extends StatelessWidget {
  const _NewHereTitle();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTitle(
            title: 'Have a new associate?',
          ),
          AppTextDescription(
            text: 'Please fill these fields',
          ),
        ],
      ),
    );
  }
}

class _FullNameTextField extends StatelessWidget {
  const _FullNameTextField();

  String? _validator(String? value) {
    if (value!.isEmpty) {
      return "Please share the associate's name";
    }
    if (value.length < 3) {
      return 'Name should be at least 3 letters long';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<UserRegistrationState>(context, listen: false);

    return AppTextField(
      controller: state.fullNameController,
      inputType: TextInputType.name,
      hint: "Associate's full name",
      validator: _validator,
    );
  }
}

class _UsernameTextField extends StatelessWidget {
  const _UsernameTextField();

  String? _validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please write a username';
    }
    if (value.length < 4) {
      return 'Username should be at least 4 letters long';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<UserRegistrationState>(context, listen: false);

    return AppTextField(
      controller: state.usernameController,
      inputType: TextInputType.text,
      hint: "Associate's username",
      validator: _validator,
    );
  }
}

class _DealershipDropdown extends StatelessWidget {
  const _DealershipDropdown();

  String? _validator(Object? value) {
    if (value == null) {
      return 'Please select a Dealership';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<UserRegistrationState>(context, listen: true);

    void onChanged(value) {
      state.setDealershipValue(value!);
    }

    return AppDropdown(
      list: state.dealershipList,
      onChanged: onChanged,
      validator: _validator,
    );
  }
}

class _RoleDropdown extends StatelessWidget {
  const _RoleDropdown();

  String? validator(Object? value) {
    if (value == null) {
      return 'Please select a Role';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<UserRegistrationState>(context, listen: true);

    void onChanged(value) {
      state.setRoleValue(value!);
    }

    return AppDropdown(
      list: state.roleList,
      onChanged: onChanged,
      validator: validator,
    );
  }
}

class _RegisterButton extends StatelessWidget {
  const _RegisterButton();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<UserRegistrationState>(context, listen: false);

    void onPressed() {
      if (state.formState.currentState!.validate()) {
        state.insert().whenComplete(
              () => Navigator.pop(context),
            );
      }
    }

    return AppLargeButton(
      onPressed: onPressed,
      text: 'Register Associate',
    );
  }
}

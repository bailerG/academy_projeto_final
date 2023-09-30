import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../entities/user.dart';
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
    final user = ModalRoute.of(context)!.settings.arguments as User?;

    return Scaffold(
      appBar: AppBar(),
      body: ChangeNotifierProvider(
        create: (context) => UserRegistrationState(user),
        child: Consumer<UserRegistrationState>(
          builder: (context, state, child) {
            return _UserRegistrationStructure(state);
          },
        ),
      ),
    );
  }
}

class _UserRegistrationStructure extends StatelessWidget {
  const _UserRegistrationStructure(this.state);

  final UserRegistrationState state;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: state.formState,
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _NewHereTitle(state),
              const AppHeader(header: 'Full Name'),
              Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                  bottom: 8,
                ),
                child: _FullNameTextField(state),
              ),
              const AppHeader(header: 'Username'),
              Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                  bottom: 8,
                ),
                child: _UsernameTextField(state),
              ),
              const AppHeader(header: 'Dealership'),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 8,
                ),
                child: _DealershipDropdown(state),
              ),
              const AppHeader(header: 'Role'),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 32,
                ),
                child: _RoleDropdown(state),
              ),
              _RegisterButton(state),
              Center(
                child: _DeactivateUser(state),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NewHereTitle extends StatelessWidget {
  const _NewHereTitle(this.state);

  final UserRegistrationState state;

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
  const _FullNameTextField(this.state);

  final UserRegistrationState state;

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
    return AppTextField(
      controller: state.fullNameController,
      inputType: TextInputType.name,
      hint: "Associate's full name",
      validator: _validator,
    );
  }
}

class _UsernameTextField extends StatelessWidget {
  const _UsernameTextField(this.state);

  final UserRegistrationState state;

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
    return AppTextField(
      controller: state.usernameController,
      inputType: TextInputType.text,
      hint: "Associate's username",
      validator: _validator,
    );
  }
}

class _DealershipDropdown extends StatelessWidget {
  const _DealershipDropdown(this.state);

  final UserRegistrationState state;

  String? _validator(Object? value) {
    if (value == null) {
      return 'Please select a Dealership';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
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
  const _RoleDropdown(this.state);

  final UserRegistrationState state;

  String? validator(Object? value) {
    if (value == null) {
      return 'Please select a Role';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
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
  const _RegisterButton(this.state);

  final UserRegistrationState state;

  @override
  Widget build(BuildContext context) {
    Future<void> onPressed() async {
      if (!state.formState.currentState!.validate()) {
        return;
      }
      if (state.editing) {
        await state.update();
      } else {
        await state.insert();
      }
      if (context.mounted) {
        Navigator.pop(context);
      }
    }

    return AppLargeButton(
      onPressed: onPressed,
      text: state.editing ? "Update associate's info" : 'Register Associate',
    );
  }
}

class _DeactivateUser extends StatelessWidget {
  const _DeactivateUser(this.state);

  final UserRegistrationState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 24,
      ),
      child: AppLargeButton(
        onPressed: () async {
          await state.deactivateUser();
          if (context.mounted) {
            Navigator.pop(context);
          }
        },
        text: 'Deactivate User',
      ),
    );
  }
}

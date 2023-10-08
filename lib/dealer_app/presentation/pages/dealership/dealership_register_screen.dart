import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../entities/dealership.dart';
import '../../state/dealership/dealership_register_state.dart';
import '../../utils/alert_dialog.dart';
import '../../utils/dropdown.dart';
import '../../utils/header.dart';
import '../../utils/large_button.dart';
import '../../utils/text_descriptions.dart';
import '../../utils/text_field.dart';
import '../../utils/title.dart';

class DealershipRegisterScreen extends StatelessWidget {
  const DealershipRegisterScreen({super.key});

  static const routeName = '/dealership_register';

  @override
  Widget build(BuildContext context) {
    final editingDealership =
        ModalRoute.of(context)!.settings.arguments as Dealership?;

    return ChangeNotifierProvider(
      create: (context) => DealershipRegisterState(editingDealership),
      child: Consumer<DealershipRegisterState>(
        builder: (context, state, child) {
          return Scaffold(
            appBar: AppBar(),
            body: _DealershipRegisterStructure(state),
          );
        },
      ),
    );
  }
}

class _DealershipRegisterStructure extends StatelessWidget {
  const _DealershipRegisterStructure(this.state);

  final DealershipRegisterState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 40,
        right: 40,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: state.formState,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _NewDealershipTitle(state),
              const Padding(
                padding: EdgeInsets.only(
                  top: 32,
                ),
                child: AppHeader(
                  header: 'Name',
                  padLeft: 8,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  bottom: 8,
                ),
                child: _NameTextField(state),
              ),
              const AppHeader(
                header: 'CNPJ',
                padLeft: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  bottom: 8,
                ),
                child: _CNPJTextField(state),
              ),
              const AppHeader(
                header: 'Password',
                padLeft: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  bottom: 8,
                ),
                child: _PasswordTextField(state),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                  bottom: 8,
                ),
                child: _GeneratePasswordButton(state),
              ),
              const AppHeader(
                header: 'Autonomy Level',
                padLeft: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _AutonomyLevelDropdown(state),
              ),
              _RegisterButton(state),
              !state.editing ? Container() : _DeactivateButton(state),
            ],
          ),
        ),
      ),
    );
  }
}

class _NewDealershipTitle extends StatelessWidget {
  const _NewDealershipTitle(this.state);

  final DealershipRegisterState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTitle(
          title: state.editing ? 'Edit Existing Dealership' : 'New Dealership?',
        ),
        const AppTextDescription(
          text: 'Fill the fields below:',
        ),
      ],
    );
  }
}

class _NameTextField extends StatelessWidget {
  const _NameTextField(this.state);

  final DealershipRegisterState state;

  String? validator(String? value) {
    if (value == null) {
      return 'Please type a name for the dealership';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      hint: 'Dealership name',
      controller: state.nameController,
    );
  }
}

class _CNPJTextField extends StatelessWidget {
  const _CNPJTextField(this.state);

  final DealershipRegisterState state;

  String? validator(String? value) {
    if (value == null) {
      return 'Please type a CNPJ';
    }
    if (value.length > 14) {
      return 'CNPJ can only be 14 digits';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      hint: 'Dealership CNPJ',
      controller: state.cnpjController,
      validator: validator,
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  const _PasswordTextField(this.state);

  final DealershipRegisterState state;

  String? validator(String? value) {
    if (value == null) {
      return 'Please generate a password';
    }
    if (value.length < 5) {
      return 'Password should be at least 5 characters long';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: state.passwordController,
      validator: validator,
    );
  }
}

class _GeneratePasswordButton extends StatelessWidget {
  const _GeneratePasswordButton(this.state);

  final DealershipRegisterState state;

  @override
  Widget build(BuildContext context) {
    return AppLargeButton(
      onPressed: state.generatePassword,
      text: state.editing ? 'Generate New Password' : 'Generate Password',
    );
  }
}

class _AutonomyLevelDropdown extends StatelessWidget {
  const _AutonomyLevelDropdown(this.state);

  final DealershipRegisterState state;

  String? validator(Object? value) {
    if (value == null) {
      return 'Please select an Autonomy Level';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    void onChanged(value) {
      state.setAutonomyLevel(value);
    }

    return AppDropdown(
      list: state.autonomyList,
      onChanged: onChanged,
      validator: validator,
    );
  }
}

class _RegisterButton extends StatelessWidget {
  const _RegisterButton(this.state);

  final DealershipRegisterState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 32,
      ),
      child: AppLargeButton(
        onPressed: () async {
          if (!state.formState.currentState!.validate()) {
            return;
          }
          if (!state.editing) {
            await state.insert();
          } else {
            await state.update();
          }
          if (context.mounted) {
            Navigator.pop(context);
          }
        },
        text: state.editing ? 'Edit' : 'Register',
      ),
    );
  }
}

class _DeactivateButton extends StatelessWidget {
  const _DeactivateButton(this.state);

  final DealershipRegisterState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32, bottom: 32),
      child: AppLargeButton(
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context) {
              return AppAlertDialog(
                title: 'Are you sure?',
                message: 'Do you really want to deactivate this dealership?',
                buttons: [
                  TextButton(
                    onPressed: () async {
                      await state.deactivateDealership();
                      if (context.mounted) {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Yes'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                ],
              );
            },
          );
        },
        text: 'Deactivate Dealership',
      ),
    );
  }
}

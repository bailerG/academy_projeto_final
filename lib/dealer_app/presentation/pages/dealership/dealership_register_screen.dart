import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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

/// References the dealership registration page of the app.
///
/// It allows admins to create an instance of [Dealership] and
/// save it on database. Admin needs to provide all
/// properties inside the respective fields.
///
/// It is also used when an instance of dealership needs to be edited,
/// its parameters are filled in their respective fields
/// and admin can change them.
class DealershipRegisterScreen extends StatelessWidget {
  /// Constructs an instance of [DealershipRegisterScreen].
  const DealershipRegisterScreen({super.key});

  /// Name of route leading to this page.
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
    final locale = AppLocalizations.of(context)!;

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
              Padding(
                padding: const EdgeInsets.only(
                  top: 32,
                ),
                child: AppHeader(
                  header: locale.dealershipNameHeader,
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
              AppHeader(
                header: locale.dealershipPasswordHeader,
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
              AppHeader(
                header: locale.dealershipAutonomyHeader,
                padLeft: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _AutonomyLevelDropdown(state),
              ),
              _RegisterButton(state),
              if (state.editing) _DeactivateButton(state),
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
    final locale = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTitle(
          title: state.editing
              ? locale.editDealershipTitle
              : locale.dealershipTitle,
        ),
        AppTextDescription(
          text: locale.dealershipSubtitle,
        ),
      ],
    );
  }
}

class _NameTextField extends StatelessWidget {
  const _NameTextField(this.state);

  final DealershipRegisterState state;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    String? validator(String? value) {
      if (value == null || value.isEmpty) {
        return locale.dealershipNameEmpty;
      }
      return null;
    }

    return AppTextField(
      hint: locale.dealershipNameHint,
      controller: state.nameController,
      validator: validator,
    );
  }
}

class _CNPJTextField extends StatelessWidget {
  const _CNPJTextField(this.state);

  final DealershipRegisterState state;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    String? validator(String? value) {
      if (value == null || value.isEmpty) {
        return locale.dealershipCNPJEmpty;
      }
      if (value.length > 14) {
        return locale.dealershipCNPJLength;
      }
      return null;
    }

    return AppTextField(
      hint: locale.dealershipCNPJHint,
      controller: state.cnpjController,
      validator: validator,
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  const _PasswordTextField(this.state);

  final DealershipRegisterState state;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    String? validator(String? value) {
      if (value == null) {
        return locale.dealershipPasswordEmpty;
      }
      if (value.length < 5) {
        return locale.dealershipPasswordShort;
      }
      return null;
    }

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
    final locale = AppLocalizations.of(context)!;

    return AppLargeButton(
      onPressed: state.generatePassword,
      text:
          state.editing ? locale.generateNewPassword : locale.generatePassword,
    );
  }
}

class _AutonomyLevelDropdown extends StatelessWidget {
  const _AutonomyLevelDropdown(this.state);

  final DealershipRegisterState state;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    String? validator(Object? value) {
      if (value == null) {
        return locale.dealershipAutonomyEmpty;
      }
      return null;
    }

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
    final locale = AppLocalizations.of(context)!;

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
        text: state.editing ? locale.dealershipEdit : locale.dealershipRegister,
      ),
    );
  }
}

class _DeactivateButton extends StatelessWidget {
  const _DeactivateButton(this.state);

  final DealershipRegisterState state;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.only(top: 32, bottom: 32),
      child: AppLargeButton(
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context) {
              return AppAlertDialog(
                title: locale.alertTitle,
                message: locale.dealershipAlertMessage,
                buttons: [
                  TextButton(
                    onPressed: () async {
                      await state.deactivateDealership();
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                    child: Text(locale.yes),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(locale.cancel),
                  ),
                ],
              );
            },
          ).whenComplete(
            () => Navigator.pop(context),
          );
        },
        text: locale.dealershipDeactivate,
      ),
    );
  }
}

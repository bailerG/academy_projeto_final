import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../entities/user.dart';
import '../../state/user/user_registration_state.dart';
import '../../utils/alert_dialog.dart';
import '../../utils/dropdown.dart';
import '../../utils/header.dart';
import '../../utils/large_button.dart';
import '../../utils/text_descriptions.dart';
import '../../utils/text_field.dart';
import '../../utils/title.dart';

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
    final locale = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      child: Form(
        key: state.formState,
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _NewUserTitle(state),
              AppHeader(
                header: locale.userFullNameHeader,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                  bottom: 8,
                ),
                child: _FullNameTextField(state),
              ),
              AppHeader(
                header: locale.userUsernameHeader,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                  bottom: 8,
                ),
                child: _UsernameTextField(state),
              ),
              AppHeader(
                header: locale.userDealershipHeader,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 8,
                ),
                child: _DealershipDropdown(state),
              ),
              AppHeader(
                header: locale.userRoleHeader,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 32,
                ),
                child: _RoleDropdown(state),
              ),
              _RegisterButton(state),
              if (state.editing) _DeactivateUser(state),
            ],
          ),
        ),
      ),
    );
  }
}

class _NewUserTitle extends StatelessWidget {
  const _NewUserTitle(this.state);

  final UserRegistrationState state;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTitle(
            title: !state.editing
                ? locale.userRegisterTitle
                : locale.userEditTitle,
          ),
          AppTextDescription(
            text: locale.userRegisterSubtitle,
          ),
        ],
      ),
    );
  }
}

class _FullNameTextField extends StatelessWidget {
  const _FullNameTextField(this.state);

  final UserRegistrationState state;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    String? validator(String? value) {
      if (value!.isEmpty) {
        return locale.userFullNameEmpty;
      }
      if (value.length < 3) {
        return locale.userFullNameLength;
      }
      return null;
    }

    return AppTextField(
      controller: state.fullNameController,
      inputType: TextInputType.name,
      hint: locale.userFullNameHint,
      validator: validator,
    );
  }
}

class _UsernameTextField extends StatelessWidget {
  const _UsernameTextField(this.state);

  final UserRegistrationState state;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    String? validator(String? value) {
      if (value == null || value.isEmpty) {
        return locale.userUsernameEmpty;
      }
      if (value.length < 4) {
        return locale.userUsernameLength;
      }
      return null;
    }

    return AppTextField(
      controller: state.usernameController,
      inputType: TextInputType.text,
      hint: locale.userUsernameHint,
      validator: validator,
    );
  }
}

class _DealershipDropdown extends StatelessWidget {
  const _DealershipDropdown(this.state);

  final UserRegistrationState state;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    String? validator(Object? value) {
      if (value == null) {
        return locale.userDealershipEmpty;
      }
      return null;
    }

    void onChanged(value) {
      state.setDealershipValue(value!);
    }

    return AppDropdown(
      list: state.dealershipList,
      onChanged: onChanged,
      validator: validator,
    );
  }
}

class _RoleDropdown extends StatelessWidget {
  const _RoleDropdown(this.state);

  final UserRegistrationState state;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    String? validator(Object? value) {
      if (value == null) {
        return locale.userRoleEmpty;
      }
      return null;
    }

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
    final locale = AppLocalizations.of(context)!;

    Future<void> onPressed() async {
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
    }

    return AppLargeButton(
      onPressed: onPressed,
      text:
          !state.editing ? locale.userRegisterButton : locale.userUpdateButton,
    );
  }
}

class _DeactivateUser extends StatelessWidget {
  const _DeactivateUser(this.state);

  final UserRegistrationState state;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.only(
        top: 24,
      ),
      child: AppLargeButton(
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context) {
              return AppAlertDialog(
                title: locale.alertTitle,
                message: locale.userAlertMessage,
                buttons: [
                  TextButton(
                    onPressed: () async {
                      await state.deactivateUser();
                      if (context.mounted) {
                        Navigator.pop(context);
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
          );
        },
        text: locale.userDeactivate,
      ),
    );
  }
}

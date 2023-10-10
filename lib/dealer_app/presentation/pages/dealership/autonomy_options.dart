import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../entities/autonomy_level.dart';
import '../../state/dealership/autonomy_options_state.dart';
import '../../utils/close_button.dart';
import '../../utils/header.dart';
import '../../utils/large_button.dart';
import '../../utils/text_field.dart';
import '../../utils/title.dart';

class AutonomyOptionsScreen extends StatelessWidget {
  const AutonomyOptionsScreen({super.key});

  static const routeName = '/autonomy_options';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AutonomyOptionsState(),
      child: Consumer<AutonomyOptionsState>(
        builder: (context, state, child) {
          return Scaffold(
            appBar: AppBar(),
            body: _AutonomyOptionsStructure(state),
          );
        },
      ),
    );
  }
}

class _AutonomyOptionsStructure extends StatelessWidget {
  const _AutonomyOptionsStructure(this.state);

  final AutonomyOptionsState state;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.only(
        left: 32,
        right: 32,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppTitle(title: locale.autonomyListTitle),
            ListView.builder(
              padding: const EdgeInsets.only(
                top: 24,
                bottom: 56,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.autonomyList.length,
              itemBuilder: (context, index) {
                return _AutonomyListTile(
                  state.autonomyList[index],
                  state,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _AutonomyListTile extends StatelessWidget {
  const _AutonomyListTile(
    this.autonomyLevel,
    this.state,
  );

  final AutonomyLevel autonomyLevel;
  final AutonomyOptionsState state;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return InkWell(
      onTap: () async {
        state.setControllerValues(autonomyLevel);
        await showDialog(
          context: context,
          builder: (context) {
            return _EditPopUp(
              state,
              autonomyLevel,
              locale,
            );
          },
        );
      },
      child: ListTile(
        title: Text(autonomyLevel.name),
        subtitle: AppHeader(
          header: locale.autonomyDealershipPercentage(
            autonomyLevel.dealershipPercentage * 100,
          ),
          fontSize: 1.2,
        ),
      ),
    );
  }
}

class _EditPopUp extends StatelessWidget {
  const _EditPopUp(
    this.state,
    this.autonomyLevel,
    this.locale,
  );

  final AutonomyOptionsState state;
  final AutonomyLevel autonomyLevel;
  final AppLocalizations locale;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppTitle(
            title: locale.autonomyEdit,
            fontSize: 1,
          ),
          const AppCloseeButton(),
        ],
      ),
      content: Form(
        key: state.formState,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppHeader(
              header: locale.dealershipPercentageHeader,
              padLeft: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 8,
              ),
              child: AppTextField(
                controller: state.dealershipController,
                autoValidate: AutovalidateMode.onUserInteraction,
                validator: state.fieldValidator,
                onChanged: (_) {
                  var newValue = 99 -
                      (double.tryParse(state.dealershipController.text) ?? 0)
                          .abs();
                  state.headquartersController.text = newValue.toString();
                },
              ),
            ),
            AppHeader(
              header: locale.headquartersPercentageHeader,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 8,
              ),
              child: AppTextField(
                controller: state.headquartersController,
                readOnly: true,
              ),
            ),
          ],
        ),
      ),
      actions: [
        AppLargeButton(
          onPressed: () async {
            if (!state.formState.currentState!.validate()) {
              return;
            } else {
              await state.updatePercentage(autonomyLevel);
              if (context.mounted) {
                Navigator.pop(context);
                Navigator.pop(context);
              }
            }
          },
          text: locale.saveButton,
        ),
      ],
    );
  }
}

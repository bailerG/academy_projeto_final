import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../state/main_state.dart';
import '../utils/header.dart';
import '../utils/title.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<MainState>(context);
    final locale = AppLocalizations.of(context)!;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 32.0,
            right: 32.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _SettingsTitle(),
              AppHeader(header: locale.themeHeader),
              _ThemeDropdown(state),
              AppHeader(header: locale.languageHeader),
              const _LanguageDropdown(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsTitle extends StatelessWidget {
  const _SettingsTitle();

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 56,
        top: 32,
      ),
      child: AppTitle(
        title: locale.settingsTitle,
      ),
    );
  }
}

class _ThemeDropdown extends StatelessWidget {
  const _ThemeDropdown(
    this.state,
  );

  final MainState state;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return DropdownButton(
      padding: const EdgeInsets.only(
        bottom: 32,
      ),
      icon: state.lightTheme
          ? const Icon(Icons.light_mode_outlined)
          : const Icon(Icons.dark_mode),
      borderRadius: BorderRadius.circular(20),
      isExpanded: true,
      value: state.lightTheme,
      items: [
        DropdownMenuItem(
          value: true,
          child: Text(locale.lightTheme),
        ),
        DropdownMenuItem(
          value: false,
          child: Text(locale.darkTheme),
        ),
      ],
      onChanged: (theme) async {
        await state.toggleTheme(
          value: theme!,
        );
      },
    );
  }
}

class _LanguageDropdown extends StatelessWidget {
  const _LanguageDropdown();

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      borderRadius: BorderRadius.circular(20),
      isExpanded: true,
      items: const [
        DropdownMenuItem(
          value: 'pt',
          child: Text('Português'),
        ),
        DropdownMenuItem(
          value: 'en',
          child: Text('English'),
        ),
      ],
      //TODO: IMPLEMENT LANGUAGE SELECTOR
      onChanged: (value) {},
    );
  }
}

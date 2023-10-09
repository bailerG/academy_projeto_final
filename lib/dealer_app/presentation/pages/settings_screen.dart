import 'package:flutter/material.dart';
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
              const AppHeader(header: 'Theme:'),
              _ThemeDropdown(state),
              const AppHeader(header: 'Language:'),
              _LanguageDropdown(),
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
    return const Padding(
      padding: EdgeInsets.only(
        bottom: 56,
        top: 32,
      ),
      child: AppTitle(
        title: 'Here you can change your settings',
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
      items: const [
        DropdownMenuItem(
          value: true,
          child: Text('Light'),
        ),
        DropdownMenuItem(
          value: false,
          child: Text('Dark'),
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
          child: Text('Portugues'),
        ),
        DropdownMenuItem(
          value: 'eng',
          child: Text('English'),
        ),
      ],
      onChanged: (value) {},
    );
  }
}

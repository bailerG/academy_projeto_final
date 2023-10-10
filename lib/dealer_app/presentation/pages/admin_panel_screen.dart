import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../utils/gridview_button.dart';
import 'dealership/autonomy_options.dart';
import 'dealership/dealership_list_screen.dart';
import 'dealership/dealership_register_screen.dart';
import 'user/user_list_screen.dart';
import 'user/user_register_screen.dart';

class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});

  static const routeName = '/admin_panel';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _PanelGrid(),
    );
  }
}

class _PanelGrid extends StatelessWidget {
  const _PanelGrid();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(
          16.0,
        ),
        children: const [
          _RegisterDealership(),
          _EditDealerships(),
          _RegisterUser(),
          _EditUsers(),
          _EditPercentages(),
        ],
      ),
    );
  }
}

class _EditUsers extends StatelessWidget {
  const _EditUsers();

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return InkWell(
      onTap: () async {
        await Navigator.of(context).pushNamed(UserListScreen.routeName);
      },
      child: AppGridViewButton(
        label: locale.editUser,
        icon: Icons.edit_note,
      ),
    );
  }
}

class _RegisterUser extends StatelessWidget {
  const _RegisterUser();

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () async {
        await Navigator.of(context).pushNamed(UserRegisterScreen.routeName);
      },
      child: AppGridViewButton(
        label: locale.registerUser,
        icon: Icons.person_add_alt_outlined,
      ),
    );
  }
}

class _EditDealerships extends StatelessWidget {
  const _EditDealerships();

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () async {
        await Navigator.of(context).pushNamed(
          DealershipListScreen.routeName,
        );
      },
      child: AppGridViewButton(
        label: locale.editDealership,
        icon: Icons.edit,
      ),
    );
  }
}

class _RegisterDealership extends StatelessWidget {
  const _RegisterDealership();

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () async {
        await Navigator.of(context).pushNamed(
          DealershipRegisterScreen.routeName,
        );
      },
      child: AppGridViewButton(
        label: locale.registerDealership,
        icon: Icons.house_siding,
      ),
    );
  }
}

class _EditPercentages extends StatelessWidget {
  const _EditPercentages();

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () async {
        await Navigator.of(context).pushNamed(
          AutonomyOptionsScreen.routeName,
        );
      },
      child: AppGridViewButton(
        label: locale.editPercentages,
        icon: Icons.percent,
      ),
    );
  }
}

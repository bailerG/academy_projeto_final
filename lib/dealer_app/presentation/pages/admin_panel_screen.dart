import 'package:flutter/material.dart';

import '../utils/gridview_button.dart';
import 'user_list_screen.dart';
import 'user_registration_screen.dart';

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
        ],
      ),
    );
  }
}

class _EditUsers extends StatelessWidget {
  const _EditUsers();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(UserListScreen.routeName);
      },
      child: const AppGridViewButton(
        label: 'View and\nEdit User',
        icon: Icons.edit_note,
      ),
    );
  }
}

class _RegisterUser extends StatelessWidget {
  const _RegisterUser();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        Navigator.of(context).pushNamed(UserRegisterScreen.routeName);
      },
      child: const AppGridViewButton(
        label: 'Register a\nNew Associate',
        icon: Icons.person_add_alt_outlined,
      ),
    );
  }
}

class _EditDealerships extends StatelessWidget {
  const _EditDealerships();

  @override
  Widget build(BuildContext context) {
    return const AppGridViewButton(
      label: 'View and Edit Dealerships',
      icon: Icons.edit,
    );
  }
}

class _RegisterDealership extends StatelessWidget {
  const _RegisterDealership();

  @override
  Widget build(BuildContext context) {
    return const AppGridViewButton(
      label: 'Register a New Dealership',
      icon: Icons.house_siding,
    );
  }
}

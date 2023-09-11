import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../entities/user.dart';
import '../../entities/vehicle.dart';
import '../state/home_screen_state.dart';
import '../utils/app_bar.dart';
import '../utils/header.dart';
import '../utils/navigation_bar.dart';
import '../utils/title.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/home_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      body: const _HomeScreenStructure(),
      bottomNavigationBar: const AppNavigationBar(),
    );
  }
}

class _HomeScreenStructure extends StatelessWidget {
  const _HomeScreenStructure();

  @override
  Widget build(BuildContext context) {
    final loggedUser = ModalRoute.of(context)!.settings.arguments;
    return ChangeNotifierProvider(
      create: (context) => HomeScreenState(),
      child: Consumer<HomeScreenState>(
        builder: (context, state, child) {
          state.setLoggedUser(loggedUser as User);
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const _WelcomeTitle(),
                  state.vehicleList.isEmpty
                      ? const AppHeader(header: 'There is no vehicle in stock')
                      : const _CarInventoryListView(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _WelcomeTitle extends StatelessWidget {
  const _WelcomeTitle();
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<HomeScreenState>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 160),
      child: AppTitle(
        title: 'Welcome\n${state.loggedUser.fullName}!',
        fontSize: 2.0,
      ),
    );
  }
}

class _CarInventoryListView extends StatelessWidget {
  const _CarInventoryListView();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<HomeScreenState>(context, listen: true);

    return ListView.builder(
      itemCount: state.vehicleList.length,
      itemBuilder: (context, index) {
        return _CarListTile(
          vehicle: state.vehicleList[index],
        );
      },
    );
  }
}

class _CarListTile extends StatelessWidget {
  const _CarListTile({required this.vehicle});
  final Vehicle vehicle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${vehicle.modelYear} ${vehicle.brand} ${vehicle.model}'),
      leading: Image.asset(vehicle.photo),
      trailing: Text('R\$${vehicle.pricePaid}'),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../entities/vehicle.dart';
import '../state/home_screen_state.dart';
import '../state/main_state.dart';
import '../utils/header.dart';
import '../utils/title.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/home_screen';

  @override
  Widget build(BuildContext context) {
    final mainState = Provider.of<MainState>(context, listen: true);
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => HomeScreenState(mainState.loggedUser!),
        child: const _HomeScreenStructure(),
      ),
    );
  }
}

class _HomeScreenStructure extends StatelessWidget {
  const _HomeScreenStructure();

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenState>(
      builder: (context, state, child) {
        return SingleChildScrollView(
          physics: state.vehicleList.isEmpty
              ? const NeverScrollableScrollPhysics()
              : const AlwaysScrollableScrollPhysics(),
          child: const Column(
            children: [
              Padding(
                padding: EdgeInsets.all(40.0),
                child: _WelcomeTitle(),
              ),
              _ListViewContainer(),
            ],
          ),
        );
      },
    );
  }
}

class _WelcomeTitle extends StatelessWidget {
  const _WelcomeTitle();
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<HomeScreenState>(context, listen: true);

    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 160),
      child: AppTitle(
        title: 'Welcome\n${state.loggedUser.fullName}!',
        fontSize: 2.0,
      ),
    );
  }
}

class _ListViewContainer extends StatelessWidget {
  const _ListViewContainer();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<HomeScreenState>(context, listen: true);
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(50),
          topLeft: Radius.circular(50),
        ),
        color: Theme.of(context).hoverColor,
      ),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(36.0),
        child: state.vehicleList.isEmpty
            ? const AppHeader(header: 'There is no vehicle in stock')
            : const _CarInventoryListView(),
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

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../entities/vehicle.dart';
import '../state/home_screen_state.dart';
import '../state/main_state.dart';
import '../utils/dropdown.dart';
import '../utils/header.dart';
import '../utils/title.dart';
import 'vehicle_options_screen.dart';

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
        if (state.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return SingleChildScrollView(
          physics: state.vehicleList.isEmpty
              ? const NeverScrollableScrollPhysics()
              : const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(40.0),
                child: _WelcomeTitle(),
              ),
              if (state.loggedUser.roleId == 1) _DealershipDropdown(state),
              const _ListViewContainer(),
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
      padding: const EdgeInsets.only(top: 16, bottom: 120),
      child: AppTitle(
        title: 'Welcome\n${state.loggedUser.fullName}!',
      ),
    );
  }
}

class _DealershipDropdown extends StatelessWidget {
  const _DealershipDropdown(this.state);

  final HomeScreenState state;

  @override
  Widget build(BuildContext context) {
    void onChanged(value) {
      state.setDealership(value);
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: AppDropdown(
        list: state.dealershipList,
        onChanged: onChanged,
      ),
    );
  }
}

class _ListViewContainer extends StatelessWidget {
  const _ListViewContainer();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<HomeScreenState>(context, listen: true);
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.4,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(50),
            topLeft: Radius.circular(50),
          ),
          color: Theme.of(context).hoverColor,
        ),
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: state.vehicleList.isEmpty
              ? const _NoVehicleRegistered()
              : const _CarInventoryListView(),
        ),
      ),
    );
  }
}

class _NoVehicleRegistered extends StatelessWidget {
  const _NoVehicleRegistered();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(32.0),
      child: AppHeader(header: 'There is no vehicle in stock'),
    );
  }
}

class _CarInventoryListView extends StatelessWidget {
  const _CarInventoryListView();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<HomeScreenState>(context);

    return ListView.builder(
      // physics: const NeverScrollableScrollPhysics(),
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
    final state = Provider.of<HomeScreenState>(context);

    final vehiclePhotos = vehicle.photos!.split('|');
    final numberFormatter = NumberFormat('###,###,###.00');

    return InkWell(
      onTap: () async {
        await Navigator.of(context).pushNamed(
          VehicleOptionsScreen.routeName,
          arguments: vehicle,
        );
      },
      child: ListTile(
        title: Text(
          '${vehicle.modelYear}'
          ' ${vehicle.brand.toUpperCase()}'
          ' ${vehicle.model.toUpperCase()}',
        ),
        leading: FutureBuilder<File>(
          // ignore: discarded_futures
          future: state.loadVehicleImage(vehiclePhotos.first),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Image.file(
                snapshot.data!,
                width: MediaQuery.of(context).size.width / 5,
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
        subtitle: Text(
          'R\$${numberFormatter.format(vehicle.pricePaid)}',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

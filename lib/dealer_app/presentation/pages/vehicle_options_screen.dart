import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../entities/vehicle.dart';
import '../state/vehicle_options.state.dart';
import '../utils/alert_dialog.dart';
import '../utils/atributes_table.dart';
import '../utils/header.dart';
import '../utils/large_button.dart';
import '../utils/small_button.dart';
import '../utils/text_descriptions.dart';
import '../utils/title.dart';
import 'vehicle_register_screen.dart';

class VehicleOptionsScreen extends StatelessWidget {
  const VehicleOptionsScreen({super.key});

  static const routeName = '/vehicle_options';

  @override
  Widget build(BuildContext context) {
    final vehicle = ModalRoute.of(context)!.settings.arguments as Vehicle;
    return ChangeNotifierProvider(
      create: (context) => VehicleOptionsState(vehicle.id!),
      child: Consumer<VehicleOptionsState>(builder: (context, state, child) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: state.loading == true
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : const _OptionsStructure(),
        );
      }),
    );
  }
}

class _OptionsStructure extends StatelessWidget {
  const _OptionsStructure();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<VehicleOptionsState>(context, listen: true);
    final vehicle = state.vehicle;
    return Column(
      children: [
        const _CarouselWidget(),
        Padding(
          padding: const EdgeInsets.only(
            left: 40.0,
            right: 40.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 24,
                ),
                child: _VehicleBrandAndYear(vehicle),
              ),
              _VehicleModel(vehicle),
              const Padding(
                padding: EdgeInsets.only(top: 32),
                child: _DetailsHeader(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: _CarDetails(vehicle),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: _ActionButtons(vehicle),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: _SellButton(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CarouselWidget extends StatelessWidget {
  const _CarouselWidget();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<VehicleOptionsState>(context, listen: true);
    final vehiclePhotos = state.vehicle.photos!.split('|');

    return CarouselSlider.builder(
      itemCount: vehiclePhotos.length,
      itemBuilder: (
        context,
        itemIndex,
        pageViewIndex,
      ) {
        return FutureBuilder<File>(
          future: state.loadVehicleImage(
            vehiclePhotos[itemIndex],
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Image.file(snapshot.data!);
            } else {
              return const CircularProgressIndicator();
            }
          },
        );
      },
      options: CarouselOptions(
        aspectRatio: 16 / 12,
        enableInfiniteScroll: false,
        viewportFraction: 2.0,
      ),
    );
  }
}

class _VehicleBrandAndYear extends StatelessWidget {
  const _VehicleBrandAndYear(this.vehicle);

  final Vehicle vehicle;

  @override
  Widget build(BuildContext context) {
    return AppTitle(
      fontSize: 1.5,
      title: '${vehicle.modelYear} ${vehicle.brand}'.toUpperCase(),
    );
  }
}

class _VehicleModel extends StatelessWidget {
  const _VehicleModel(this.vehicle);

  final Vehicle vehicle;

  @override
  Widget build(BuildContext context) {
    return AppTextDescription(
      text: vehicle.model.toUpperCase(),
    );
  }
}

class _DetailsHeader extends StatelessWidget {
  const _DetailsHeader();

  @override
  Widget build(BuildContext context) {
    return const AppHeader(
      header: 'CAR DETAILS',
      fontSize: 1.2,
    );
  }
}

class _CarDetails extends StatelessWidget {
  const _CarDetails(this.vehicle);

  final Vehicle vehicle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 8,
          ),
          child: AtributesTable(
            label: 'Year built',
            value: vehicle.builtYear.toString(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: 8,
          ),
          child: AtributesTable(
            label: 'Model year',
            value: vehicle.modelYear.toString(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: 8,
          ),
          child: AtributesTable(
            label: 'Plate',
            value: vehicle.plate,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: 8,
          ),
          child: AtributesTable(
            label: 'Purchased',
            value: DateFormat('d/M/y').format(
              vehicle.purchasedWhen,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: 8,
          ),
          child: AtributesTable(
            label: 'Price paid',
            value: NumberFormat('###,###,###.00').format(
              vehicle.pricePaid,
            ),
          ),
        ),
      ],
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons(this.vehicle);

  final Vehicle vehicle;

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<VehicleOptionsState>(context, listen: true);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppSmallButton(
          text: '     Edit     ',
          onPressed: () {
            Navigator.of(context)
                .pushNamed(
                  VehicleRegisterScreen.routeName,
                  arguments: vehicle,
                )
                .whenComplete(
                  () => state.loadData(state.vehicle.id!),
                );
          },
        ),
        AppSmallButton(
          text: '   Delete    ',
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AppAlertDialog(
                  title: 'Are you sure?',
                  message: 'Do you really want to delete this car?',
                  buttons: [
                    TextButton(
                      onPressed: () {
                        state.deleteVehicle(vehicle);
                        Navigator.of(context).pop(true);
                        Navigator.of(context).pop(true);
                      },
                      child: const Text('Yes'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    )
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class _SellButton extends StatelessWidget {
  const _SellButton();

  @override
  Widget build(BuildContext context) {
    return AppLargeButton(
      onPressed: () {},
      text: 'Sell',
    );
  }
}

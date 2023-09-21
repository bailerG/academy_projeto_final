import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../entities/vehicle.dart';
import '../state/vehicle_options.state.dart';
import '../utils/atributes_table.dart';
import '../utils/header.dart';
import '../utils/large_button.dart';
import '../utils/small_button.dart';
import '../utils/text_descriptions.dart';
import '../utils/title.dart';

class VehicleOptionsScreen extends StatelessWidget {
  const VehicleOptionsScreen({super.key});

  static const routeName = '/vehicle_options';

  @override
  Widget build(BuildContext context) {
    final vehicle = ModalRoute.of(context)!.settings.arguments as Vehicle;
    return ChangeNotifierProvider(
      create: (context) => VehicleOptionsState(vehicle: vehicle),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: _OptionsStructure(vehicle: vehicle),
      ),
    );
  }
}

class _OptionsStructure extends StatelessWidget {
  const _OptionsStructure({required this.vehicle});

  final Vehicle vehicle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _CarouselWidget(vehicle),
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
              const Padding(
                padding: EdgeInsets.only(top: 32),
                child: _ActionButtons(),
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
  const _CarouselWidget(this.vehicle);

  final Vehicle vehicle;

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<VehicleOptionsState>(context, listen: true);
    final vehiclePhotos = vehicle.photos!.split('|');

    return CarouselSlider.builder(
      itemCount: vehiclePhotos.length,
      itemBuilder: (
        context,
        itemIndex,
        pageViewIndex,
      ) {
        return FutureBuilder<File>(
          future: state.loadVehicleImage(vehiclePhotos[itemIndex]),
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
        height: MediaQuery.of(context).size.height / 3,
        aspectRatio: 16 / 9,
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
  const _ActionButtons();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppSmallButton(
          onPressed: () {},
          text: '     Edit     ',
        ),
        AppSmallButton(
          onPressed: () {},
          text: '   Delete    ',
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

import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../entities/vehicle.dart';
import '../../state/main_state.dart';
import '../../state/sale/sale_register_state.dart';
import '../../state/vehicle/vehicle_options.state.dart';
import '../../utils/alert_dialog.dart';
import '../../utils/atributes_table.dart';
import '../../utils/close_button.dart';
import '../../utils/header.dart';
import '../../utils/large_button.dart';
import '../../utils/small_button.dart';
import '../../utils/text_descriptions.dart';
import '../../utils/title.dart';
import '../sale/sales_form_popup.dart';
import 'vehicle_register_screen.dart';

/// References to vehicle option page of the app.
///
/// It shows all details from a given [Vehicle] that
/// are available to users. Also has options to edit,
/// delete or sell the vehicle.
class VehicleOptionsScreen extends StatelessWidget {
  /// Constructs an instance of [VehicleOptionsScreen].
  const VehicleOptionsScreen({super.key});

  /// Name of route leading to this page.
  static const routeName = '/vehicle_options';

  @override
  Widget build(BuildContext context) {
    final vehicle = ModalRoute.of(context)!.settings.arguments as Vehicle;
    return ChangeNotifierProvider(
      create: (context) => VehicleOptionsState(vehicle.id!),
      child: Consumer<VehicleOptionsState>(
        builder: (context, state, child) {
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
        },
      ),
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
          // ignore: discarded_futures
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
    final locale = AppLocalizations.of(context)!;

    return AppHeader(
      header: locale.carDetails,
      fontSize: 1.2,
    );
  }
}

class _CarDetails extends StatelessWidget {
  const _CarDetails(this.vehicle);

  final Vehicle vehicle;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 8,
          ),
          child: AtributesTable(
            label: locale.builtYearHeader,
            value: vehicle.builtYear.toString(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: 8,
          ),
          child: AtributesTable(
            label: locale.modelYearHeader,
            value: vehicle.modelYear.toString(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: 8,
          ),
          child: AtributesTable(
            label: locale.plateHeader,
            value: vehicle.plate,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: 8,
          ),
          child: AtributesTable(
            label: locale.datePurchaseHeader,
            value: DateFormat('d/M/y').format(
              vehicle.purchasedDate,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: 8,
          ),
          child: AtributesTable(
            label: locale.priceHeader,
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
    final locale = AppLocalizations.of(context)!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppSmallButton(
          text: locale.editCar,
          padding: 50,
          onPressed: () async {
            await Navigator.of(context)
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
          text: locale.deleteCar,
          padding: 40,
          onPressed: () async {
            await showDialog(
              context: context,
              builder: (context) {
                return AppAlertDialog(
                  title: locale.alertTitle,
                  message: locale.carAlertMessage,
                  buttons: [
                    TextButton(
                      onPressed: () {
                        state.deleteVehicle(vehicle);
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      child: Text(locale.yes),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(locale.cancel),
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
    final mainState = Provider.of<MainState>(context, listen: false);
    final vehicleState = Provider.of<VehicleOptionsState>(
      context,
      listen: false,
    );
    final locale = AppLocalizations.of(context)!;

    return AppLargeButton(
      text: locale.sellButton,
      onPressed: () async {
        await showDialog(
          context: context,
          builder: (context) {
            return ChangeNotifierProvider(
              create: (context) => SaleRegisterState(
                mainState.loggedUser!,
                vehicleState.vehicle,
              ),
              child: Consumer<SaleRegisterState>(
                builder: (context, state, child) {
                  return _SalePopUp(locale);
                },
              ),
            );
          },
        );
      },
    );
  }
}

class _SalePopUp extends StatelessWidget {
  const _SalePopUp(this.locale);

  final AppLocalizations locale;

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<SaleRegisterState>(context, listen: true);

    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppHeader(
            header: locale.sellCarTitle,
            fontSize: 1,
            padLeft: 8.0,
          ),
          const AppCloseeButton(),
        ],
      ),
      content: SaleForm(
        state: state,
        locale: locale,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: AppLargeButton(
            onPressed: () {
              if (!state.formState.currentState!.validate()) {
                return;
              } else {
                state.registerSale();
                Navigator.of(context)
                  ..pop()
                  ..pop();
              }
            },
            text: locale.soldCar,
          ),
        ),
      ],
    );
  }
}

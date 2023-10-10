import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../entities/vehicle.dart';
import '../../state/main_state.dart';
import '../../state/vehicle/vehicle_register_state.dart';
import '../../utils/autocomplete_textfield.dart';
import '../../utils/close_button.dart';
import '../../utils/header.dart';
import '../../utils/large_button.dart';
import '../../utils/small_button.dart';
import '../../utils/text_descriptions.dart';
import '../../utils/text_field.dart';
import '../../utils/title.dart';

class VehicleRegisterScreen extends StatelessWidget {
  const VehicleRegisterScreen({
    super.key,
  });

  static const routeName = '/vehicle_registration';

  @override
  Widget build(BuildContext context) {
    final mainState = Provider.of<MainState>(context, listen: true);

    final vehicle = ModalRoute.of(context)!.settings.arguments as Vehicle?;

    return ChangeNotifierProvider(
      create: (context) => VehicleRegisterState(
        user: mainState.loggedUser!,
        vehicle: vehicle,
      ),
      child: Consumer<VehicleRegisterState>(
        builder: (context, state, child) {
          return Scaffold(
            body: const _VehicleRegisterStructure(),
            appBar: state.editing
                ? AppBar(
                    leading: const AppCloseeButton(),
                  )
                : null,
          );
        },
      ),
    );
  }
}

class _VehicleRegisterStructure extends StatelessWidget {
  const _VehicleRegisterStructure();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<VehicleRegisterState>(context, listen: true);
    final locale = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      child: Form(
          key: state.formState,
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!state.editing) const _NewCarTitle(),
                AppHeader(header: locale.brandHeader),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                  ),
                  child: _BrandTextField(),
                ),
                AppHeader(header: locale.modelHeader),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                  ),
                  child: _ModelTextField(),
                ),
                AppHeader(header: locale.plateHeader),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                  ),
                  child: _PlateTextField(),
                ),
                AppHeader(header: locale.builtYearHeader),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                  ),
                  child: _BuiltYearTextField(),
                ),
                AppHeader(header: locale.modelYearHeader),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                  ),
                  child: _ModelYearTextField(),
                ),
                AppHeader(header: locale.priceHeader),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                  ),
                  child: _PriceTextField(),
                ),
                AppHeader(header: locale.datePurchaseHeader),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                  ),
                  child: _DatePicker(),
                ),
                AppHeader(header: locale.photoHeader),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                  ),
                  child: state.photoController.isNotEmpty
                      ? const _PhotosList()
                      : Container(),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                  ),
                  child: _ChooseOrTakePhoto(),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                  ),
                  child: _RegisterCarButton(),
                ),
              ],
            ),
          )),
    );
  }
}

class _NewCarTitle extends StatelessWidget {
  const _NewCarTitle();

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTitle(
            title: locale.vehicleRegisterTitle,
          ),
          AppTextDescription(
            text: locale.vehicleRegisterSubtitle,
          ),
        ],
      ),
    );
  }
}

class _BrandTextField extends StatelessWidget {
  const _BrandTextField();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<VehicleRegisterState>(context, listen: true);
    final locale = AppLocalizations.of(context)!;

    String? validator(String? value) {
      if (value!.isEmpty) {
        return locale.brandEmpty;
      }
      return null;
    }

    return AppTextFieldAutoComplete(
      controller: state.brandController,
      validator: validator,
      suggestions: state.allBrands,
    );
  }
}

class _ModelTextField extends StatelessWidget {
  const _ModelTextField();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<VehicleRegisterState>(context, listen: true);
    final locale = AppLocalizations.of(context)!;

    String? validator(String? value) {
      if (value!.isEmpty) {
        return locale.modelEmpty;
      }
      return null;
    }

    return AppTextFieldAutoComplete(
      controller: state.modelController,
      validator: validator,
      focusNode: state.modelFieldFocusNode,
      suggestions: state.allModels,
    );
  }
}

class _PlateTextField extends StatelessWidget {
  const _PlateTextField();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<VehicleRegisterState>(context, listen: true);
    final locale = AppLocalizations.of(context)!;

    String? validator(String? value) {
      if (value!.isEmpty) {
        return locale.plateEmpty;
      }
      return null;
    }

    return AppTextField(
      controller: state.plateController,
      validator: validator,
      hint: 'QTP5F71',
    );
  }
}

class _BuiltYearTextField extends StatelessWidget {
  const _BuiltYearTextField();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<VehicleRegisterState>(context, listen: true);
    final locale = AppLocalizations.of(context)!;

    String? validator(String? value) {
      if (value!.isEmpty) {
        return locale.builtYearEmpty;
      }
      if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
        return locale.onlyNumbers;
      }
      return null;
    }

    return AppTextField(
      controller: state.builtYearController,
      validator: validator,
      hint: '2022',
    );
  }
}

class _ModelYearTextField extends StatelessWidget {
  const _ModelYearTextField();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<VehicleRegisterState>(context, listen: true);
    final locale = AppLocalizations.of(context)!;

    String? validator(String? value) {
      if (value!.isEmpty) {
        return locale.modelYearEmpty;
      }
      if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
        return locale.onlyNumbers;
      }
      return null;
    }

    return AppTextField(
      controller: state.modelYearController,
      validator: validator,
      hint: '2023',
    );
  }
}

class _DatePicker extends StatelessWidget {
  const _DatePicker();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<VehicleRegisterState>(context, listen: true);
    final locale = AppLocalizations.of(context)!;

    String? validator(String? value) {
      if (value == null || value.isEmpty) {
        return locale.dateEmpty;
      }
      return null;
    }

    return AppTextField(
      controller: state.dateController,
      validator: validator,
      inputType: TextInputType.datetime,
      readOnly: true,
      hint: locale.pickDate,
      onTap: () async {
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (pickedDate != null) {
          final formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
          state.setPickedDate(formattedDate);
        }
      },
    );
  }
}

class _PriceTextField extends StatelessWidget {
  const _PriceTextField();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<VehicleRegisterState>(context, listen: true);
    final locale = AppLocalizations.of(context)!;

    String? validator(String? value) {
      if (double.parse((value!.replaceAll(RegExp(r','), ''))) == 0.00) {
        return locale.priceEmpty;
      }
      return null;
    }

    return AppTextField(
      controller: state.priceController,
      validator: validator,
      inputType: const TextInputType.numberWithOptions(decimal: true),
    );
  }
}

class _PhotosList extends StatelessWidget {
  const _PhotosList();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<VehicleRegisterState>(context, listen: true);

    return SizedBox(
      height: 100,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).focusColor,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: state.photoController.length,
          itemBuilder: (context, index) {
            return _PhotoWidget(
              imageName: state.photoController[index],
            );
          },
        ),
      ),
    );
  }
}

class _PhotoWidget extends StatelessWidget {
  const _PhotoWidget({required this.imageName});

  final String imageName;

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<VehicleRegisterState>(context, listen: true);

    return FutureBuilder<File>(
      // ignore: discarded_futures
      future: state.loadVehicleImage(imageName),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Image.file(snapshot.data!),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

class _ChooseOrTakePhoto extends StatelessWidget {
  const _ChooseOrTakePhoto();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<VehicleRegisterState>(context, listen: true);
    final locale = AppLocalizations.of(context)!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppSmallButton(
          onPressed: () async {
            await state.pickImage();
          },
          text: locale.choosePhoto,
        ),
        AppSmallButton(
          onPressed: () async {
            await state.takePhoto();
          },
          text: locale.takePhoto,
        )
      ],
    );
  }
}

class _RegisterCarButton extends StatelessWidget {
  const _RegisterCarButton();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<VehicleRegisterState>(context, listen: true);
    final mainState = Provider.of<MainState>(context, listen: false);
    final locale = AppLocalizations.of(context)!;

    Future<void> onPressed() async {
      if (!state.formState.currentState!.validate()) {
        return;
      }
      if (state.editing) {
        await state.update();
      } else {
        await state.insert();
      }
      if (context.mounted) {
        mainState.onItemTapped(0);
      }
    }

    return AppLargeButton(
      onPressed: onPressed,
      text: !state.editing ? locale.registerVehicle : locale.updateVehicle,
    );
  }
}

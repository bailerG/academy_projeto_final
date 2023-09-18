import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/vehicle_register_state.dart';
import '../utils/autocomplete_textfield.dart';
import '../utils/header.dart';
import '../utils/large_button.dart';
import '../utils/small_button.dart';
import '../utils/text_field.dart';

class VehicleRegisterScreen extends StatelessWidget {
  const VehicleRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => VehicleRegisterState(),
        child: const _VehicleRegisterStructure(),
      ),
    );
  }
}

class _VehicleRegisterStructure extends StatelessWidget {
  const _VehicleRegisterStructure();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<VehicleRegisterState>(context, listen: true);
    return SingleChildScrollView(
      child: Form(
          key: state.formState,
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppHeader(header: 'Brand'),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                  ),
                  child: _BrandTextField(),
                ),
                const AppHeader(header: 'Model'),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                  ),
                  child: _ModelTextField(),
                ),
                const AppHeader(header: 'Plate'),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                  ),
                  child: _PlateTextField(),
                ),
                const AppHeader(header: 'Built Year'),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                  ),
                  child: _BuiltYearTextField(),
                ),
                const AppHeader(header: 'Model Year'),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                  ),
                  child: _ModelYearTextField(),
                ),
                const AppHeader(header: 'Price'),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                  ),
                  child: _PriceTextField(),
                ),
                const AppHeader(header: 'Photo'),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                  ),
                  child: state.photoController != null
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

class _BrandTextField extends StatelessWidget {
  const _BrandTextField();

  String? validator(String? value) {
    if (value!.isEmpty) {
      return "Please inform the vehicle's brand";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<VehicleRegisterState>(context, listen: true);
    return AppTextFieldAutoComplete(
      controller: state.brandController,
      validator: validator,
      suggestions: state.allBrands,
    );
  }
}

class _ModelTextField extends StatelessWidget {
  const _ModelTextField();

  String? validator(String? value) {
    if (value!.isEmpty) {
      return "Please inform the vehicle's model";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<VehicleRegisterState>(context, listen: true);
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

  String? validator(String? value) {
    if (value!.isEmpty) {
      return "Please inform the vehicle's plate";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<VehicleRegisterState>(context, listen: true);
    return AppTextField(
      controller: state.plateController,
      validator: validator,
      hint: 'QTP5F71',
    );
  }
}

class _BuiltYearTextField extends StatelessWidget {
  const _BuiltYearTextField();

  String? validator(String? value) {
    if (value!.isEmpty) {
      return 'Please inform the year your vehicle was built';
    }
    if (value.contains(RegExp(r'[^a-z ]', caseSensitive: false))) {
      return 'Type only numbers';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<VehicleRegisterState>(context, listen: true);
    return AppTextField(
      controller: state.builtYearController,
      validator: validator,
      hint: '2022',
    );
  }
}

class _ModelYearTextField extends StatelessWidget {
  const _ModelYearTextField();

  String? validator(String? value) {
    if (value!.isEmpty) {
      return 'Please inform the model year of the vehicle';
    }
    if (value.contains(RegExp(r'[^a-z ]', caseSensitive: false))) {
      return 'Type only numbers';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<VehicleRegisterState>(context, listen: true);
    return AppTextField(
      controller: state.modelYearController,
      validator: validator,
      hint: '2023',
    );
  }
}

class _PriceTextField extends StatelessWidget {
  const _PriceTextField();

  String? validator(String? value) {
    if (double.parse((value!.replaceAll(RegExp(r','), ''))) == 0.00) {
      return "Price can't be zero";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<VehicleRegisterState>(context, listen: true);
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
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).focusColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Image.file(
                File(state.photoController!),
                height: MediaQuery.of(context).size.height / 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ChooseOrTakePhoto extends StatelessWidget {
  const _ChooseOrTakePhoto();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<VehicleRegisterState>(context, listen: true);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppSmallButton(
          onPressed: state.pickImage,
          text: 'Choose',
        ),
        AppSmallButton(
          onPressed: state.takePhoto,
          text: 'Take photo',
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

    void onPressed() {
      if (state.formState.currentState!.validate()) {
        state.insert();
      }
    }

    return AppLargeButton(
      onPressed: onPressed,
      text: 'Register Vehicle',
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/vehicle_register_state.dart';
import '../utils/header.dart';
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
    return const Form(
        child: Padding(
      padding: EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppHeader(header: 'Brand'),
          Padding(
            padding: EdgeInsets.only(
              top: 8,
              bottom: 8,
            ),
            child: _BrandTextField(),
          ),
          AppHeader(header: 'Model'),
          Padding(
            padding: EdgeInsets.only(
              top: 8,
              bottom: 8,
            ),
            child: _ModelTextField(),
          ),
          AppHeader(header: 'Plate'),
          Padding(
            padding: EdgeInsets.only(
              top: 8,
              bottom: 8,
            ),
            child: _PlateTextField(),
          ),
        ],
      ),
    ));
  }
}

class _BrandTextField extends StatelessWidget {
  const _BrandTextField();

  String? validator(String? value) {
    if (value!.isEmpty) {
      return "Please inform the vehicle's model";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<VehicleRegisterState>(context, listen: true);
    return AppTextField(
      controller: state.brandController,
      validator: validator,
      hint: 'Honda',
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
    return AppTextField(
      controller: state.modelController,
      validator: validator,
      hint: 'Civic',
    );
  }
}

class _PlateTextField extends StatelessWidget {
  const _PlateTextField();

  String? validator(String? value) {
    if (value!.isEmpty) {
      return "Please inform the vehicle's model";
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

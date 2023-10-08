import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../state/sale/sale_register_state.dart';
import '../../utils/header.dart';
import '../../utils/text_field.dart';

class SaleForm extends StatelessWidget {
  const SaleForm({
    super.key,
    required this.state,
  });

  final SaleRegisterState state;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: state.formState,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              top: 8.0,
            ),
            child: AppHeader(
              header: 'CPF',
              padLeft: 8.0,
            ),
          ),
          _CPFTextField(state: state),
          const Padding(
            padding: EdgeInsets.only(
              top: 20.0,
            ),
            child: AppHeader(
              header: 'Name',
              padLeft: 8.0,
            ),
          ),
          _NameTextField(state: state),
          const Padding(
            padding: EdgeInsets.only(
              top: 20.0,
            ),
            child: AppHeader(
              header: 'Date of Sale',
              padLeft: 8.0,
            ),
          ),
          _DateTextField(state: state),
          const Padding(
            padding: EdgeInsets.only(
              top: 20.0,
            ),
            child: AppHeader(
              header: 'Price Sold',
              padLeft: 8.0,
            ),
          ),
          _PriceTextField(state: state),
        ],
      ),
    );
  }
}

class _CPFTextField extends StatelessWidget {
  const _CPFTextField({
    required this.state,
  });

  final SaleRegisterState state;

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please write buyer's CPF";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: state.cpfController,
      validator: validator,
      hint: '123.456.789-10',
    );
  }
}

class _NameTextField extends StatelessWidget {
  const _NameTextField({
    required this.state,
  });

  final SaleRegisterState state;

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please write buyer's name";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: state.nameController,
      hint: 'John Doe',
    );
  }
}

class _DateTextField extends StatelessWidget {
  const _DateTextField({
    required this.state,
  });

  final SaleRegisterState state;

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a date';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: state.dateController,
      validator: validator,
      hint: '01/01/2023',
      onTap: () async {
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2023),
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
  const _PriceTextField({
    required this.state,
  });

  final SaleRegisterState state;

  String? validator(String? value) {
    if (double.parse((value!.replaceAll(RegExp(r','), ''))) == 0.00) {
      return "Price can't be zero";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: state.priceController,
      validator: validator,
      inputType: const TextInputType.numberWithOptions(
        decimal: true,
      ),
    );
  }
}

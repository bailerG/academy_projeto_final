import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../entities/sale.dart';
import '../../state/sale/sale_register_state.dart';
import '../../utils/header.dart';
import '../../utils/text_field.dart';

/// References the pop up widget of a [Sale] registration.
///
/// Users can provide the necessary data to register a sale.
/// This is not a page, but rather a pop up widget that shows on screen.
class SaleForm extends StatelessWidget {
  /// Constructs an instance of [SaleForm].
  /// [locale] and [state] parameters need to be given.
  const SaleForm({
    super.key,
    required this.locale,
    required this.state,
  });

  /// State controller to manage the form's state.
  final SaleRegisterState state;

  /// Refers to the language being utilized on the app.
  final AppLocalizations locale;

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
          _CPFTextField(state: state, locale: locale),
          Padding(
            padding: const EdgeInsets.only(
              top: 20.0,
            ),
            child: AppHeader(
              header: locale.nameHeader,
              padLeft: 8.0,
            ),
          ),
          _NameTextField(state: state, locale: locale),
          Padding(
            padding: const EdgeInsets.only(
              top: 20.0,
            ),
            child: AppHeader(
              header: locale.dateOfSale,
              padLeft: 8.0,
            ),
          ),
          _DateTextField(state: state, locale: locale),
          Padding(
            padding: const EdgeInsets.only(
              top: 20.0,
            ),
            child: AppHeader(
              header: locale.priceSold,
              padLeft: 8.0,
            ),
          ),
          _PriceTextField(state: state, locale: locale),
        ],
      ),
    );
  }
}

class _CPFTextField extends StatelessWidget {
  const _CPFTextField({
    required this.state,
    required this.locale,
  });

  final SaleRegisterState state;
  final AppLocalizations locale;

  @override
  Widget build(BuildContext context) {
    String? validator(String? value) {
      if (value == null || value.isEmpty) {
        return locale.cpfEmpty;
      }
      return null;
    }

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
    required this.locale,
  });

  final SaleRegisterState state;
  final AppLocalizations locale;

  @override
  Widget build(BuildContext context) {
    String? validator(String? value) {
      if (value == null || value.isEmpty) {
        return locale.nameEmpty;
      }
      return null;
    }

    return AppTextField(
      controller: state.nameController,
      validator: validator,
      hint: locale.nameHint,
    );
  }
}

class _DateTextField extends StatelessWidget {
  const _DateTextField({
    required this.state,
    required this.locale,
  });

  final SaleRegisterState state;
  final AppLocalizations locale;

  @override
  Widget build(BuildContext context) {
    String? validator(String? value) {
      if (value == null || value.isEmpty) {
        return locale.dateEmpty;
      }
      return null;
    }

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
    required this.locale,
  });

  final SaleRegisterState state;
  final AppLocalizations locale;

  @override
  Widget build(BuildContext context) {
    String? validator(String? value) {
      if (double.parse((value!.replaceAll(RegExp(r','), ''))) == 0.00) {
        return locale.priceEmpty;
      }
      return null;
    }

    return AppTextField(
      controller: state.priceController,
      validator: validator,
      inputType: const TextInputType.numberWithOptions(
        decimal: true,
      ),
    );
  }
}

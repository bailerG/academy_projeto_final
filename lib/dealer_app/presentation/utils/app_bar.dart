import 'package:flutter/material.dart';

/// App bar with centered logo.
PreferredSizeWidget myAppBar(BuildContext context) {
  return AppBar(
    title: Image.asset(
      'assets/logo.png',
      height: MediaQuery.sizeOf(context).height / 7,
    ),
    centerTitle: true,
  );
}

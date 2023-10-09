import 'package:flutter/material.dart';

PreferredSizeWidget myAppBar(BuildContext context) {
  return AppBar(
    title: Image.asset(
      'assets/logo.png',
      height: MediaQuery.sizeOf(context).height / 7,
    ),
    centerTitle: true,
  );
}
